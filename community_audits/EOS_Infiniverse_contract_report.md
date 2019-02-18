
# Infiniverse Smart Contract Audit Report

![quillaudits](https://github.com/ShivankChopra/Audit-images/blob/master/quillaudits.png)

### By QuillAudits, Feb 2019
## Disclaimer
QuillAudits does not take responsibility for misuse of the information presented in this document. We highly encourage public bug bounties and several independent audits to ensure optimum security of the smart contracts. The audit does not give any warranties on the security of the code.
Smart contract built on the top of EOSIO blockchain allow for a lot of features to be covered by tests, but the Turing completeness of C++ programming language and it's flexibility leaves some space for unexpected run time exceptions.

## Document Information
![doc_info.png](https://github.com/ShivankChopra/Audit-images/blob/master/doc_info.png)
## Table of Contents
-   [Reviewer Introduction](#reviewer-introduction)
    
-   [Scope](#scope)
    
-   [Executive summary](#executive-summary)
    
-   [Contract Overview](#contract-overview)
    
-   [Persistence Tables](#persistence-tables)
    
-   [Actions and parameters](#actions-and-parameters)
    
-   [Severity levels and explanation](#severity-levels-and-explanation)
    
-   [Audit Overview](#audit-overview)
    
-   [Manual Tests on Public Testnets](#manual-tests-on-public-testnets)
    
-   [Test suite results](#test-suite-results)
    
-   [Conclusion](#conclusion)

## Reviewer Introduction
QuillAudits, QuillHash Smart Contracts Security Audit platform ensures the reliability of your smart contract by complete assessment of your system’s architecture and your smart contract codebase. Through our automated and manual analysis we provide complete solution to identify and determine vulnerabilities and violations of the logic in the smart contract. QuillAudits considers the following distinct and crucial facets of the smart contract code: whether the code is secure, whether the code corresponds to the documentation (including whitepaper), whether the code meets best practices in code readability, efficient use of CPU, Bandwidth and RAM for EOS based smart contracts.

## Scope
The scope of the project is Infiniverse land registration and management contract, which can be found on the link below.

Infiniverse contract [https://github.com/InfiniverseAR/infiniverse-eos](https://github.com/InfiniverseAR/infiniverse-eos)
We have scanned the Infiniverse contract for commonly known and more specific vulnerabilities.

**(Audited commit 846ada34833b8d57605028919539f56dfb8e3f5b)**

## Executive Summary
QuillAudit team has performed thorough testing of the project starting with analyzing the design pattern and the use case for the Infiniverse smart contract. Contracts functionality has been tested both manually and with the test cases written in python.

  

We have tested Infiniverse contract for the commonly known and more specific vulnerabilities. Some of the commonly known vulnerabilities that were considered are listed below.

  

-   **Numerical Overflows** - All numerical calculations use the eosio::asset class which are protected against potential overflow and underflow in numeric operations.
    
-   **Authorization Checks** - All actions in the contract require authorisation using the require_auth() built in checks.
    
-   **Apply checks** - Uses the standard EOSIO_DISPATCH for the apply dispatching. This has checks for the correct contract id and and ensures only declared actions are responded to by the contract.
    
-   **String Parameter length** - To ensure string parameters to actions are not unbounded in length the string parameters for all the relevant actions have been capped in length to 256 characters.
    
-   **RAM fill up protection (RAM DoS)** - storing all items in the user's RAM space rather than the contract RAM except for actions requiring the contract's _self permission.
    
-   **CPU bandwidth protection (CPU DoS)** - All actions in the contract are initiated by the caller of the contract therefore the caller would need to have enough staked CPU resources to perform the called action.
    

**Source code version** - The contract code has been updated to compile with a recent version of the eosio compiler tools targeting CDT 1.5.x. This provides several optimisations in source code to reduce boilerplate code and compiled with the more optimised WABT compiler.

## Contract Overview
Infiniverse contract is built to run on EOSIO platform. It is closely coupled with Infinicoin contract which is based on eosio.token standard contract. It keeps track of Infinicoin, lands and assets for the dapp users. As per use case of Infiniverse, this contract is to be used to maintain the ownership of virtual lands, which can be bought using Inficoin tokens. Land is represented by latitude and longitude coordinates. Dapp user can then place assets on the owned lands. Assets are represented by positional, orientation and scale vectors (x, y and z coordinates) along with a custom 11 digit string Id.

  

Users can also sell their land at custom prices. Ownership of the land is expired after a certain period of time and needs to be re-registered after expiry period. This is done to prevent hoarding of the land assets. All lands are arranged wrt north-south latitudes and east-west longitudes for uniform arrangement.

## Persistence Tables
Infiniverse smart contract uses 5 multi index tables to store data.

### deposit
![deposittable](https://github.com/ShivankChopra/Audit-images/blob/master/deposit.png)

### poly
![poly](https://github.com/ShivankChopra/Audit-images/blob/master/poly.png)

### landprice
![landprice](https://github.com/ShivankChopra/Audit-images/blob/master/landprice.png)

### land
![land](https://github.com/ShivankChopra/Audit-images/blob/master/land.png)

### persistent
![persistent](https://github.com/ShivankChopra/Audit-images/blob/master/persistent.png)
## Actions and parameters
The Infiniverse smart contract consists of 11 actions
### opendeposit

  

**Parameters**:

-   **owner**: is a type of eosio::name
    

  

**Intent**: The intent of {{opendeposit}} is to create an entry of the {{owner}} in the {{deposit}} table. This enables {{owner}} to deposit funds in the contract for purchasing lands.

  

----------

### depositinf

  

**Parameters**:

-   **from** : is a type of eosio::name
    
-   **to** : is a type of eosio::name
    
-   **quantity** : is a type of eosio::asset
    
-   **memo** : is a string with a maximum of 256 characters
    

  

**Intent**: The intent of {{depositinf}} is to handle token transfers from the {{infinicoin}} token contract. Upon notification of the token transfer to the {{infinicoinio}} account, this action executes and updates the {{deposit}} table for the {{from}} account and adds the {{quantity}} in it’s {{balance}} field. Requires the entry of {{from}} in the {{deposit}}.

  

----------

### closedeposit

  

**Parameters**:

-   **owner**: is a type of eosio::name
    

  

**Intent**: The intent of the {{closedeposit}} id to remove the {{owner}} account from the {{deposit}} table. This action requires authority of {{owner}} or the contract account. The {{balance}} in the {{deposit}} table is refunded to the {{owner}} account.

  
  
  

----------

### registerland

  

**Parameters**:

-   **owner**: is a type of eosio::name
    
-   **lat_north_edge**: is a type of double
    
-   **long_east_edge**: is a type of double
    
-   **lat_south_edge**: is a type of double
    
-   **long_west_edge**: is a type of double
    

  

**Intent**: The intent of {{registerland}} is to register a land for the {{owner}} specified by the given latitude and longitude parameters and persist this information in the {{land}} table for 1 year. The {{fee}} is calculated and deducted from the {{deposit}} table for {{owner}} and {{fee}} amount of the {{infinicoins}} are transferred to the {{infinicoinio}} account by the {{infiniverse}} smart contract.

  

----------

### moveland

  

**Parameters**:

-   **land_id**: is a type of uint64_t
    
-   **lat_north_edge**: is a type of double
    
-   **long_east_edge**: is a type of double
    
-   **lat_south_edge**: is a type of double
    
-   **long_west_edge**: is a type of double
    

  

**Intent**: The intent of the {{moveland}} id to move the land specified by the {{land_id}} to the new location specified by the latitude and longitude parameters. The land size must be same for this action to execute. This action updates the entry in the {{land}} table specified by the {{land_id}}.

  

----------

### setlandprice

  

**Parameters**:

-   **land_id**: is a type of uint64_t
    
-   **price**: is a type of eosio::asset
    

  

**Intent**: The intent of the {{setlandprice}} action is to set up the land specified by the {{land_id}} for sale by setting it’s price. This action creates an entry in the {{landprices}} table for the given {{land_id}} and {{price}}.

  

----------

### cancelsale

  

**Parameters**:

-   **land_id**: is a type of uint64_t
    

  

**Intent**: The intent of the {{cancelsale}} action is to remove the land specified from the {{land_id}} from the sale by removing it’s entry in the {{landprices}} table.

  

----------

### buyland

  

**Parameters**:

-   **buyer**: is a type of eosio::name
    

-   **land_id**: is a type of uint64_t
    
-   **price**: is a type of eosio::asset
    

  

**Intent**: The intent of the {{buyland}} action is to transfer ownership of the land specified by the {{land_id}} to the {{buyer}}. {{price}} is the amount of asset that {{buyer}} is willing to pay for the land. It must be equal to the price of this land specified in the {{landprices}} table. After execution of this action, the {{price}} amount of {{infinicoin}} tokens are transferred from the smart contract account to the owner of the land specified by the {{land_id}}, and same balance is deducted from the {{deposit}} table for the {{buyer}} account.

  

----------

### persistpoly

  

**Parameters**:

-   **land_id**: is a type of uint64_t
    
-   **poly_id**: is a type of string of 11 characters
    
-   **position**: is a type of vector3 (x, y and z coordinates)
    
-   **orientation**: is a type of vector3 (x, y and z coordinates)
    
-   **scale**: is a type of vector3 (x, y and z coordinates)
    

  

**Intent**: The intent of {{persistpoly}} is to create a new asset on the {{land_id}} specified by the 11 character {{poly_id}} and {{position}},

{{orientation}} and {{scale}} vectors. This actions updates {{poly}} and {{persist}} tables with specified data.

  

----------

### updatepersis

  

**Parameters**:

-   **persistent_id**: is a type of uint64_t
    
-   **land_id**: is a type of uint64_t
    
-   **position**: is a type of vector3 (x, y and z coordinates)
    
-   **orientation**: is a type of vector3 (x, y and z coordinates)
    
-   **scale**: is a type of vector3 (x, y and z coordinates)
    

  

**Intent**: The intent of {{updatepersis}} action is to update the polygon asset specified by the {{persistent_id}} for the {{land_id}}. This action requires the authority of the owner of land with id {{land_id}}. It updates the {{poly}} and the {{persistent}} tables with newly specified values.

  

----------

### deletepersis

**Parameters**:

-   **persistent_id**: is a type of uint64_t
    
**Intent**: The intent of {{deletepersis}} is to remove the asset specified by the {{persistent_id}}. It removes information related to asset with Id {{persistent_id}} from the {{poly}} and {{persistent_table}}.

## Severity Levels and explanation
![severety_levels](https://github.com/ShivankChopra/Audit-images/blob/master/severety%20levels.png)
## Audit Overview

  

### Critical

----------

No Critical level vulnerabilities were found

  

### High

----------

No High level vulnerabilities were found

  

### Medium

----------

Land prices can be set greater than maximum supply

  

**In infiniverse.cpp, infiniverse::setlandprice line 128:**

No upper bound placed on setting the value of the price asset. Land price can be set to the amount greater than the maximum supply of ‘INF’ tokens. This does not lead to the loss/corruption of data or tokens, but makes the land put for selling not purchasable as no user will have enough balance.

  

**Image displaying the vulnerability**

![](https://lh4.googleusercontent.com/rdBQL0UFx24sIeVXrQbs1pG_gK3hZEEDK4ItBoO8avGJ_H7bDjKXr5lXuffObCgg2lzT_ucg1VtFAZF2szlw0h8Rkw5QpP2mW2jAHe15OG_RjLakM0r6gigQC126p_t-z0DgAwdz)

In above image, we can observe that we are able to set the land price equal to "100000000000000.0000 INF" which is much larger than maximum supply, which is "1000000000.0000 INF". Both of these values are visible in above image. Since no dapp user can hold more than maximum supply tokens, this land can never be purchased by other account.

  

**Recommendation**

Add a assert condition on the upper bound on the value of given price asset to not exceed ratio * max_supply where ratio is a value between 0 and 1. This will restrict the value of price for a given land to reasonable values relative to max_supply.

  
  

### Low

----------

No Low level vulnerabilities were found

  

### Lowest/Code/Style/Info

----------

No Lowest/Code/Style/Info level vulnerabilities were found

  
  
  
  
  

## Manual Tests on Public Testnets


For manually testing the functionality of Infiniverse smart contract, we deployed the required contracts on public test network (EOS Jungle2.0). We made 4 accounts for testing the contract:

  

1.  **quillinfin11** for deploying Infiniverse contract.
    
2.  **quillinfcoin** for deploying eosio.token contract
    
3.  **quilltest113** as first test user account
    
4.  **quilltest114** as second test user account
    

  

We have attached screenshots for the operations that were tested manually for the deployed contract.

  
  
  
  

Deploy Infiniverse contract on account quillinfin11

![](https://lh3.googleusercontent.com/2smp-p08LaiPOgVyTVpdmCGFWWj78ujIKqg1ykKJuf5LZ7H6FjN1B9mxCR68WOGIq10Ym87h7n8kZupOq0IwFIhLpkQ2g86Ak7iAlpQHeXjK8xw-zKoGEGsxlq3NXt8iNNFj_e6Y)

  

Create tokens with INF symbol with issuer as quillinfcoin account

**[Action: eosio.token::create]**

![](https://lh3.googleusercontent.com/qzIL3sVB4cvrQNMdGF6nkrmjiJoSSMktg_XeV1I6SLA-rN3MvaBrOy8olgCX_7XjO60SoIQL_f8go2gVmm6dTQOyzoAqZZVuZMTWfZ9piqbUxoC4Boj4IHIYHCMKSq2bH4OJG97L)

  
  
  
  
  
  
  
  
  

Issue 100.0000 INF tokens to quilltest113 and quilltest114 accounts

**[Action: eosio.token::issue]**

![](https://lh3.googleusercontent.com/IaiLd4p7YgTsSDC94pIPMRlTFwp0EsLKpLP9wsko3zOX5qytVtHwzhUe16oYFYzerXyS_WhLTgemERjDTFn5G02fPJk28ljSpKzH7B5k7eqspur52IeZYro3UAPlSt9ysEOa3tkr)

  

![](https://lh3.googleusercontent.com/bgFzeW64XTXvhKhwnRUadvDmzIjumn8M_U3lk9KOp5niwu2q_yM_zdwfDmyFYHY_NsLTQN5oh9vxtKD32d56JcE8RGf9RP67yCDi7IQdWkXERM84X_yov6eqr-AQdOdPmaguBR_u)

  

open a deposit for quilltest113 and quilltest114 accounts

**[Action: infiniverse::opendeposit]**

![](https://lh3.googleusercontent.com/z8BIxxP5Vf37K_-SS7-XM9vvZC6P2EVo1903r7JZBKkBih6bpVhIMcC92T_J9nAJX7HQ6ppnuZ4yQP6UQoCgq6yH-b_80fiWWgtwPOaV7_YywCzCXdsgthJXjYrz7C1EhBvzf_fP)

  

![](https://lh6.googleusercontent.com/X1KZXR4HBOQjpgbqBT0-a4VUI-h0a2rq4S0lxBTuHquAgfipZaMF5d2UEVep0iwzbpYGHieWJghPXEaQj_UswQoDGSxd04mG8a7osmJkYcM8stn_RzbFYp_U6xYjpXw_df8n23fk)

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

Deposit tokens from quilltest113 and quilltest114 accounts

**[Action: eosio.token::transfer]
[Action: infiniverse::depositinf]**

![](https://lh3.googleusercontent.com/06jnU56bjrsOxuHQJRTt-AOMViNAB12beZk0ZXsDJzwSPeEPKI0nH5s8GEgjIvuWYbroXMzumhqtKa5OYGh0Eb_sUek1FqoHvY9rTvxUltNQxVbt9qcnSU0oSHsd1pNNxj7PMfOT)

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

Add a persistent object on the purchased land for account quilltest113

**[Action: infiniverse::persistpoly]**

![](https://lh5.googleusercontent.com/PHfe5D07ZFLFrdLA-zJuEvMBCGm9-uLIkQnun-0pUcMCNigo_LKSEAiSLpy-UqoVvbqGp73PzP3w2-Rp35P8m3DLuH_Zj884Vlb510L-7oLIN1YYgmdMhfYBMwDdOYG8mO10iHZL)

  

Put land owned by quilltest113 for sale by setting selling price

**[Action: infiniverse::setlandprice]**

![](https://lh5.googleusercontent.com/8g60lTmuXbGa_L2kAI0znHGAmIZNuDYQSlalOw0YytP_m3OwzGpR0L2CQXdVg5geTTavtpkQGuf00LJzhNJgBe0SqHpKLYliC00W1k6ypy2kAL0yKfRfaEzyJeYjM83jr51FEXDV)

  
  
  

Buy land for sale for quilltest114 accounts and verify updated balances

**[Action: infiniverse::buyland]**

![](https://lh5.googleusercontent.com/Q3OIhk8rB1sTTtLe71c-lq7FttLkMt1hZJ1sG_wCD2VitAtGDyBV0HS5Z2vEJtkhyT1-bkewrDL4CKLES71HoTUxDvU8Y3hwL0gre6wUovNBhref0uEhxCoKE8sMH9H0KjB6wP0H)

  
  
  
  
  
  
  
  

## Test Suite Results

  

Contracts covered: Infiniverse contract

  

✓ Should be able to deploy Infiniverse contract only

  

✓ Should be able to deploy Infiniverse token contract only

  

✓ Should be able to open deposit account for given account

**[Action: infiniverse::opendeposit]**


✓ Should be able to update deposits account when depositor transfers tokens

**[Action: eosio.token::transfer]**

**[Action: infiniverse::depositinf]**

  

✓ Should be able to close deposit and get refunds

**[Action: infiniverse::closedeposit]**

  

✓ Should be able to register a valid land and deduct amount from deposit account

**[Action: infiniverse::registerland]**

  

✓ Should be able to move land to new location with same dimensions

**[Action: infiniverse::moveland]**

  

✓ Should be able to set land price for existing table and update landprices table

**[Action: infiniverse::setlandprice]**

  

✓ Should be able to cancel sale of the land and remove from landprices table

**[Action: infiniverse::cancelsale]**

  

✓ Should be able to buy land put up for sale for set price and update deposit and token balances accordingly

**[Action: infiniverse::opendeposit]**

  

✓ Should be able to persist a polygon for valid position, orientation and scale parameters on the existing owned land in lands table and update persistent and poly tables

**[Action: infiniverse::persistpoly]**

  

✓ Should be able to update the existing polygon with valid values of position, scale and orientation and reflect changes in persistent table

**[Action: infiniverse::updatepersis]**

  

✓ Should be able to delete the existing polygon by removing its entry from persistent and poly tables

**[Action: infiniverse::deletepersis]**

  
  
  

## Conclusion

During the audit the contract was reviewed manually and with test cases, the auditor found no security issues that may lead to loss of tokens or corruption of data. A medium severity issue related to incorrect setting up of land prices was found, and recommended solution has been discussed above.
