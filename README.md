
---

Decentralized Election System 2026 

**Author:** Arbel Koren 

**Project Type:** Final project for Blockchain Course 

## Overview

A transparent, reliable, and immutable election system built on the **Ethereum Blockchain**. The system ensures security through cryptographic verification and incentivizes participation using a custom digital token.

## 🚀 Key Features

* 
**Decentralized Voting:** Secure and transparent voting process powered by Solidity smart contracts.


* 
**Voter Eligibility (Merkle Tree):** Uses Merkle Proofs to verify voter eligibility without exposing the entire voter list on-chain.


* 
**Incentive Mechanism:** Voters automatically receive **10 BAL Tokens** as a reward after successfully casting a vote.


* 
**Smart Bot Algorithm:** A "Smart Choice" feature that matches undecided voters with the best-fitting candidate based on a preference algorithm.


* 
**Real-time Integration:** Frontend tracks MetaMask accounts, BAL balances, and election timers in real-time.



## 🛠 Tech Stack

* 
**Smart Contracts:** Solidity (^0.8.19).


* 
**Frontend:** HTML5, CSS3, and Web3.js.


* 
**Wallet:** MetaMask integration.


* 
**Network:** Designed for the **Sepolia Testnet**.



## 📜 Smart Contracts

1. BalToken.sol (ERC20) 

A standard digital token used for rewarding participants.

* 
**Name:** BalToken.


* 
**Symbol:** BAL.


* 
**Decimals:** 18.


* 
**Initial Supply:** 1,000,000 BAL.



2. Election.sol (Core Logic) 

Manages the election lifecycle and candidate data.

* 
**Candidate Management:** Admins can add candidates with specific "opinion rankings" (1-10).


* 
**Merkle Verification:** Validates that only authorized addresses can vote.


* 
**Election Timer:** Enforces a strict voting window.



## 🤖 The "Smart Choice" Algorithm

The system includes an algorithm to calculate the mathematical "distance" between a voter's preferences and a candidate's opinions across three different topics.

The score is calculated as:


$$score = \sum_{i=1}^{3} |UserOp_{i} - CandOp_{i}|$$



The system automatically suggests the candidate with the **lowest score** (the shortest distance).

⚠️ Known Limitations & Bugs 

* 
**Gas Efficiency:** Merkle Root/Proof calculations are currently performed on-chain for demonstration purposes; in production, these should be handled off-chain to save gas.


* **Sorting:** Candidates are displayed by their ID (order of addition). Sorting by vote count is handled on the client side.


* 
**Security:** For a live production environment, an admin MultiSig wallet is recommended over a single MetaMask account.



---

