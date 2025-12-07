// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract AddNumbers {
    uint256 public addResult;

    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function addSave(uint256 a, uint256 b) public {
        addResult = a + b;
    }
}

contract AddNumbersAssembly {
    uint256 public addResult;

    function add(uint256 a, uint256 b) public pure returns (uint256 result) {
        assembly {
            result := add(a, b)
        }
    }

    function addSave(uint256 a, uint256 b) public {
        assembly {
            let sum := add(a, b)
            sstore(addResult.slot, sum)
        }
    }
}

contract AddNumbersInPureYul {
    address public owner;
    uint256 public value;
    uint256 public valueSave;

    constructor() {
        assembly {
            sstore(owner.slot, caller())
            sstore(value.slot, callvalue())
        }
    }

    function add(uint256 a, uint256 b) public pure returns(uint256){
        assembly{
            let sum := add(a,b)
            mstore(0x00,sum)
            return (0x00, 0x20)
        }
    }

    function addSave(uint256 a, uint256 b) public{
        assembly{
            let sum := add(a,b)
            sstore(valueSave.slot,sum)
        }
    }
}

contract storeNoInMemory {
    function save(uint256 a, uint256 b) public pure returns (uint256, uint256) {
        assembly {
            let res := add(a,b)
            let res1 := add(res,1)

            // Store in memory
            mstore(0x00, res)      // first 32 bytes
            mstore(0x20, res1)     // second 32 bytes

            // Return 64 bytes (two uint256)
            return(0x00, 0x40)
        }
    }
}

function addThree(uint256 a, uint256 b, uint256 c) public pure returns (uint256, uint256, uint256) {
    assembly {
        let res1 := add(a,b)
        let res2 := add(b,c)
        let res3 := add(a,c)

        mstore(0x00, res1)
        mstore(0x20, res2)
        mstore(0x40, res3)

        return(0x00, 0x60) // return all 3 variables (3*32 bytes)
    }
}

