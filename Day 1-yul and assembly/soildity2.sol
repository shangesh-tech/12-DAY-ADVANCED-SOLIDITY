// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract FreeMemoryExample {
    function storeAndReturn(uint256 val) public pure returns (uint256) {
        assembly {
            // 1. Load the free memory pointer (points to next available memory)
            let ptr := mload(0x40)

            // 2. Store 'val' at free memory location
            mstore(ptr, val)

            // 3. Update free memory pointer to next free slot (32 bytes ahead)
            mstore(0x40, add(ptr, 0x20))

            // 4. Return the value (32 bytes from ptr)
            return(ptr, 0x20)
        }
    }
}

contract AddFromCalldata {
    function add() public pure returns (uint256 result) {
        assembly {
            // Solidity ABI encoding:
            // calldata layout for first uint256 argument:
            // offset 0-3: function selector (first 4 bytes)
            // offset 4-35: first uint256 argument
            // offset 36-67: second uint256 argument

            let arg1 := calldataload(4)  // read first argument
            let arg2 := calldataload(36) // read second argument

            result := add(arg1, arg2)    // add them

            // return 32 bytes of result
            mstore(0x00, result)
            return(0x00, 0x20)
        }
    }
}

contract PackTwoUint256 {
    function encodeTwo() public pure returns (bytes memory) {
        assembly {
            // For demonstration, let's assume a=5, b=10
            let a := 5
            let b := 10

            // Load free memory pointer
            let ptr := mload(0x40)

            // Store a at memory offset ptr
            mstore(ptr, a)

            // Store b at memory offset ptr + 32 bytes
            mstore(add(ptr, 0x20), b)

            // Update free memory pointer (32 bytes + 32 bytes = 64 bytes)
            mstore(0x40, add(ptr, 0x40))

            // Return memory region (ptr, 64 bytes)
            return(ptr, 0x40)
        }
    }
}
