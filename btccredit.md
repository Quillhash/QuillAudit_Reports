# BTCCREDIT SMART CONTRACT AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Digipharm.png)

>We've been asked by the **BTCCREDIT** team to review and audit their smart contracts.

>by QuillAudits, July 2019

## Introduction :

This Audit Report highlights the overall security of **BTCCREDIT** Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract code base.

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

Project Name: **BTCCREDIT**
website/Etherscan Code : Code
Languages: Solidity (Smart contract), Javascript (Unit Testing)

## Summary of BTCCREDIT Smart Contract :

QuillAudits conducted a security audit of a smart contract of BTCcredit. BTCcredit contract is used to create the ERC20 utility token which is a BTCCredit token, Smart contract contain basic functionalities of ERC20 token with total supply of 300 million and Mint function to mint more Btc credit tokens .

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

1 **distributeTokens(address _address, uint _amount);**

distributeTokens function of smart contract only check whether total supply is less than or equal to distributed tokens, but doesn't subtract from minted tokens, as minted tokens is already sent to particular address, hence owner will be able to distribute tokens more then total supply, as shown in the pictures below.

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcHigh.png)

Total supply is : 300001000
0x410 is holding : 300002000

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcHigh1.png)

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcHigh2.png)

You can use one variable that will automatically update when mint functions is called and will update the no of tokens minted, while distributing tokens check whether distributed tokens is less than the total supply subtracted from minted tokens.

**Status : Issues Fixed by Developer**

## Medium Severity Issues:-

1 Use transfer event while burning tokens, as etherscan reads transfer events. As now burn doesn't emit transfer function now, etherscan couldn't be able to read balance of an account that has burned all the tokens and still showing previous balance of that address.
In both burn() and burnFrom() function of token contract.

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcMedium.png)

Status : Issues Fixed by Developer

## Low Severity Issues:-

1 Solidity version must be fixed (Always use latest Version).
It should not pragma solidity ^0.4.25;
It should be pragma solidity 0.4.25;

Status : Issues Fixed by Developer

version should be fixed so that development phase and deployment phase should have the same solidity version.

2 SafeMath.sol contract functions access modifier can be changed to internal, as there is no use to make them public functions.
Use : access modifier internal in place of public.

Status : Issues Fixed by Developer

## Issues while checking initial audit fixes

## Medium Severity Issues:-

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcMedium1.png)

As you can see in the above picture, after minting 300 million tokens total supply was 600 million and, when 1 million tokens are burnt from account 1, transfer event was omitted from contract to address(0), but it should be from address (msg.sender/caller) to address(0) that's why percentage of token holder is higher than 100% (total supply).

Status : Not Fixed

# Unit Testing

Test Suite
```
Contract: BTCcredit Token Contracts

✓ Should correctly initialize constructor values of BTCCToken Token Contract (250ms)
✓ Should check the Total Supply of BTCCToken Tokens (80ms)
✓ Should check the Name of a token of BTCC Token contract (79ms)
✓ Should check the symbol of a token of BTCCToken contract (64ms)
✓ Should check the decimal of a token of BTCCToken contract (74ms)
✓ Should check the balance of an Owner (66ms)
✓ Should check the owner of a contract (57ms)
✓ Should check the New owner of a contract (57ms)
✓ Should check the balance of a contract (64ms)
✓ Should check the distributed tokens of a contract (68ms)
✓ Should check the owner account is not frozen (66ms)
✓ Should check the minted tokens (52ms)
✓ Should Not be able to distribute tokens to accounts[1] by Non Owner account (154ms)
✓ Should Not be able to distribute tokens more then total supply (170ms)
✓ Should be able to distribute tokens to accounts[1] (257ms)
✓ Should check the distributed tokens of a contract after sent to account[1] (62ms)
✓ Should Not be able to Freeze Accounts[1] by non owner account (263ms)
✓ Should Freeze Accounts[1] (210ms)
✓ Should Not be able to transfer Tokens when account is freezed (97ms)
✓ Should Not be able to UnFreeze Accounts[1] by non owner account (94ms)
✓ Should UnFreeze Accounts[1] (201ms)
✓ Should be able to transfer Tokens after Unfreeze (340ms)
✓ Should Not be able to burn tokens when account doesn't have tokens (96ms)
✓ Should be able to burn tokens (217ms)
✓ Should be able to emit transfer event while burn tokens (217ms)
✓ Should check the Total Supply of BTCCToken Tokens after token burnt
✓ Should Not be able to Mint Tokens by Non owner account (96ms)
✓ Should be able to Mint Tokens by owner only and send to accounts[3] (210ms)
✓ Should check the minted tokens after minted (44ms)
✓ Should Not be able to distribute tokens to accounts[6] less then total supply and minted tokens (127ms)
✓ Should be able to distribute tokens to accounts[6] less then total supply and minted tokens (192ms)
✓ Should check the Total Supply of BTCCToken Tokens after tokens minted (59ms)
✓ Should be able to transfer ownership of token Contract (160ms)
✓ Should check the New owner of a contract
✓ Should be able to Accept ownership of token Contract (124ms)
✓ Should check the New owner of a contract after ownership accepted
✓ should Approve address to spend specific token (155ms)
✓ Should be able to transfer Tokens approved by account[3] to account[5] (299ms)
✓ should check the allowance later
✓ Should be able to burn Tokens approved by account[3] to account[5] (162ms)
✓ Should be able to emit transfer event while burnFrom tokens (217ms)
✓ Should check the Total Supply of BTCCToken Tokens after tokens burn
✓ Should correctly initialize constructor values of sample Token Contract (110ms)
✓ Should check the balance of a sample contract Owner
✓ Should be able to transfer sample tokens to BTCCToken contract (219ms)
✓ Should be able to transfer sample tokens to owner of BTCCToken, sent to contract of BTCCToken (225ms)
✓ Should Not be able to send ethers to contract

Contract: BTCCToken Token Contract for final audit testing at maximum values

✓ Should correctly initialize constructor values of BTCCToken Token Contract (99ms)
✓ Should check the Total Supply of BTCCToken Tokens (39ms)
✓ Should check the Name of a token of BTCC Token contract
✓ Should check the symbol of a token of BTCCToken contract
✓ Should check the decimal of a token of BTCCToken contract
✓ Should check the balance of a Owner
✓ Should check the owner of a contract
✓ Should check the New owner of a contract
✓ Should check the balance of a contract (57ms)
✓ Should check the distributed tokens of a contract
✓ Should check the owner account is not frozen
✓ Should check the minted tokens (38ms)
✓ Should be able to Mint Tokens by owner only more then total supply (128ms)
✓ Should check the minted tokens after minted
✓ Should check the Total Supply of BTCCToken Tokens after tokens minted
✓ Should be able to distribute tokens to accounts[1] (192ms)
✓ Should be able to self destruct (192ms)

Final Result of Test:

✓ 64 Passing (8s) PASSED

❌ 0 Failed

```

