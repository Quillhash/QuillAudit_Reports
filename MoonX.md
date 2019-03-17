# MoonX Smart Contracts Audit Report

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/MoonX.jpg)

>We've been asked by the **MoonX** team to review and audit their smart contracts.

>by QuillAudits, March 2019

## Introduction :

This Audit Report highlights the overall security of **MoonMoneyChain** Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract code-base.

**Auditing Approach and Methodologies applied :**

**Quillhash** team has performed thorough testing of the project starting with analysing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.

Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks.

In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.
The code was tested in collaboration of our multiple team members and this included -
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.

```
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.

Deploying the code on test-net using multiple clients to run live tests

Analyzing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.

Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.
```

## Audit Details
```
Project Name: MOON MONEY CHAIN
Client Name: Nithin palavalli
website/Etherscan Code : https://moon.family
Languages: Solidity(Smart contract), JavaScript(Unit Testing)
```

# Summary of moon money chain Smart Contract :

**QuillAudits** conducted a security audit of a smart contract of Moonx. Moon money chain contract is used to create the ERC20 token which is a MM token, Smart contract contain basic functionalities of ERC20 token with total supply of 2400 million.

## Audit Goals

The focus of the audit was to verify that the smart contract system is secure, resilient and working according to its specifications. The audit activities can be grouped in the following three categories:

**Security:** Identifying security related issues within each contract and within the system of contracts.

**Sound Architecture:** Evaluation of the architecture of this system through the lens of established smart contract best practices and general software best practices.

**Code Correctness and Quality:** A full review of the contract source code. 

**The primary areas of focus include:**

```
Correctness
Readability
Sections of code with high complexity
Quantity and quality of test coverage
```
![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/MoonX_chart.png)

# Security Level references :

Every issue in this report was assigned a severity level from the following:

**High severity issues will bring problems and should be fixed.**

**Medium severity issues could potentially bring problems and should eventually be fixed.**

**Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.**


## High severity issues:-

No High Severity Issue.

## Medium Severity Issues:-

No Medium Severity Issue.

## Low Severity Issues:-

1. Solidity version must be fixed (Always use latest Version).

It should not pragma solidity ^0.5.0;
It should be pragma solidity 0.5.0;

**Status :** Not an issue as contract is already deployed on Mainnet with same development and deployment version.

version should be fixed so that development phase and deployment phase should have same solidity version.

2. Use safe math library operation at all places.
Line 190 transferFrom() function, safe math operation is not used to subtract allowance.
Status : Not considered as an issue because multiple checks are already used before transferring tokens.

3. Name of a token in smart contract is contradict with name of token in a doc you filled.

Name of a token in Contract : "MM Moon Money"
Name of a token in document : "Moon Money Chain"

**Status :** Not considered as an issue.

(as conveyed by development team of MoonX, Code that has been provided to us for security audit may be different from the code that is on Mainnet and token name is correct on Mainnet.)

# Unit Testing

## Test Suite

## Contract: Moon Money Token
```
✓ Should correctly initialize constructor values of MoonX Token Contract (168ms)
✓ Should check the Total Supply of Moon Money Tokens (65ms)
✓ Should check the Name of a token of Moon Money contract (49ms)
✓ Should check the symbol of a token of Moon Money contract (42ms)
✓ Should check the decimal of a token of Moon Money contract (58ms)
✓ Should check the Owner of a Moon Money token contract (39ms)
✓ Should check the balance of a Owner (40ms)
✓ Should Not be able to transfer tokens to accounts[1] without having token (160ms)
✓ Should be able to transfer tokens to accounts[1] (313ms)
✓ should Approve address[3] to spend specific token on the behalf of owner (129ms)
✓ Should be able to transfer tokens to accounts[3] it self after approval from accounts[0] (315ms)
✓ Should Not be able to transfer ownership of Moon Money token Contract from Non Owner Account (301ms)
✓ Should be able to transfer ownership of MoonX token Contract (199ms)
✓ Should Not be able to accept Ownership of token contract (179ms)
✓ Should be able to accept Ownership of token contract (142ms)
✓ Should Not be able to burn tokens more than balance (207ms)
✓ Should be able to burn tokens (145ms)
✓ Should correctly initialize constructor values of sample Token Contract (120ms)
✓ Should check the balance of a sample contract Owner
✓ Should be able to transfer sample tokens to MM token contract (401ms)
✓ Should be able to transfer sample tokens to owner of mm tokens, sent to contract of mm tokens (275ms)
```
## Final Result of Test:

✓ 20 Passing (3s) PASSED

❌ 0 Failed

## Coverage Report :

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/MoonX_Coverage.png)

TokenA is a sample contract use to check functionality of transfer ERC20 tokens function.

## Slither Tool Result :

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/MoonX_Sparkle.png)

## Implementation Recommendations :

You can Use pausable library to stop functionalities of smart contract in case of attack on smart contract.

Remove unnecessary code while deploying on main net.

## Comments:

Use case of smart contract is very well designed and Implemented.Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. MoonX development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation.
All the low severity issues either not considered as an issue by MoonX development or not an valid issue as code is already deployed on Mainnet.
Note : Code that has been provided to us for security audit is secure and all the issues raised in initial audit is closed.

# Transaction hashes
## Network : rinkeby
```
Contract creation : 0x8f5502fb08f74cef7f2ecbd37afa36317bc3e39865fe229bf5a2f37d361208ec
Transfer tokens : 0x6ab77473cf529db7f209a46c53f81974f75192064cf004265fbdef61dd2a7716
Approve : 0xf5f5729791b87e48667da71d0c7f0b1f8d90ba23afc07376e50d5c471e026b73
Send ether to token contract (Should fail ): 0xd439077b3707154b39a64bdd62f7a0973e5590d9ec83712f2bf696d6631500e0
transferFrom :0x1914e66e3ced288ecb7c9bed412b6339d344f55881abf7abb66529a30ec43059
transferOwnership : 0xd374fc752aeaa0c0fd4c39891cbfbe597d7c5e1c89f608a4738f2787bba2a863
acceptOwnership: 0x4ec5bdbe76d4280ca4c66be5a0562e789d2d0bcb6668bfbff2245a06bc5bc430
Burn tokens : 0x99375a0f74d872ef83c282b98b7294aa414174acef96deb0586c3b7d19fcb092
Tokens(Sample tokens) transfer to MM token contract
0x7d69373b29dd6281ff987286dcdca172063ab915f2d402fa5d9b615a1afa3e6d
transferAnyERC20Tokens
0xc54934d8ef31a8f56868ed82439df6c4c512c3365c8623620afc636df239a873
```

**Initial Audit Report :** 10th March 2019.

**Initial Audit Report feedback by MoonX :** 10th March 2019.

**Final Audit Report (Review of Initial Audit report Fixes) :** 11th March 2019

## You can request for Audit by filling a form :

https://quillhash.typeform.com/to/KQ5Hhm


