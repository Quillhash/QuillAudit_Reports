   #                GUILDCRYPT SMART CONTRACT AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/GuildCrypt.jpg)

We've been asked by the GuildCrypt team to review and audit their smart contracts.

We at **QuillAudits** are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract codebase.

>by QuillAudits,17 January 2019

Source Code Link : https://github.com/GuildCrypt

# Introduction :

This Audit Report highlights the overall security of **GuildCrypt** Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract codebase.

**Auditing Approach and Methodologies applied :**

**Quillhash** team has performed thorough testing of the project starting with analyzing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.

Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks.

In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.

The code was tested in collaboration of our multiple team members and this included -
```
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.
Deploying the code on testnet using multiple clients to run live tests
Analyzing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.
Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.
```

**Summary of GuildCrypt Smart Contract (Oathforge, Riftpact) :**

The **OathForge** contract is functionally an ERC-721 Smart Contract. The smart contract has all the functions of an ERC721 standard including mint function to issue non fungible tokens, to have legal rights on a token, tokenizer will issue a contract on guildCrypt website .

The **RiftPact** contract is functionally an ERC-20 Smart Contract. The smart contract has all the functions of an ERC20 standard including auction use case that interact with DAI tokens.
Disclaimer : DAI Token contract is a simple ERC20 token contract with 18 decimal, it is a sample contract that is used to interact with RiftPact Token contract for testing purpose, also all the libraries and contract other then OathForge and RiftPact are used from open-zeppelin for testing purpose only.

## Security Level references :

>Every issue in this report was assigned a severity level from the following:

**High severity issues will probably bring problems and should be fixed.**

**Medium severity issues could potentially bring problems and should eventually be fixed.**

**Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.**

## High severity issues:-

1.) **submitBid()** function of RiftPact token contract contain Reentrancy issue, externally calling DAI token contract and transferring tokens to previous bidder, and updating states after external calls.
Status : Not yet Fixed.
Avoid state change after external calls, try to finish internal work first.

2.) **transferfrom()** function is having check of sunsetInitialise but user is able to use **safeTransferfrom()** function to transfer tokens even after sunsetlength is exceed in OathForge Contract.

>Status : Not yet Fixed.

Overwrite both **safeTransferFrom()** functions with sunsetlength require condition. just like you did in transferFrom function in OathForge contract.

## Medium Severity Issues:-
```
1.) OathForge contract doesn't track of its token fracturizer, neither their is track on whether voting is already going on for particular token also even if tokenID doesn't exist anyone can deploy RiftPact contract corresponding to any tokenId.

Status : Not yet Fixed.

Use function to check whether tokenId already exist or not before auction start also add function in oathforge contract that keep track on existing RiftPact contract auction start and finalize so that, no two or more auction could take place at same time for same tokenId.

2.) submitRedemptionCodeHash() doesn't check if sunset length reached or not at the time of redemption, token holder is able to redeem token even after sunset length exceed.

Status : Not yet Fixed.

3.) Use pause() Function or Pausable library as it will be very helpful if in any situation you need to stop functionalities of contract that can be done by using pausable library for both contracts.

Status : Not yet Fixed.

4.) ERC20 Riftpact token contract doesn't contain symbol and name.

Status : Not yet Fixed.

Set public variables name and symbol that can be read by etherscan and wallet.

5.) initiateSunset() can be done before minting in OathForge Smart contract.

Status : Not yet Fixed.

Should check if token is minted or before initiate sunset.
```

## Low Severity Issues:-
```
1.) Solidity version must be fixed(Always use latest Version).

It should not pragma solidity ^0.4.24;
It should be pragma solidity 0.4.24;

Status : Not yet Fixed.

RiftPact and oathforge contract have different compiler version.

2.) Use SafeMath library functions in all math operations (What is the purpose of importing SafeMath library in oathforge, riftpact contract when it is not used).

Status : Not yet Fixed.

3.) Not require to import ERC721.sol contract in RiftPact contract as you have already Imported in OathForge contract.

Status : Not yet Fixed.
4.) Use require (__auctionAllowedAt > now) in RiftPact constructor.

Status : Not yet Fixed.

5.) _minAuctionCompleteWait, _minBidDeltaPerunNumerator, _minBidDeltaPerunDenominator, could be declared as constant in RiftPact Smart Contract.

Status : Not yet Fixed.
6.) Use solidity naming conventions to declare variable names in both contracts.
```

# Unit Testing

**Test Suite**

