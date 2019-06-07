# DIGIPHARM SMART CONTRACT AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Digipharm.png)

>We've been asked by the **Digipharm** team to review and audit their smart contracts.

>by QuillAudits, April 2019

## Introduction :

This Audit Report highlights the overall security of **Digipharm** Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract code base.

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

**Project Name:** DIGIPHARM
**website/Etherscan Code :** https://www.digipharm.io
**Languages:** Solidity(Smart contract), JavaScript(Unit Testing)

## Summary of Digipharm Smart Contract :

**QuillAudits** conducted a security audit of a smart contract of Digipharm. Digipharm contract is used to create the ERC20 token which is a DIGIPHARM TOKEN, Smart contract contain basic functionalities of ERC20 token with total supply of 1 billion and some advance functionalities.

>Stop transfer functionality (by owner of contract)

>Start/Resume transfer functionality (by owner of contract)

>Lock transfer functionality for particular user, that required amount of tokens to be lock and time to release tokens that are locked.

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

**canBeTransfered()** function of Digipharmtoken.sol contract Should be converted to a view function because this function is only responsible for returning Boolean value and doesn't alter storage state in any way.

When you don't use view modifier then that function is considered as setter function which means that function is intended to update the storage of smart contract and to call that function Gas will be required, on the other hand if you use view functionality that will consider function as getter function which means that function is only reading from smart contract storage and doesn't required gas to call function. This function is only reading from smart contract storage so it must be converted to view function.

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/issueDigipharm.png)

As you can see in the above pictures, picture 1 (pink one) depicts that when you don't use view modifier then that function is considered as a setter function also in return you will not get the result, but when view modifier is used function will be converted into getter function and no transaction cost is required to get data.

**Status :** Fixed by developer

## Medium Severity Issues:-

No Medium Severity Issue.

## Low Severity Issues:-

1. Solidity version must be fixed (Always use latest Version).

It should not pragma solidity ^0.4.24;
It should be pragma solidity 0.4.24;

**Status :** Fixed by developer

version should be fixed so that development phase and deployment phase should have the same solidity version.

2. Constructor of Contract ownable.sol is declared as of its contract name - function ownable(), declaring constructor as a same name of function is deprecated use constructor() .

**Status :** Fixed by developer

3. Invoking event without "emit" prefix is deprecated use emit while invoking events at all places.

**Example :**
**Contract :** MintableToken.sol
**Event :** Mint(), Transfer(), MintFinished().

**Status :** Fixed by developer

4. Always use access modifier public/private/external/internal while declaring functions, In DigipharmToken.sol Contract six functions doesn't contain access modifiers.

**Functions :** burn(), burnFrom(), canBeTransfered(), transfer(), stopTransfer(), resumeTransfer().

```
burn(uint256 _value) public onlyOwner
burnFrom(uint257 _value, address victim) public onlyOwner
canBeTransfered(address victim, uint256 _value) public view
transfer(address _to, uint256 _value) public
stopTransfer() public onlyOwner
resumeTransfer() public onlyOwner
```

**Status :** Fixed by developer

## Unit Testing

**Test Suite**

**Contract: Digipharm Token Contracts**

