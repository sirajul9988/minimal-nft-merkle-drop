# Minimal NFT Merkle Drop

This repository provides a professional-grade NFT smart contract with a Merkle Tree whitelist. It solves the "gas problem" of whitelisting by verifying eligibility via a cryptographic hash rather than an expensive on-chain array.

## How it Works
1. Generate a Merkle Root from your list of addresses.
2. Set the root in the contract.
3. Users provide a `bytes32[] proof` during the minting process to verify their inclusion.

## Technical Stack
- **Solidity 0.8.20**
- **OpenZeppelin Contracts**
- **Merkle Proof Verification**

## License
MIT
