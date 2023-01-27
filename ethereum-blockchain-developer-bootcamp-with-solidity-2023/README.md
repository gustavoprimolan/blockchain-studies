# Course
[Course link](https://www.udemy.com/course/blockchain-developer)

# Remix IDE

## Setup Remix
* http://remix.ethereum.org/ | https://remix.ethereum.org/
  * HTTP vs HTTPS
  * Be careful with the https vs http domain. Remix stores edited files in localstorage of the browser. If your smart contracts are suddenly gone, look at the protocol.
  * In this course we work with http, not https. This is especially important later when we do private blockchains which require CORS to be setup correctly. 
* https://ethereum-blockchain-developer.com/2022-01-remix-introduction/01-setup-remix/

## Starting, Stopping and Interacting with Smart Contracts

* https://ethereum-blockchain-developer.com/2022-01-remix-introduction/02-starting-stopping-interacting/

```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract MyContract {

    string public ourString = "Hello World";

}
```


* Wondering what that all means?
  * This is a very basic version of a Smart Contract. Let's go through it line by line:
  * // SPDX-License-Identifier: GPL-3.0: The The Software Package Data Exchange® (SPDX®) identifier is there to clearly communicate the license under which the Solidity file will be made available. Well, if you make it available. But you should. Smart Contracts transparency and trust greatly benefit from the source being published and sometimes it's not 100% clear under which license the source is out in the wild. The SPDX identifier is optional, but recommended.
  * pragma solidity 0.8.14: The pragma keyword is for the compiler to enable certain features or check certain things. The version pragma is a safety measure, to let the compiler know for which compiler version the Solidity file was written for. It follows the SemVer versioning standard. 0.8.14 only version 0.8.14, but if we'd write it as pragma solidity ^0.8.0 it would mean >=0.8.0 and <0.9.0.
  * contract MyContract: That's the actual beginning of the Smart Contract. Like a Class in almost any other programming language.
  * string public myString = 'hello world': That is a storage variable. It's public and Solidity will automatically generate a getter function for it - you'll see that in a minute!

# Blockchain basics

## What is a smart contract
  * "smart contracts" was coined by computer scientist Nick Szabo in 1994
  * A piece of code running on the blockchain
    * It's a state machine
    * Needs transactions to change state
    * Can do logic operations
  
  * Statechange happens through mining+transacations

  * It's turing complete
    * That means in theory it can solve any computation problem

## Smart Contract Programming Languages
  * Solidity
  * Vyper (Vitalik)
  * LLL
  * All run on EVM and generates a bytecode

## Solidity
  * The most popular language
    * This course is building upon it
  * It's compared to Javascript
    * ECMA Script
  * Every "high language" code compiles to Bytecode
  * Every Ethereum node in the network executes the same code
    * Because every node has a copy of the chain

## Other languages
  * Serpent
    * Similar to Python
  * LLL
    * Like low-level LISP
  * Mutan
    * Deprecated Go-based language
  * Vyper
    * Research-oriented, derived from Python

## Deployment
  * During deployment we sent off a transcation
  * The data-field was populated
  * The data in the data field is the compiled byte-code
  * Code deployed on the blockchain

## Key Take-Aways
  * Smart Contracts are running on the blockchain
    * Deployed as EVM Bytecode
  * They are turing complete
  * The structure looks probably familiar
  * Deployment is done with a transaction

# Read and Write to Smart Contract

```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract MyContract {

    string public ourString = "Hello World";

    function updateOurString(string memory _updateString) public { 
        ourString = _updateString;

    } 

}
```

* Variable naming
  * According to the [Naming Conventions](https://docs.soliditylang.org/en/v0.4.25/style-guide.html#naming-conventions) a variable should be mixedCase, without a leading underscore. Turns out I was wrong teaching you a leading underscore (_variableName) - I still use it in my contracts as I like the distinction between JavaScript, Web3js and Solidity. But I need to mention it here: If you want to write Smart Contracts according to the official suggested naming convention, write variables only as mixedCase