Contract: OathForge, RiftPact.
```
✓ Should correctly initialize constructor values of oathForge Contract (210ms)
✓ Should Not be able to mint token for accounts[1] by Non Owner Account (63ms)
✓ Should be able to mint token for accounts[1] (201ms)
✓ Should not be able to set Token URI from non Owner Account (71ms)
✓ Should not be able to set Token URI of non minted Token id (70ms)
✓ Should be able to set Token URI (197ms)
✓ Should be able to mint token for accounts[3] (206ms)
✓ Should Not be able to approve accounts[2] to spend tokens on the behalf of accounts[1] of negative token ID (53ms)
✓ Should be able to approve accounts[2] to spend tokens on the behalf of accounts[1] (327ms)
✓ Should be able to transferFrom accounts[1] to accounts[2] (208ms)
✓ Should be able to approve accounts[1] to spend tokens on the behalf of accounts[2] (203ms)
✓ Should be able to Safe transferFrom accounts[2] to accounts[1] (186ms)
✓ Should be able to set Approval for all tokens from accounts[1] to accounts[2] (180ms)
✓ Should Not be able to Initialize Sunset of any Token, from non-Owner Account (80ms)
✓ Should be able to Initialize Sunset Only by Owner (112ms)
✓ Should Not be able to submit Redemption Code Hash, for non minted token (74ms)
✓ Should be able to transfer ownership of OathForge Contract (130ms)
✓ Should be able to Reannouance ownership of OathForge Contract (75ms)
✓ Should be able to submit Redemption Code Hash (178ms)
✓ Should be able to get Redemption Code Hash of Token id (54ms)
✓ Should be able to get timestamp Redemption Code Hash
✓ Should be able to get correct next token ID and total supply (69ms)
✓ Should correctly initialize constructor values of Dai Token Contract (351ms)
✓ Should issue Dai token to accounts[0],[1],[2],[3] (642ms)
✓ Should correctly initialize constructor values of RiftPack Contract (126ms)
✓ Should be able to check Correct DAI Token Address (42ms)
✓ Should be able to check Correct oathForge Contract Address
✓ Should be able to check Correct OathForgeToken ID (41ms)
✓ Should be able to check Minimum BID
✓ Should be able to check Auction Allowed Time
✓ Should Check Auction completed or not
✓ Should start Auction (84ms)
✓ Should check Auction Started at
✓ Should Approve Auction/RiftPact contract to transfer DAI tokens on the behalf of Bidder (65ms)
✓ Should participate in a Auction by accounts[1] (163 ms)
✓ Should be able to get Top Bid After Auction started and participation (40ms)
✓ Should be able to get Top Bidder After Auction started and participation
✓ Should Approve Auction/RiftPact contract to transfer DAI tokens on the behalf of Bidder (54ms)
✓ Should participate in a Auction by accounts[2] (221ms)
✓ Should Not be able participate in a Auction by accounts[3] by submitting bid less than minimum Bid (51ms)
✓ Should be able to transfer Tokens (114ms)
✓ Should Complete Auction (133ms)
✓ Should Payout DAI Token After auction is completed (224ms)
✓ Should Payout DAI Token After auction is completed (212ms)
✓ Should Not be able to Complete Auction When it is already Finish (39ms)
✓ should Approve address to spend specific token (87ms)
✓ should increase Approval (143ms)
✓ should decrease Approval (93ms)
✓ should not increase Approval for Negative Tokens
```

**Failed Test Cases :**

❌ Should Not initialize constructor values of RiftPack Contract of TokenID that is not minted from OathForge(Test Case Failed) (132ms)

**Final Result of Test:**

✓ 49 Passing (7s)

❌ 1 Failing

Code Coverage :

>OathForge contract :
95.45 | 33.33 | 100 | 95.24 | 106

>RiftPact contract :
97.67 | 60.71 | 100 | 97.44 | 144

Code coverage report signifies that test cases are covering all the code.

## Implementation Recommendations :

There should be a function to pause the transfer function in case of any bug arises in future. Pause function will be helpful to prevent the loss.
Use case of smart contract is very well implemented but there are some areas that can be improve or need to be define better.

Oathforge token keep track on respective Riftpact contract, and auction as well, ideally there should not be two or more auction going on for same tokenId to stop that RiftPact contract should call OathForge contract before starting auction to check if any auction is already exist if its already exit it should not be start else it will start as well update in oathforge contract as well.
It should not be able to initiateSunset() of a tokenID that doesn't exist. Function should check if tokenId exist or not.

## Comments:

Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. GuildCrypt development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation.
We found some critical issue and several additional issues that require the attention of the GuildCrypt team. Given the subjective nature of some assessments, it will be up to the GuildCrypt team to decide whether any changes should be made.

You can request for Audit by filling a form :
https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier blog posts.
**QuillAudits** is a secure smart contract audits platform designed by QuillHash Technologies. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.
