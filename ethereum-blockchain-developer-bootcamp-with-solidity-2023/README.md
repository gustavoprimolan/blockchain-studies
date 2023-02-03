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

# [Project] The Blockchain Messenger

## Booleans
* All variables in Solidity are initialized with their default value. There is no undefined or null!
```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleBoolean {

    // default value = false
    // 0 = true
    // any character = true
    // empty and false = false
    bool public myBool;

    function setMyBool(bool _myBool) public {
        // myBool = _myBool;
        myBool = !_myBool;
    }

}

```

## (Unsigned) Integers
* [LAB](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/02-integer/)
```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleUint {

    // default = 0
    // possible initialize
    // initialization costs extra gas
    uint public myUint = 83321;

    uint256 public myUint256; //Stores 0 - (2ˆ256) - 1 

    uint8 public myUint8; // 0 - 255 or (2ˆ8) - 1

    int public myInt = -10; // -2ˆ128 to +2ˆ128 -1

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function decrementUint() public {
        myUint--;
    }

    function increementUint8() public {
        myUint8++;
    }

    function increementInt() public {
        myInt++;
    }
}
```


## Integer Rollover - SafeMath

* [LAB](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/03-integer-rollovers/)


* What are Overflows or Underflows?¶
  * In previous versions of Solidity (prior Solidity 0.8.x) an integer would automatically roll-over to a lower or higher number. If you would decrement 0 by 1 (0-1) on an unsigned integer, the result would not be -1, or an error, the result would simple be: type(uint).max.

  * For this example I want to use uint8. In our previous example worked with uint256 and uint8 and did not roll over. Uint8 is going from 0 to 2^8 - 1. In other words: uint8 ranges from 0 to 255. If you increment 255 it will automatically be 0, if you decrement 0, it will become 255 if the operation is unchecked. No warnings, no errors. For example, this can become problematic, if you store a token-balance in a variable and decrement it without checking.

* Solidity 0.7 example

```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleWrapAround {

    uint8 public myUint8 = 250; 

    function decrement() public {
        myUint8--;
    }

    function increment() public {
        myUint8++;
    }
}
```
* If you deploy this and run "increment" more than 5 time, the myUint8 will just magically start from 0 again. No warning.

* Of course, sometimes this behavior is actually beneficial. Imagine you want to run something indefinitely and just do something on every even number. To save gas, you'd naturally use an uint8 and do var % 2 == 0. That way it rolls over and nobody actually cares.

* The problem is, those cases are actually pretty rare. Normally, we don't want an integer to roll over. That's why in 0.8 it changed to be the default behavior to error out if the maximum/minimum value is reached. But you can still enforce this behavior. With an unchecked block. Let's see an example.

* Solidity 0.8 unchecked example

```solidity 
//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleWrapAround {
    uint256 public myUint;

    function decrementUintUnchecked() public {
        unchecked {
            myUint--;
        }
    }

    function decrementUint() public {
        myUint--;
    }
}

```

## Strings and Bytes

* [LAB](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/04-strings-bytes/)

* Strings are actually Arrays, very similar to a bytes-array. If that sounds too complicated, let me break down some quirks for you that are somewhat unique to Solidity:

  * Natively, there are no String manipulation functions.
  * No even string comparison is natively possible
  * There are libraries to work with Strings
  * Strings are expensive to store and work with in Solidity (Gas costs, we talk about them later)
  * As a rule of thumb: **try to avoid storing Strings, use Events instead (more on that later as well!)**

```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleStrings {

    string public myString = "Hello World";
    //EACH CHARACTER HAS 1 BYTE
    bytes public myBytes = "Hello World";
    //THE CHARACTER ö HAS 2 BYTES
    bytes public myBytes2 = "Hello Wörld";

    function setMyString(string memory _myString) public {
        myString = _myString;
    }
    // comparing two strings
    function compareTwoStrings(string memory _myString) public view returns(bool) {
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }
}
```

* Strings vs Bytes

  * Strings are actually arbitrary long bytes in UTF-8 representation. Strings do not have a length property, bytes do have that. Let's run an example and add a bytes variable with the same "Hello World".
  * The character "ö" needs 2 bytes.

## Addresses Types

* [LAB](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/05-ethereum-addresses/)
* One type, which is very specific to Ethereum and Solidity, is the type "address".
* Ethereum supports transfer of Ether and communication between Smart Contracts. Those reside on an address. Addresses can be stored in Smart Contracts and can be used to transfer Ether from the Smart Contract to to an address stored in a variable.
* That's where variables of the type address come in.
* In general, a variable of the type address holds 20 bytes. That's all that happens internally. Let's see what we can do with Solidity and addresses.

