# DISCOVERY IOT SMART CONTRACTS AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/Discovery-IOT.jpg)

> We've been asked by the Discovery IOT team to review and audit their smart contracts.

We at **QuillAudits** are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract codebase.

>by QuillAudits, November  2018

# Introduction :

This Audit Report highlights the overall security of DiscoveryIOT Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's 
architecture and the smart contract codebase.

## Auditing Approach and Methodologies applied :

**Quillhash** team has performed thorough testing of the project starting with analyzing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.

Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks.

In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.

**The code was tested in collaboration of our multiple team members and this included -**
```
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.
Deploying the code on testnet using multiple clients to run live tests
Analyzing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.
Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.
```

## Summary of DISCOVERY IOT Smart Contracts :

**DiscoveryIoT** contracts are customized ERC20 with following added functionality:-

DiscoveryToken is StandardToken, paused and owned.

DiscoveryToken: DiscoveryToken contract provide token to crowdsale and other accounts with vesting period.

Crowdsale is owned, usingOraclize.

Crowdsale: Contract consist of different round of crowdsale, having BuyToken function to participate in contract sale when sale is started and not paused.

TokenVesting is owned.

TokenVesting: A token holder contract that can release its token balance gradually like a typical vesting scheme, with a cliff and vesting period. Optionally revocable by the owner.

# Security Level references :

**Every issue in this report was assigned a severity level from the following:**
```
High severity issues will probably bring problems and should be fixed.

Medium severity issues could potentially bring problems and should eventually be fixed.

Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at 

some point in the future.
```

## High severity issues:-

**No HIGH Severity Issues**

## Medium Severity Issues:-

**No MEDIUM Severity Issues**

## Low Severity Issues:-

1. **Unused Variable**

Crowdsale contract has unused variable totalCap.

>Status : Fixed by Developer.

2. **keccak256 encoding behavior**
```
Before ABI encoding functions were introduced, keccak function accepts multiple arguments like
=> keccak256("AAAA", "BBBB", 42);
It has been implicitly doing encodePacked. But now if you try calling keccak with those, you are likely to get a compiler warning.

Warning:-This function only accepts a single "bytes" argument
To remove these warning, replace following lines:-

Line 939(Contract Oraclizei) :- keccak256(delay_bytes8_left, args[1], sha256(args[0]), args[2]);
With:- keccak256(abi.encodePacked(delay_bytes8_left, args[1], sha256(args[0]), args[2]);
Same goes with line 1051,1069 of contract Oraclizei
```
> Status : Fixed by Developer.


3. Line length exceeded

Line length must be no more than 120.

Crowdsale contract : Line no 85,112,132:

>Status : Fixed by Developer.

4. Invoking events without "emit" prefix is deprecated

Example: __callback() line:102(Crowdsale.sol)

>Status : Fixed by Developer.

5. Source file does not specify required compiler version
Example:- Contract OraclizeI

Consider adding "pragma solidity ^0.4.24;"

> Status : Fixed by Developer.

# Unit Testing

**Contract: DiscoveryToken,Crowdsale, TokenVesting.**

```
✓ Should correctly initialize constructor values of Token Contract (349ms)
✓ Should Activate Sale contract (137ms)
✓ Should send Bounty Tokens (104ms)
✓ Should Released Partners Tokens (165ms)
✓ Should release Treasury Tokens (127ms)
✓ should not burn sale token before sale is over (82ms)
✓ Should be able to transfer ownership of Token Contract (120ms)
✓ Should be able to Pause and check investor not able to get token when pause (44ms)
✓ Should not be able Burn Tokens when it is paused (228ms)
  Contract: CrowdSale contract
✓ Should Deploy Crowdsale only (211ms)
✓ Should check balance of Crowdsale after, crowdsale activate from token contract (38ms)
✓ Should Authorize KYC first (129ms)
✓ Should Freeze Account (113ms)
✓ Should Start CrowdSale (231ms)
✓ Should be able to buy Tokens (142ms)
✓ Should be able to set ether price (103ms)
✓ should not finalize the sale before it's over (59ms)
✓ should not burn sale token before sale is over (82ms)
  Contract: TokenVesting contract
✓ Should Deploy Vesting only (159ms)
✓ Should check balance of Vesting Contract, after activate Sale Contract
✓ Should vest Token of vesting contract when tokens are not revokable (108ms)
✓ Should vest Token of vesting contract when tokens are revocable (98ms)
✓ Should released, releasable tokens if vesting is already done and not released yet (386ms)
✓ Should be able to transfer ownership of Vesting Contract (151ms)
✓ Should revert if user tries to transfer zero bounty (143ms)
✓ Should revert if user tries to transfer zero Partner Tokens (120ms)
✓ Should revert if user tries to transfer zero Treasury Tokens (154ms)
✓ Should not be able to transfer zero tokens (131ms)
```

**Final Result of Test:**

✓ 27 passing

❌ 0 failing

## Implementation Recommendations :

Use case of smart contract is very well implemented and describe Discovery IOT development team have worked very well.

## Comments:

Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. DiscoveryIOT development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation.
We found some critical issue and several additional issues that require the attention of the DiscoveryIOT team. Given the subjective nature of some assessments, it will be up to the DiscoveryIOT team to decide whether any changes should be made.

**You can request for Audit by filling a form :**
https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier blog posts.

**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.
