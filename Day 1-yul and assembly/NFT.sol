// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title Yul Batch NFT Minter
 * @dev Gas-optimized batch minting of NFTs using inline Yul
 */
contract YulBatchNFT {
    // Owner
    address public immutable OWNER;
    
    // Total minted NFTs
    uint256 public totalMinted;

    // Mapping from tokenId => owner (stored manually in storage)
    mapping(uint256 => address) private _owners;

    // Event for NFT Mint (log4 used in Yul)
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    modifier onlyOwner() {
        require(msg.sender == OWNER, "Only owner");
        _;
    }

    constructor() {
        OWNER = msg.sender;
        totalMinted = 0;
    }

    /**
     * @dev Batch mint NFTs
     * @param recipients Array of addresses to receive NFTs
     * @param tokenIds Array of token IDs
     */
    function batchMint(address[] memory recipients, uint256[] memory tokenIds) public onlyOwner {
        require(recipients.length == tokenIds.length, "Arrays must match");
        uint256 count = recipients.length;

        for (uint256 i = 0; i < count;) {
            _mintYul(recipients[i], tokenIds[i]);
            unchecked { ++i; }
        }

        totalMinted += count;
    }

    /**
     * @dev Mint a single NFT using Yul for storage and event emission
     */
    function _mintYul(address to, uint256 tokenId) internal {
        assembly {
            // Storage slot of _owners mapping
            mstore(0x00, tokenId)
            mstore(0x20, _owners.slot)
            let slot := keccak256(0x00, 0x40)
            
            // Store owner address in storage
            sstore(slot, to)
            
            // Emit Transfer event manually via log4 (from 0x0 to recipient, tokenId)
            log4(
                0x00, // data offset (empty data)
                0x00, // data size
                0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef, // Transfer event signature
                0x0, // from = zero address
                to,   // to = recipient
                tokenId // tokenId
            )
        }
    }

    /**
     * @dev View owner of tokenId
     */
    function ownerOf(uint256 tokenId) public view returns (address ownerAddr) {
        assembly {
            mstore(0x00, tokenId)
            mstore(0x20, _owners.slot)
            let slot := keccak256(0x00, 0x40)
            ownerAddr := sload(slot)
        }
    }
}
