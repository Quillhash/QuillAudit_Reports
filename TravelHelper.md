   #      TravelHelper SMART CONTRACT AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/TravelHelper1.jpg)

> We've been asked by the TravelHelper team to review and audit their smart contracts.

We at **QuillAudits** are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract codebase.

>by QuillAudits,August 2018

# 1. Introduction
This Audit Report highlights the overall security of TravelHelper Smart Contracts. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their smart contract codebase.

## 1.1 Auditing Approach and Methodologies applied

Quillhash team has performed thorough testing of the project starting with analysing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.

Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks.

In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.

**The code was tested in collaboration of our multiple team members and this included :**
```
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.
Deploying the code on testnet using multiple clients to run live tests.
Analysing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.
Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.
```
# 2. Security Level references

> Every issue in this report was assigned a severity level from the following:

**High severity issues will probably bring problems and should be fixed.**

**Medium severity issues could potentially bring problems and should eventually be fixed.**

**Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.**

## 2.1 High severity issues:-
```
Unmet condition in burnTokensForSale():

There is a require(tokens > 0) statement in the burnTokensForSale() function,where tokens is the balance of crowdsale contract so it means that this function can only succeed when all tokens will be sold .In crowdsale function there is a function finalizeAndBurn() which burns the tokens first and then finalize the sale, finalizing the sale means that investors can transfer their tokens after finalizing the sale.So the bug here is that if all tokens will be sold than this function will never succeed as it will be revert in burnTokensForSale() and investors will never able to transfer their tokens.
```

## 2.2 Medium severity issues:-

No medium severity issues are found.

## 2.3 Low severity issues:-

Solidity version should be fixed in smart contracts.For ex:- It should be pragma solidity 0.4.24​ and not ​ pragma solidity ^0.4.24

Transfer Events are not emitted in activateSaleContract() function in token contract.

# 3. Final Comments
Contract should be properly commented.It is not commented in some places. It is advised to comment the code as it is good practice.
Use of block number instead of timestamp is done perfectly.

# 4. Conclusion
All the changes suggested by our team has been applied by TravelHelper.So their contracts are secure now as of our investigation and their audited contracts are already deployed on main net.


**You can request for Audit by filling a form :**
https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier blog posts.
**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.
