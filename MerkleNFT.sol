// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MerkleNFT
 * @dev ERC721 token with Merkle Tree whitelist verification.
 */
contract MerkleNFT is ERC721, Ownable {
    bytes32 public merkleRoot;
    mapping(address => bool) public hasMinted;

    constructor(string memory name, string memory symbol, bytes32 _merkleRoot) 
        ERC721(name, symbol) 
        Ownable(msg.sender) 
    {
        merkleRoot = _merkleRoot;
    }

    /**
     * @dev Mint a token if the sender is in the Merkle Tree whitelist.
     * @param proof The Merkle Proof provided by the user.
     * @param tokenId The ID to be minted.
     */
    function mint(bytes32[] calldata proof, uint256 tokenId) external {
        require(!hasMinted[msg.sender], "Already minted");
        
        // Verify the proof
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid Merkle Proof");

        hasMinted[msg.sender] = true;
        _safeMint(msg.sender, tokenId);
    }

    /**
     * @dev Update the Merkle Root for new whitelist batches.
     */
    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }
}