### IMPORTANT CONCEPTS

* As you continue, please pay special attention to the following few concepts here which are really important and different than in any other programming language:

  * The Smart Contract is stored under its own address
  * The Smart Contract can store an address in the variable "someAddress", which can be its own address, but can be any other address as well.
  * All information on the blochain is public, so we can retrieve the balance of the address stored in the variable "someAddress"
  * The Smart Contract can transfer funds from his own address to another address. But it cannot transfer the funds from another address.
  * Transferring Ether is fundamentally different than transferring ERC20 Tokens or NFTs, as you will see later.
  * Before you continue, read the statements above and keep them in mind. These are the most mind-blowing facts for Ethereum newcomers.

### Ethereum Denominations

|Unit |Wei Exp|Wei
|-----|-------|---|
|wei  |1	    |1
|Kwei	|10^3	  |1,000
|Mwei	|10^6	  |1,000,000
|Gwei	|10^9	  |1,000,000,000
|Ether|10^18	|1,000,000,000,000,000,000

## Writing, View and Pure Functions

* [LAB](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/07-writing-view-pure-functions/)

* So far, we have mostly interacted and modified state variables from our Smart Contract. For example, when we write the address, we modify a state variable. When we update an uint variable, we also modify the state.
* For this, we needed to send a transaction. That works very transparently in Remix and also looks instantaneous and completely free of charge, but in reality it isn't. Modifying the State costs gas, is a concurrent operation that requires mining and doesn't return any values.
* Reading values, on the other hand, is virtually free and doesn't require mining.
* There are two types of reading functions:
  * view: Accessing state variables
  * pure: Not accessing state variables


### Writing Functions
* As before, let's quickly create a state-modifing writing function:

```solidity

//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }


}

```

* As you can see here, a writing function can have return variables, but they won't actually return anything to the transaction initializer. There are several reason for it, but the most prominent one is: at the time of sending the transaction the actual state is unknown. It is possible that someone sends a competing transaction that alters the state and from there it only depends on the transaction ordering - which is something that happens on the miner side. You will see that extensively in the next section.

* What's the return variable for then?

* It's for Smart Contract communication. It is used to return something when a smart contract calls another smart contract function.

* How to return variables then in Solidity? With Events! Something we're talking about later on.


### View Functions

* A view function is a function that reads from the state but doesn't write to the state. A classic view function woule be a getter-function. Let's extend the smart contract and write one:

```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }


}
```
### Pure Functions
* A pure function is a function that neither writes, nor reads from state variables. It can only access its own arguments and other pure functions. Let me give you an example:

```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    function getAddition(uint a, uint b) public pure returns(uint) {
        return a+b;
    }

    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }


}
```

## Understanding The Constructor

* [LAB](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/08-solidity-constructor/)

* The constructor is a special function. It is automatically called during Smart Contract deployment. And it can never be called again after that.


## The Blockchain Messenger Implementation