```
✓ Should correctly initialize constructor values of Digipharm Token Contract (174ms)
✓ Should check the Total Supply of DIGIPHARM TOKEN (44ms)
✓ Should check the Maximum Total Supply of DIGIPHARM TOKEN (56ms)
✓ Should check the Name of a token of DIGIPHARM TOKEN (60ms)
✓ Should check the symbol of a token of DIGIPHARM TOKEN (46ms)
✓ Should check the decimal of a token of DIGIPHARM TOKEN (52ms)
✓ Should check the Owner of a DIGIPHARM TOKEN contract (39ms)
✓ Should check the balance of a Owner (57ms)
✓ Should check transferred allowed or Not (46ms)
✓ Should not be able to Mint token by Non Owner account (169ms)
✓ Should Mint token by Owner to Account [1] (302ms)
✓ Should check the balance of a Account [1] after minting
✓ Should check the Total Supply of DIGIPHARM TOKEN after Minting Token (40ms)
✓ Should not be able to burn tokens of Account [1] more than account balance (91ms)
✓ Should not be able to burn tokens of Account [1] by Non owner Account (111ms)
✓ Should be able to burn tokens of Account [1] by owner only (136ms)
✓ Should check the balance of a Account [1] after tokens burned by Owner (92ms)
✓ Should check the Total Supply of DIGIPHARM TOKEN after tokens are burned
✓ Should be able to Mint tokens by Owner to Owner (362ms)
✓ Should check the balance of a Account [0] after minting
✓ Should check the Total Supply of DIGIPHARM TOKEN after Minting Token
✓ Owner Should be able to burn tokens using function Burn (225ms)
✓ Should check the balance of Owner after burn
✓ Should check the Total Supply of DIGIPHARM TOKEN after Burn
✓ Should be able to transfer tokens to accounts[2] by owner (195ms)
✓ Should Not be able to transfer tokens to accounts[3] by accounts[2] when transfer is Not allowed (188ms)
✓ Should be able to Mint tokens till maximum allowed (184ms)
✓ Should Not be able to Mint tokens more than maxm Supply (155ms)
✓ Should Not Resume transferred allowed by Non owner Account (84ms)
✓ Should Resume transferred allowed (123ms)
✓ Should be able to transfer tokens to accounts[5] by non Owner account when transfer allowed (226ms)
✓ Should check minting finished or not when total supply is equal to maxm supply (38ms)
✓ Should Not update state of minting finish by Non owner Account (75ms)
✓ Should update state of minting finish (115ms)
✓ Should Not Stop transfer functionality by Non Owner Account (66ms)
✓ Should Stop transfer functionality by owner Account (118ms)
✓ Should Not be able to transfer tokens to accounts[3] by accounts[2] when transfer is Not allowed (161ms)
✓ Should Not Resume transfer functionality by Non Account (77ms)
✓ Should Resume transfer functionality by owner Account (129ms)
✓ should Approve address[5] to spend specific token on the behalf of accounts[3] (83ms)
✓ Should Not be able to transfer tokens more then allowance figure (127ms)
✓ Should be able to transfer tokens to accounts[3] it self after approval from accounts[2] (211ms)
✓ should check the allowance after transferring tokens on the behalf of accounts[2]
✓ should increase the allowance (133ms)
✓ should decrease the allowance (147ms)
✓ Should Not be able to transfer ownership of Digipharm token Contract from Non Owner Account (84ms)
✓ Should be able to transfer ownership of Digipharm token Contract (135ms)
✓ Should be able to check if user can transfer tokens or not(Failed).
✓ Should be able to lock tokens of accounts[3] for particular period of time (116ms)
✓ Should Not be able to transfer tokens to accounts[2] by accounts[3] when lock (538ms)
✓ Should be able to transfer tokens to accounts[2] by accounts[3] when locked but value less then locked value (392ms)
✓ Should transfer tokens to account[3] to check token transfer after lock period (151ms)
✓ Should be able to transfer tokens to accounts[2] by accounts[3] when locked Period is over (334ms)
```

**Final Result of Test:**

✓ 53 Passing (7s) PASSED

❌ 0 Failed

## Coverage Report :

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/coverageDigipharm.png)

## Slither Tool Result :

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/slitherDigipharm.png)

Different solidity version files are used, recommended to use same solidity version files.

## File Description table

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/FileDigipharm.png)

## Implementation Recommendations :

All the implementations and recommendations of Initial audit report is
accepted by Digipharm development team.

## Comments:

Use case of smart contract is very well designed and Implemented.Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. DIGIPHARM development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation. All the High, Medium, low level issues are resolved by digipharm development team.

**You can request for Audit by filling a form :**

https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier audit reports.

**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.