## Manual Transactions

Network : Rinkeby

```
Contract Creation
0xe1293ac890cefe3ec24376ba736e3627c50357361b2b76e383827d06732b2fc6
Distribute tokens
0x9718970006fb25c2cd8060fcb995b150e407b9625c236e4b8f59b6b14c4ff366
Mint tokens
0xb31697d901e7933ba5636f1361a52a6df2242b34446ee36da61a3deb0b84d46c
Fall back function (Should failed)
0x6e135a696036d6cbb0a8e5e6c6cafc066b4f59e62d5a9827ccb45ef44f2cd9d9
Distribute tokens more than token supply should be failed (1000 distributed first, 1000 minted, distributed 300mn + 1000 tokens)
0x7e51c9593df05d1d209cd3c4200d61b34924725f1fcd5a737da7d066dd3ea135
Freeze Account
0xee54d3bad0047483ead846b16548e2a9f819eb0dee80d380769a3bdaa889e63f
Burn tokens(Failed when try to burn tokens that account have, because total supply is less then account holders token)
0xe73f81fe90892e1450c9294359e0de387bdb49df986aa432bd2654a22c0be396
Burn tokens (No transfer event when tokens burn)
0x03917d8c4562db959fb985713b6a0576d8eff63193843acbac686b62f368d05c
Mint tokens
0xec6b306d78c8d68e11d5c95a10dffa044d8ccaa675ddb3f05b543add63e71faa
Transfer function
0xaf3a913d6e59038897921c13b9d465cecb3d028ffb6d77b1ffb96ad87405ca9d
Transfer Ownership
0xf8cc6713f3397f8e66b236ac57d7608d3ab4a1ddba0622915153c74f8beac2ef
Accept ownership by non New owner account (Failed)
0x3f66afc8c0e2493a165e0560a238205cfc0a8fce3ff4525d577ee2632a57b5c6
Accept ownership
0xd65d67d585fe3485f969783529c8f0f6bef0ebfc2e42eef2c01c9df89328d457
Approve
0x497b1f7cc1a6e037dc222d58575df42f8974ad76121b0818ee2d1d4c0d7f0718
transferFrom fail by frozen account
0x7ae353f779ad671891f8095241d9488e521870ea7b4cf9eae228fa056f398dac
BurnFrom
0xe8f058f6d95aa96049612b88d4354f5e88188a10cf90546341422a328981a379
Fallback function
0x8758fbcf020eba66173fd160a90d4831ff8b4f6e4ce4eba3155be092adb848fd
Unfreezed account
0xfa1ff4f82112aab86419a91408ab51a2972772ba2b2fc7e392b57bce1cdc1868
Minted 300 min tokens to contract address
0xfcf0cf0b7173067d607f3f39c22dab64fe5d5301aa6c4bd4356d005314795726
Self destruct by non owner account
0xc63b634bb2a3041dd9ab9c6404b7ba2d4e4e928cfffe262d8bfe9c165c903f8a
Self destruct by owner account
0x0aa1a1a76372ec4549ab96c8d8d393be04308c99dbb0252d3b9c03fc9adb4479
```

## Tool Result :

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcTool1.png)


![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcTool2.png)

Above functions can be declared as an external functions
Some of the variables are not mixed case variables

## Smart contract Description

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcContractDesc.png)

## Coverage report

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/btcCoverage.png)

Token A is a sample token contract to check transferAnyERC20Token() function of BTCCtoken contract function.

## Implementation Recommendations :

_totalSupply variable can be declared as private variable, as totalSupply() function already using _totalSupply variable.

Use SafeMath while subtracting totalSupply with balance[address(0)].

transferFrom() function should check allowance first.

Use transfer event while initialising tokens in constructor, transfer event from address(0) to contract address and also update balance of contract.

While distributing tokens use transfer event from contract address to beneficiary to maintain all the balance events on etherscan.

## Comments:

Use case of smart contract is very well designed and Implemented. Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. BTCCREDIT development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation. All the severity issues has been fixed by BTCCREDIT team and we request BTCcredit team to go through recommendations as well to maintain standardization of code.

Note : Smart contract code contain self destruct function which can be called by owner only.

Thanks for reading. Also do check out our earlier blog posts.

QuillAudits is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.
