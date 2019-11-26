# NTOKENS SMART CONTRACT AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Digipharm.png)

>We've been asked by the **NTOKENS** team to review and audit their smart contracts.

>by QuillAudits, October 2019

## Introduction :

This Audit Report highlights the overall security of **NTOKENS** Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract code base.

**Auditing Approach and Methodologies applied :**

**Quillhash** team has performed thorough testing of the project starting with analysing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.

Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks.

In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.
The code was tested in collaboration of our multiple team members and this included -
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.

```
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.

Deploying the code on testnet using multiple clients to run live tests

Analyzing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.

Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.

```

## Audit Details

**Project Name:** NTOKEN
**website/Etherscan Code :** https://ntokens.com
**Languages:** Solidity(Smart contract), JavaScript(Unit Testing)

## Summary of Ntokens Smart Contract :

QuillAudits conducted a security audit of a smart contract of NTokens. NTokens contract is used to create the ERC20 token which is a nTokens Real Virtual stable coin, Smart contract contain basic functionalities of ERC20 token with open mint to mint tokens and some more functionalities like.

>Masterminter can allow other address to mint till specific value.

>Owner can blacklist token holders and minters

>Transfer will not take place when contract is paused by pauser only

## Audit Goals

The focus of the audit was to verify that the smart contract system is secure, resilient and working according to its specifications. The audit activities can be grouped in the following three categories:

**Security :** Identifying security related issues within each contract and within the system of contracts.

**Sound Architecture :** Evaluation of the architecture of this system through the lens of established smart contract best practices and general software best practices.

**Code Correctness and Quality :** A full review of the contract source code. The primary areas of focus include:

```
Correctness

Readability

Sections of code with high complexity

Quantity and quality of test coverage

```

## Security Level references :

Every issue in this report was assigned a severity level from the following:

**High severity issues will bring problems and should be fixed.**

**Medium severity issues could potentially bring problems and should eventually be fixed.**

**Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.**

## High severity issues:-

1. **initialize()** function of smart contract v1 doesn't use modifier onlyOwner, it can be called by anyone, immediately after deploying a smart contract.

Either use onlyOwner modifier so that only the owner can initialize it or simply create a variable (address type) and set it while deploying a smart contract who will going to call a function initialize().

**Status :** Fixed by Developer

2. **increaseAllowance** and **decreaseAllowance** function of ERC20 contract couldn't update the value of allowance as allowed is overwritten in v1 smart contract that value doesn't accessible by increase and decrease allowance function in ERC20 smart contract.
Update or overwrite allowance functions in v1 smart contracts to increase or decrease the allowance using increaseAllowance and decreaseAllowance.

**Status :** Fixed by Developer

## Medium Severity Issues:-

No Medium Severity Issue.

## Low Severity Issues:-

1. Solidity version must be fixed (Always use latest Version).

It should not pragma solidity ^0.4.24;
It should be pragma solidity 0.4.24;

**Status :** Fixed by Developer.

2. version should be fixed so that development phase and deployment phase should have the same solidity version.

Missing all the error statements in required condition. Please use error statements in required condition to configure the error reason.

Example : require (msg.sender == owner, 'Caller is not an owner of smart contract').

**Status :** Not fixed Yet.

3. removeMinter() function of smart contract v1 doesn't check whether a minter is already configured or not.

Use require(minters[minter] == true);

**Status :** Fixed by Developer.

4. unBlacklist() function of smart contract blacklistable.sol doesn't check whether an address is already blacklisted or not before removing it.

Use require(blacklisted[_account] == true);

**Status :** Fixed by Developer.

5. pause() function of smart contract pausable.sol doesn't check whether a contract is already paused or not.

Use require(paused == false);

**Status :** Fixed by Developer.

6. unPause() function of smart contract pausable.sol doesn't check whether a contract is already paused or not.

Use require(paused == true);

**Status :** Fixed by Developer.

**Low Severity Issues arises while checking Initial Audit report:-**

TransferFrom() function of smart contract v1 could not be able to call by tokens holder as approve and allowance has been removed from contract v1.

You can remove function transferFrom() from contract v1 also remove allowed internal variable from 
**contract v1 as they are not in use as well as from ERC20.sol contract.**

**Status : Not fixed Yet.**

## Unit Testing

**Test Suite**

**Contract: Digipharm Token Contracts**

