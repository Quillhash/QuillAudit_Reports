   # ASMX SMART CONTRACT AUDIT REPORT


![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/ASMX.jpg)



> We've been asked by the ASMX team to review and audit their smart contracts.

We at **QuillAudits** are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract codebase.

>by QuillAudits,October 2018

# 1. Introduction

This Audit Report highlights the overall security of Asmx Smart Contracts. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their smart contract codebase.

## 1.1 Auditing Approach and Methodologies applied

Quillhash team has performed thorough testing of the project starting with analysing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.

Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks.

In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.

>The code was tested in collaboration of our multiple team members and this included :
```
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.
Deploying the code on testnet using multiple clients to run live tests.
Analysing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.
Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.
```

# 2. Security Level references

**Every issue in this report was assigned a severity level from the following:**
```
High severity issues will probably bring problems and should be fixed.

Medium severity issues could potentially bring problems and should eventually be fixed.

Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.
```

## 2.1 High severity issues:-
```
INITIAL_SUPPLY in contract ASM is having 380831804 tokens and in your white paper figure is 380831803.
Status : Not yet Fixed.

Change the name of send() function to sendTokens().sendTokens() will be more accurate and verbose.It can be an issue if you will be using web3 or truffle for making creating any dApp or dashboard to call function of your contract,because truffle and predefined send() function for sending either to contract.
instance.send(web3.toWei(1, "ether")).then(function(result) { 
// Same result object as above. 
});

Web3 also has sa predefined send function for the following purpose:-

Function - send: Will send a transaction to the smart contract and execute its method (Can alter the smart contract state).

So it can be dangerous if you will use web3 or truffle to interact with your contract.

Also in unit testing we are not able to test this function through truffle.

Note:- We are using sendTokens() as function name to test send() function because we are not able to call send() function from web3 or truffle so we have to change the name for testing purpose and we strongly recommend that you should change the name of this function as well.
```

## 2.2 Medium severity issues:-
```
Line no 155:- approve() has a race condition problem.

approve() doesn’t check if the value of allowance is equal to 0 before performing operation. We recommend disabling users from calling this function if the value of allowance is not equal to 0. We also recommend adding this code before performing operation:

require((_value == 0) || (allowed[msg.sender][_spender] == 0));
```

## 2.3 Low severity issues:-
```

Solidity version must be fixed(Always use latest Version).

It should not pragma solidity ^0.4.19; 
It should be pragma solidity 0.4.24;

Status : Not yet Fixed.

function Ownable in contract Ownable should be name as constructor according to latest standards of Ethereum.
```

**Unit test Failed :** should revert if someone if user tries to transfer zero tokens.It will lead to wastage of gas if user sends 0 tokens by mistake so it is better to revert the transaction.
Event and Function name must be different.

Refers to : Transfer function and Event.

Function order is incorrect, fallback function can not go after public function.

# 3. Unit Testing

## Test Suite Result
```
 Should correctly initialize Constructor values.
 Should correctly initialize totalSupply balance.
 Should transfer right tokens.
 Should Mint right token.
 Should Mint and Burn right token.
 Should revert if someone if user tries to transfer zero token.
 Should revert if someone if user tries to transfer negative tokens.
 Should not be able to mint negative tokens.
 Should Approve address to spend specific token.
 Should Mint right token and get approval.
```

# Implementation Recommendations

Contract does not have much functionality to get information about ether present in contract.There is sendEther() function to send ether from contract to other address but there is no way to know how much ether is present in contract.

# 4. Conclusion
Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. ASMX development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation.

We found some critical issue and several additional issues that require the attention of the ASMX team. Given the subjective nature of some assessments, it will be up to the ASMX team to decide whether any changes should be made.

**You can request for Audit by filling a form :**
https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier blog posts.
**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.