* [LAB](https://ethereum-blockchain-developer.com/2022-02-solidity-basics-blockchain-messenger/10-the-blockchain-messenger/)

* In this project, you are going to implement a simple messenger functionality in a Smart Contract.
  * Through the constructor make sure you write the address that deployed the contract to a variable
  * Create a message-variable of the type string, that only the deployer-address can update
  * Create a counter, to see how many times the variable was updated.


```solidity
//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract TheBlockchainMessenger {

    uint public changeCounter;

    address public owner;

    string public theMessage;

    constructor() {
        owner = msg.sender;
    }

    function updateTheMessage(string memory _newMessage) public {
        if(msg.sender == owner) {
            theMessage = _newMessage;
            changeCounter++;
        }
    }
}

```

# Section 4: [Project] Smart Money - Deposit And Withdrawals

## Installing And Configuring MetaMask

* That is a browser plugin which can securely store private keys and connect to different blockchains.
* [LAB](https://ethereum-blockchain-developer.com/2022-03-deposit-withdrawals/01-installing-configuring-metamask/)


## Get Free Ether And Send Transactions

* [LAB](https://ethereum-blockchain-developer.com/2022-03-deposit-withdrawals/02-getting-testnet-ether/)
* Network Selection
  * Attention here: some of the pictures have "Ropsten" selected, but the Ropsten test-network had a couple of hiccups, so I recommend Goerli instead!

  * Also, since the PoS Merge, Kovan and Rinkeby are getting deprecated. Sepolia is not very reliable in my opinion. Best is, to try Görli.

* Faucets
  * Sometimes Faucets don't work as expected. Unfortunately there is nothing much that I can do about it. It is time intensive to run a faucet and usually it doesn't pay off economically. Here is a list of Faucets in case the one here doesn't work, you can probably switch to another one:

  * My current go-to Faucet I really like for all networks: https://faucet.paradigm.xyz

  * Ropsten: https://faucet.metamask.io

  * Rinkeby: https://faucet.rinkeby.io https://www.rinkebyfaucet.com https://app.mycrypto.com/faucet https://faucets.chain.link/rinkeby

  * Kovan: https://gitter.im/kovan-testnet/faucet basically post your eth address in the gitter chat

  * Görli: https://fauceth.komputing.org/?chain=5 https://goerli-faucet.slock.it/index.html https://faucet.goerli.mudit.blog

  * Another "special edition" Faucet is maintained by Keir "Blockchain-Gandalf" Finlow-Bates, who also wrote a great book about Blockchains. He tries to maintain it as good as possible and it outputs Ropsten Ether: https://moonborrow.com

  * Kintsugi (Eth2.0): https://kintsugi.themerge.dev

## (Behing The Scenes) Metamask

* Metamask -> RPC -> Infure > Blockchain Node -> Blockchain
* Infura
  * Service Provider
  * Runs its own blockchain nodes internally in the datacenters
  * They have convenient access to those blockchain nodes and the blockchain nodes itself
  * They are storing or they are sincronyzing the data with the blockchain and alaways keeping it up to date
  * Uses RPC

* Key Take-Aways
  * You need a blockchain node to interact with the Blockchain
  * The Blockchain is the single source of truth
  * There are infrastructure providers to abstract running Blockchains aways

![](imgs/metamask-behing-the-scenes.png)

## (Behing The Scenes) An Ethereum Transaction

* (WEB3JS Documentation)[https://web3js.readthedocs.io/en/v1.2.11/web3-eth.html]

* sendTransaction function

```js
web3.eth.sendTransaction(transactionObject [, callback])
```

* Parameters

* 1 - **Object** - The transaction object to send:
  * from - String | Number: The address for the sending account. Uses the web3.eth.defaultAccount property, if not specified. Or and address or index of a local wallet in web3.eth.accounts.wallet.
  * to - String: (optional) The destination address of the message, left undefined for a contract-creation transaction.
  * value - Number|String|BN|BigNumber: (optional) The value transferred for the transaction in **wei**, also the endowment if it’s a contract-creation transaction.
  * gas - Number: (optional, default: To-Be-Determined) The amount of gas to use for the transaction (unused gas is refunded).
  * gasPrice - Number|String|BN|BigNumber: (optional) The price of gas for this transaction in wei, defaults to web3.eth.gasPrice.
  * data - String: (optional) Either a ABI byte string containing the data of the function call on a contract, or in the case of a contract-creation transaction the initialisation code.
  * nonce - Number: (optional) Integer of the nonce. This allows to overwrite your own pending transactions that use the same nonce.
  * chain - String: (optional) Defaults to mainnet.
  * hardfork - String: (optional) Defaults to petersburg.
  * common - Object: (optional) The common object
  * customChain - Object: The custom chain properties
  * name - string: (optional) The name of the chain
  * networkId - number: Network ID of the custom chain
  * chainId - number: Chain ID of the custom chain
  * baseChain - string: (optional) mainnet, goerli, kovan, rinkeby, or ropsten
  * hardfork - string: (optional) chainstart, homestead, dao, tangerineWhistle, spuriousDragon, byzantium, constantinople, petersburg, or istanbul
* 2 - callback - Function: (optional) Optional callback, returns an error object as first parameter and the result as second.


* How does "the Blockchain" know that the transaction is not malicious? Or, in other words:
* How does the Blockchain know it's allowed to transfer [value] from account [from] to account [to]?

* Ethereum Transaction Signature

* signTransaction function



## (Behind The Scenes) Hashing

## Cancel Or Update Ethereum Transactions

## Remix And The Injected Web3 Provider

## The Payable Modifier And Msg.value

## (The Fallback Functions) Fallback And Receive

## The Smart Money Implementation