```
Should check masterMinter of Token contract after update (51ms)
✓ Should check blackLister or not
✓ Should check blackLister or not
✓ Should not add blackLister by non blacklistAdmin (42ms)
✓ Should add blackLister (67ms)
✓ Should check blackLister or not after blacklist is added
✓ Should Not remove blackLister by non blacklister account (44ms)
✓ Should be able to pause Token contract (158ms)
✓ Should Not remove blackLister when it is paused (100ms)
✓ Should be able to unpause Token contract (137ms)
✓ Should remove blackLister (56ms)
✓ Should check blackLister or not after blacklist is removed
✓ Should check blackLister of Token contract before update
✓ Should Not Update master minter by Non owner (40ms)
✓ Should Update master minter by owner only (66ms)
✓ Should check blackLister of Token contract after update
✓ Should Not be able to transfer ownership of token Contract by non owner account (54ms)
✓ Should check Owner of Token contract before transfering ownership (41ms)
✓ Should be able to transfer ownership of token Contract (140ms)
✓ Should check Owner of Token contract after transferring ownership
✓ Should not be able to mint tokens by non minter (54ms)
✓ Should check totalSupply of Token contract before minting
✓ Should not be able to mint tokens by minter only more then allowed (44ms)
✓ Should check balance of accounts[6] before minting
✓ Should be able to mint tokens by minter only (79ms)
✓ Should check totalSupply of Token contract before minting
✓ Should check balance of accounts[6]
✓ Should check balance of a minter before minting for self
✓ Should be able to mint tokens by minter only to itself (121ms)
✓ Should check total Supply of Token contract before minting
✓ Should check balance of accounts[4] (42ms)
✓ Should check totalSupply of Token contract before burning token
✓ Should be able to pause Token contract (183ms)
✓ Should Not be able to burn tokens when not paused (38ms)
✓ Should be able to unpause Token contract (127ms)
✓ Should be able to burn tokens by minter only of itself (83ms)
✓ Should check balance of accounts[4] after burning tokens
✓ Should check totalSupply of Token contract after burning token
✓ Should Not be able to burn tokens by Non minter of itself
✓ Should check minter or not before removing minter
✓ Should not be able remove minter by master minter only)
✓ Should remove minter by master minter only) (77ms)
✓ Should check Minter allowance
✓ Should check minter or not after removing minter
✓ Should not be able to transfer Tokens when a user doesnt have tokens (63ms)
✓ Should not be able to transfer Tokens more than a balance have (85ms)
✓ Should be able to pause Token contract (103ms)
✓ Should not be able to transfer Tokens when it is paused (91ms)
✓ Should be able to unpause Token contract (116ms)
✓ Should be able to transfer Tokens (128ms)
✓ should check Allowance of address to spend specific token before approving
✓ should Approve address to spend specific token (68ms)
✓ should check Allowance of address to spend specific token After approving
✓ Should check pauser of Token contract before update
✓ Should Not Update pauser by Non owner account (42ms)
✓ Should Update pauser by owner only (58ms)
✓ Should check pauser of Token contract after update
✓ Should be able to pause Token contract (130ms)
✓ Should not be able to transferFrom Tokens when it is paused (82ms)
✓ Should be able to unpause Token contract (108ms)
✓ Should be able to transfer Tokens on the behalf of accounts[6] to itself accounts[7] (156ms)
✓ Should Not initializeToken contract by non owner account(193ms)
✓ Should Not be able to pause smart contract when already paused(100ms)
✓ Should Not be able to unPause smart contract when already unpaused(100ms)
✓ Should Not be able to remove minter when minter is not configured(100ms).
✓ Should Not be able to unblacklist address when address is not blacklisted(100ms).

Contract: Ntokens Contract check failed test cases

❎ Should not be able to call transferFrom function of contract v1 (Failed)(100ms).

```

**Final Result of Test:**

✓ 93 Passing (6s) PASSED

❌ 1 Failed

## Coverage Report :

**Initial Audit Report (Coverage Report):** 

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/digicr1.png)

**Final Audit Report (Coverage Report):**

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/digicr2.png)


![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/digicr3.png)


Smart contract v1 statement covered is 87.3% in final audit report because transferFrom function of v1 contract is needed to remove as it can’t be accesible as you can see in the above picture, transferFrom function is highlighted uncovered .


## Slither Tool Result :

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/digi_slither2.png)


![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/digi_slither1.png)


## File Description table

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/digi_table.png)

## Implementation Recommendations :

Use error statements in return when using require this will help in diagnosing errors or the reason for the failure of transactions.

## Comments:

Use case of smart contract is very well designed and Implemented. Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. NTokens development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation .
All critical issue and several additional issues have been solved by NTokens team, please take action on 1 low severity issue as well that arises after initial audit fixes.

**You can request for Audit by filling a form :**

https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier audit reports.

**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.

