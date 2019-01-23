# MYCROJOBS SMART CONTRACT AUDIT REPORT

![alt text](https://github.com/Quillhash/Audit_Reports/blob/master/Images/MycroJobs.jpg)

>We've been asked by the Mycrojobs team to review and audit their smart contracts.
```
We at QuillAudits are a team of blockchain developers , consultants and security auditors , trying to build a more secure and safe community in the Blockchain space. QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system's architecture and your smart contract codebase.
```
>by **QuillAudits**, 18 January 2019

## Introduction :

This Audit Report highlights the overall security of MYCROJOBS Smart Contract. With this report, we have tried to ensure the reliability of their smart contract by complete assessment of their system's architecture and the smart contract codebase.

## Auditing Approach and Methodologies applied :

**Quillhash** team has performed thorough testing of the project starting with analyzing the code design patterns in which we reviewed the smart contract architecture to ensure it is structured and safe use of third party smart contracts and libraries.
Our team then performed a formal line by line inspection of the Smart Contract in order to find any potential issue like race conditions, transaction-ordering dependence, timestamp dependence, and denial of service attacks.
In the **Unit testing** Phase we coded/conducted Custom unit tests written for each function in the contract to verify that each function works as expected. In Automated Testing, We tested the Smart Contract with our in-house developed tools to identify vulnerabilities and security flaws.
The code was tested in collaboration of our multiple team members and this included -
Testing the functionality of the Smart Contract to determine proper logic has been followed throughout.
Analyzing the complexity of the code by thorough, manual review of the code, line-by-line.
Deploying the code on testnet using multiple clients to run live tests
Analyzing failure preparations to check how the Smart Contract performs in case of bugs and vulnerabilities.
Checking whether all the libraries used in the code are on the latest version.
Analyzing the security of the on-chain data.

## Summary of MYCROJOBS Smart Contract :
```
The MycroJobsContract is having a Use-case of job contract between job seeker and a employer in a Dapp, functionality of a smart contract is describe in a way where employer create a smart contract who is also a owner of a smart contract.
Owner will pay to smart contract using Constructor of a smart contract that is payable.Owner then pay to employee using payWorker() function of a smart contract to transfer funds to employee.
```

# Security Level references :

Every issue in this report was assigned a severity level from the following:

**High severity issues will probably bring problems and should be fixed.**

**Medium severity issues could potentially bring problems and should eventually be fixed.**

**Low severity issues are minor details and warnings that can remain unfixed but would be better fixed at some point in the future.**

## High severity issues:-


1.) Test Case failed of passing _jobber address with value '5' or other than zero as

require(_jobber != 0) bypass when any value is entered other then zero.(Line : 18)

Status : Not yet Fixed (already mentioned in Initial audit report).

```USE require(_jobber != address(0));```

> this will cast the _jobber into address from first then compare whether address is zero address or not,
also when you have already use this required condition in constructor you doesn't need to check again in payWorker function.


2.) Smart Contract constructor doesn't check if _jobber is same as of employer (msg.sender) or Owner.

> Status : Fixed by Developer.

```USE require(_jobber != msg.sender);```

Constructor of smart contract should confirm _jobber or a job seeker should not be a msg.sender(employer) as by this, employer is willing to pay himself multiple times. That is not ethically correct.

## Medium Severity Issues:-

1.) Use pause() Function or Pausable library as it will be very helpful if in any situation you need to stop functionalities of contract that can be done by using pausable library for both contracts.

> Status : Not yet Fixed (Client will consider this in future).

2.) Line 33 of smart contract update the state of contractIsPaid to true, that is already True, so there is no point to update again, this will only waste gas, you can remove this line also contractIsDone is not checked in require condition before paying to Worker.

> Status : Fixed.

## Low Severity Issues:-

1.) Solidity version must be fixed (Always use latest Version).
```
It should not pragma solidity ^0.4.24;
It should be pragma solidity 0.4.24;
Status : Fixed.
version should be fixed so that development phase and deployment phase should have same solidity version.
```

2.) Use solidity naming conventions to declare variable names in both contracts, order of function grouping should be correct (public/external view returns(bool) is correct) Line :46,52,58.. .NOT FIXED YET

3.) Also Use Events to listen in Dapp.
>Status : Fixed.
   # Unit Testing

## Test Suite

**Contract: MycroJobsContract**
```
✓ Should correctly Deploy Mycro Jobs Contract (197ms)
✓ Should not deploy Mycro Jobs Contract when address passed is value 5 (failed) (139ms)
✓ Should not deploy Mycro Jobs Contract when jobber address is same of owner address (133ms)
✓ Should Return correct jobber address (47ms)
✓ Should Return correct Owner address
✓ Should Return correct Owner address from function getOwneraddress()
✓ Should Return correct Jobber address
✓ Should check if contract Paid or Not
✓ Should check if contract Done or not before get paid (176ms)
✓ Should correctly Return contract Address (39ms)
✓ Should Not Return contract Address when called from other then owner and jobber (51ms)
✓ Should correctly Return Agreed Amount, when call from Owner (62ms)
✓ Should correctly Return Agreed Amount, when call from jobber (62ms)
✓ Should Not Return Agreed Amount, when call from NON owner or jobber address
✓ Should check contract and agreed amount should be same (1638ms)
✓ Should correctly Pay to Worker from owner (4323ms)
✓ Should check if contract Done or not After get paid
```

>Final Result of Test:
✓ 15 Passing (7s)
❌ 1 Failing


## Implementation Recommendations :

Use case of smart contract is very well implemented but there are some areas that can be improved.
What are the step to be taken if employee left the job before completion of task? Because at that point of time, ethers or amount will be locked in contract, employer/Owner will not be able to get back the funds

You can use function where amount will be locked in escrow function that will release the funds to employee only when task will be completed else it will send amount back to employer

## Comments:

Overall, the code is clearly written, and demonstrates effective use of abstraction, separation of concerns, and modularity. MYCRO development team demonstrated high technical capabilities, both in the design of the architecture and in the implementation.
We found some critical issue and several additional issues that require the attention of the MYCRO team. Given the subjective nature of some assessments, it will be up to the MYCRO team to decide whether any changes should be made.

>You can request for Audit by filling a form :
https://quillhash.typeform.com/to/KQ5Hhm

Thanks for reading. Also do check out our earlier blog posts.
**QuillAudits** is a secure smart contract audits platform designed by **QuillHash Technologies**. It is a fully automated platform to verify smart contracts to check for security vulnerabilities through it's superior manual review and automated tools. We conduct both smart contract audits and penetration tests to find potential security vulnerabilities which might harm the platform's integrity.

