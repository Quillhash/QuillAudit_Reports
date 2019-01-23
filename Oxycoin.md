# OxyCoin SMART CONTRACT AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Oxycoin.jpg)

> We've been asked by the OxyCoin team to review and audit their smart contracts.

We at **QuillAudits** are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract codebase.

>by QuillAudits,August 2018

# 1. Introduction

This Audit Report highlights the overall security of Oxycoin Smart Contracts. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their smart contract codebase.

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

**Every issue in this report was assigned a severity level from the following:**
```
High severity issues will probably bring problems and should be fixed.

Medium severity issues could potentially bring problems and should eventually be fixed.

Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.
```

## 2.1 High severity issues:-
```
Safe math functions must be used to prevent Integer overflow and underflow in burn() , burnFrom() and 

mintToken() functions 

Change Line 154:
balances[msg.sender] -= _value; ​ To 
balances[msg.sender]= balances[msg.sender].sub(_value);

Change Line 155:
_totalSupply -= _value; ​ To 
_totalSupply = _totalSupply.sub(_value);

Change Line 164:
balances[from] -= _value;​ ​ To 
balances[from]=balances[from].sub(_value); ;

Change Line 165:
allowed[from][msg.sender] -= _value; ​ To 
allowed[from][msg.sender] = allowed[from][msg.sender].sub(_value)

Change Line 166:
_totalSupply -= _value; ​ To 
_totalSupply = _totalSupply.sub(_value)

Change Line 171:
balances[target] += mintedAmount;​ ​ To 
balances[target] = balances[target].sub(mintedAmount)

Change Line 172:
_totalSupply += mintedAmount;​ ​ To 
_totalSupply = _totalSupply.add(mintedAmount)

In mintToken function if owner passes a negative value.It can lead to unexpected value in total supply and in balance of target account.It is advised to check function parameters with require statement and use safeMath operations while reducing balance and increasing _totalSupply.

Add :- 

​require(mintedToken > 0); 
​
require(target != address(0)​; before line 171
```
## 2.2 Medium severity issues:-
```
Functions arguments must be checked with require statements in the start of functions else it can lead to wastage of gas if user passed some wrong value.
For ex:- If user passed wrong value in transfer() and transferFrom() functions then transfer will get failed in safeMath library functions .However gas will be wasted so It is advised that function arguments must be checked in the start of functions.

Add :- 
​require(tokens > 0); 
​ require(to != address(0)​; before line 121

Add :- 
​require(tokens > 0); 
​ require(from != address(0)​; 
require(to != address(0)​; before line 134

Check allowance before transferring tokens in transferFrom function.It is advised to check that the sender has enough allowance in the start of transferFrom function using require statement.
Add :- 
require(allowed[from][msg.sender] > 0); 
​ require(balances[from]>0);​ before line 134

In approve() function ,check approver has enough balance to approve tokens to spender account.
Add :- 
require( balances[msg.sender]>= tokens;); ​ before line 128

Function arguments must be checked with require statement in transfer(),transferFrom(),approveAndCall() and mintToken() ​functions
```

## 2.3 Low severity issues:-
```
Solidity version should be fixed in smart contracts.For ex:- It should be pragma solidity 0.4.24​ and not 
​pragma solidity ^0.4.24

Short-address attack protections 

Some Ethereum clients may create malformed messages if a user is persuaded to call a method on a contract with an address that is not a full 20 bytes long. In such a “short-address attack”, an attacker generates an address whose last byte is 0x00, then sends the first 19 bytes of that address to a victim. When the victim makes a contract method call, it appends the 19-byte address to msg.data followed by a value. Since the high-order byte of the value is almost certainly 0x00, reading 20 bytes from the expected location of the address in msg.data will result in the correct address. However, the value is then left-shifted by one byte, effectively multiplying it by 256 and potentially causing the victim to transfer a much larger number of tokens than intended. msg.data will be one byte shorter than expected, but due to how the EVM works, reads past its end will just return 0x00.
Use modifier given below in transfer(),transferFrom() and approve() functions:- 
modifier onlyPayloadSize(uint numWords) { 
assert(msg.data.length >= numWords * 32 + 4); 
_; 
} 
In above modifier numWords is equal to number of arguments passed in functions.
```

# 3. Final Comments

Contract should be properly commented.It is not commented at all now.It is advised to comment the code as it is good practice.
Function arguments must be checked with require statement in every function.
SafeMath library functions should be used in every mathematical operations.
In total supply function ​_totalSupply.​sub(balances[address(0)]);​ ,the highlighted sub operation is unnecessary it can be safely removed.

# 4. Automated Tool Report
Automated test  

Result:- ​ Integer OverFlow and Underflow can be done.

# 5. Failed Unit test cases:-

## unit testing 

Test case failing to revert when owner sends negative tokens to mintToken() function.
Test case failing to revert when someone sends 0 tokens in transfer functions.
Solution:- Use of require statements as suggested above

# 6. Conclusion

This contract is very unsafe to be used in production.You should make all the changes which are suggested in this report.You can also send the contract back to us for review after making required changes.

**You can request for Audit by filling a form :**
https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier blog posts.
**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.
