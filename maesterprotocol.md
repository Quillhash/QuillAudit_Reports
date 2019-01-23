  #      MAESTER PROTOCOL SMART CONTRACTS AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Maester-Protocol.jpg)

>We've been asked by the MaesterProtocol team to review and audit their smart contracts.

We at **QuillAudits** are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract codebase.

by **QuillAudits**, October 2018

## Introduction

This Audit Report highlights the overall security of MaesterProtocol. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract codebase.

## Auditing Approach and Methodologies applied -

QuillAudit team has performed thorough testing of the project starting with analyzing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.
Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks
.
In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.

**The code was tested in collaboration of our multiple team members and this included -**

```
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.
Deploying the code on testnet using multiple clients to run live tests.
Analyzing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.
Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.
```

## Summary of MaesterProtocol Smart Contract -

The **MaesterProtocol** Smart contract is functionally an ERC-20 Smart Contract. The smart contract has all the functions of an ERC20 standard with the addition of a function of Crowdsale.

# Security Level references :

> Every issue in this report was assigned a severity level from the following:

**High severity issues will probably bring problems and should be fixed.**

**Medium severity issues could potentially bring problems and should eventually be fixed.**

**Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.**

# Unit Testing

## Test cases:

**Contract: MAP Contract, Crowdsale Contract**
```
 ✓ Should correctly initialize constructor values of Maester protocol Token Contract (561ms)
 ✓ Should Deploy Crowdsale only (193ms)
 ✓ Should Activate Sale contract (142ms)
 ✓ Should Listing Vesting Tokens for team (151ms)
 ✓ Should check balance of Crowdsale after, crowdsale activate from token contract (53ms)
 ✓ Should Start PreSale (124ms)
 ✓ Should be able to buy Tokens according to preSale (8922ms)
 ✓ Should be able to end pre sale ,start Crowd sale round One and buy tokens according to that (4290ms)
 ✓ Should be able to end Crowdsale Round one ,start Crowd sale round Two and buy tokens according to that (5009ms)
 ✓ Should be able to end Crowdsale Round two ,start Crowd sale round Three and buy tokens according to that (3695ms)
 ✓ Should be able to end Crowdsale Round three, and Check balace of crowdsale contract (249ms)
 ✓ Should Pause and restart Crowdsale (345ms)
 ✓ Should be able to set ether price (131ms)
 ✓ Should revert if owner tries to transfer zero bounty (125ms)
 ✓ Should revert if user tries to send Negative Bounty Tokens (123ms)
 ✓ Should send Bounty Tokens (186ms)
 ✓ Should Burn account[9] Bounty Tokens (212ms)
 ✓ Should return if User tries to Burn Negative tokens (111ms)
 ✓ Should return if User tries to Burn zero tokens (251ms)
 ✓ Should Check if SoftCap Reached or not (183ms)
 ✓ Should send advisors Tokens (228ms)
 ✓ Should Get Vesting Period Number (79ms)
 ✓ Should send Team Tokens (327ms)
 ✓ Should be able to transfer ownership of Token Contract (396ms)
 ✓ Should be able to transfer Tokens from one beneficeary to another when token lock period is over (293ms)
 ✓ should Approve address to spend specific token (107ms)
 ✓ should increase Approval (166ms)
 ✓ should decrease Approval (186ms)
 ✓ should not increase Approval for Negative Tokens
 ✓ should Not Approve address to spend Negative token
```


## Comments:

Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. MaesterProtocol development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation.
We found some critical issue and several additional issues that require the attention of the MaesterProtocol team. Given the subjective nature of some assessments, it will be up to the MaesterProtocol team to decide whether any changes should be made.


##You can request for Audit by filling a form :
https://quillhash.typeform.com/to/KQ5Hhm


Thanks for reading. Also do check out our earlier blog posts.
**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.
