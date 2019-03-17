Sparkle Smart Contracts Audit Report

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Sparkle.jpg)

>We've been asked by the sparkle  team to review and audit their smart contracts.

>We at **QuillAudits** are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. **QuillAudits**, **QuillHash** Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract code-base.

by **QuillAudits**, February 2019

# Introduction :

This Audit Report highlights the overall security of SPARKLE Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract code-base.

**Auditing Approach and Methodologies applied :**

**Quillhash** team has performed thorough testing of the project starting with analyzing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.

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

**Audit Details**

Project Name: SPARKLE
Client Name: Jonah Glasgow
Languages: Solidity(Smart contract), JavaScript(Unit Testing)

## Summary of Sparkle Smart Contract :

**QuillAudits** conducted a security audit of a smart contract of Sparkle mobile. Sparkle contract is used to create the Erc20 token which is sparkle token, Smart contract contain basic functionalities of ERC20 token with total supply of 70 million.

## Audit Goals

The focus of the audit was to verify that the smart contract system is secure, resilient and working according to its specifications. 

**The audit activities can be grouped in the following three categories:**

**Security:** Identifying security related issues within each contract and within the system of contracts.

**Sound Architecture:** Evaluation of the architecture of this system through the lens of established smart contract best practices and general software best practices.

**Code Correctness and Quality:** A full review of the contract source code. The primary areas of focus include:

```
Correctness

Readability

Sections of code with high complexity

Quantity and quality of test coverage
```
![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Sparkel_chart.png)

# Security Level references :

Every issue in this report was assigned a severity level from the following:

High severity issues will bring problems and should be fixed.

Medium severity issues could potentially bring problems and should eventually be fixed.

Low severity issues are minor details and warnings that can remain unfixed but would be better 
fixed at some point in the future.

## High severity issues:-

No High Severity Issue.


## Medium Severity Issues:-

1.**_burnFrom(address,uint256)** of sparkle token contract is declared as internal function and doesn't called from any other function.
Usage of this function is defined as :

if any ethereum address is allowed to transfer token on the behalf of other account, the allowed ethereum address can burn tokens.
**_burnFrom** function further call **_burn()** function which is also declared internally.
Either use the **_burnFrom()** defined in smart contract or remove both functions from smart contract.
To use _burnFrom function declare function as a public function

❌_burnFrom(address,uint256) internal

**USE:**

✓_burnFrom(address,uint256) public

**Status :** Not considered as an Issue because _burnFrom is not a functionality needed by Sparkle 
contract, smart contract is already deployed on main-net.

2. Smart contract doesn't have functionality to pause smart contract is case of any attack or bug found in smart contract, pause function will stop all the functionalities of smart contract i.e **transfer()**, **transferFrom()**.
Use **pausable** library to stop or restart smart contract functionalities.

**Status :** Not considered as an Issue because contract doesn't have use case to stop or restart.


## Low Severity Issues:-

Solidity naming conventions is not followed while declaring variables.

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Sparkle_namingConv.png)

Use solidity naming conventions to declare variables, identifiers, functions in smart contract.

Slither Tool result

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Sparkel_slither.png)

# Unit Testing

**Test Suite**

**Contract: Sparkle**

```
✓ Should correctly initialize constructor values of Sparkle Token Contract (379ms)
✓ Should check the Total Supply of Sparkle Tokens
✓ Should check the Name of a token of sparkle contract
✓ Should check the symbol of a token of sparkle contract (46ms)
✓ Should check the decimal of a token of sparkle contract
✓ Should check the Owner of a sparkle token contract (42ms)
✓ Should check caller is Owner (47ms)
✓ Should check if caller is owner or not when called from Non Owner Account (38ms)
✓ Should check the balance of a Owner (39ms)
✓ Should check the balance of a Owner
✓ Should be able to transfer tokens to accounts[1] (277ms)
✓ Should Not be able to transfer tokens from accounts[1] to another account, more than balance of account[1] (135ms)
✓ should Approve address[3] to spend specific token on the behalf of owner (83ms)
✓ should increase allowance of address[3] to spend specific token on the behalf of owner (165ms)
✓ Should Not be able to transfer tokens approved by Owner to accounts[3] more than owner have (198ms)
✓ should decrease allowance of address[3] to spend specific token on the behalf of owner (133ms)
✓ Should be able to transfer tokens approved by Owner to accounts[3] (325ms)
✓ Should Not be able to transfer ownership of Sparkle token Contract from Non Owner Account (77ms)
✓ Should be able to transfer ownership of Sparkle token Contract (162ms)
✓ Should Not be able to Reannouance ownership of Sparkle token Contract from Non Owner Account (137ms)
✓ Should be able to reannouance ownership of Sparkle token Contract (234ms).
```
## Final Result of Test:

✓ 21 Passing (3s) PASSED
❌ 0 Failed

## Coverage Report :

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Sparkle_Coverage.png)

coverage report resultcode doesn't covered in coverage reportImplementation Recommendations :
Use case of smart contract is very well designed and Implemented.
Use pausable library to stop functionalities of smart contract in case of attack on smart contract.
Remove unused functions from smart contract.

## Comments:

Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. Sparkle development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation.
All the Issues either solved or not considered as an issue by sparkle Team, Sparkle Token contract is deployed on main Network and sparkle development team decided not to redeploy smart contract as no critical issue is find in smart contract.

## Transaction hashes

**Network : rinkeby**
```
Contract creation : 0x7cbf21bcc74dafbfbd7ca2778d5b61161f1067dc502538982b959e0a87a77e67
Transfer tokens : 0x409a729cab843c5ee720ad86b88f40ec9b520fd2671854469884c870deddc0f3
Approve : 0x7aeac8eff87b8815c964ce68ec2278d34f2c14cc9bd51add28be19b97dce836e
Send ether to token contract (Should fail ): 0xfdbdc56b2ccb70a01d9ea36dc21524786fcb827f3afd92381207c0d070967b58
transferFrom :0x1a86021c70b6c81c850fb495ca7769c458d7835fc2e477934c567587fa4b77aa
decreaseAllowance : 0x510a9ff37e1f327756b006f03937c038dfa6d7ee858204609637909f69c21e5f
transferOwnership : 0x7aeab02eee7bcdee921249c904db70b17c9d7e9cc428cf737d81b68fe9e98297
increaseAllowance : 0x01b19cc8a2850a6e5198436cecd0dbd5be57b1f62a59be3946052dc23aebf205
RenounceOwnership : 0x31dd3ed478545ea9a175cbf5ae66a41ca2780e07fac066c338e42000bf67079c
```

## You can request for Audit by filling a form :
https://quillhash.typeform.com/to/KQ5Hhm

## To be up to date with our work, Join Our Community :-
Website | Medium| Telegram | Twitter | Facebook
