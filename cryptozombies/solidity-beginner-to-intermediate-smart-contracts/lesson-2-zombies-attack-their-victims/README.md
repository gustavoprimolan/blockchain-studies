# Zombies Attack Their Victims


## Chapter 2: Mappings and Addresses

* Addresses
    * The Ethereum blockchain is made up of accounts, which you can think of like bank accounts. An account has a balance of Ether (the currency used on the Ethereum blockchain), and you can send and receive Ether payments to other accounts, just like your bank account can wire transfer money to other bank accounts.

    * Each account has an address, which you can think of like a bank account number. It's a unique identifier that points to that account, and it looks like this:

    * 0x0cE446255506E92DF41614C46F1d6df9Cc969183

    * (This address belongs to the CryptoZombies team. If you're enjoying CryptoZombies, you can send us some Ether! 😉 )

    * We'll get into the nitty gritty of addresses in a later lesson, but for now you only need to understand that an address is owned by a specific user (or a smart contract).

    * So we can use it as a unique ID for ownership of our zombies. When a user creates new zombies by interacting with our app, we'll set ownership of those zombies to the Ethereum address that called the function.

* Mappings
    * In Lesson 1 we looked at structs and arrays. Mappings are another way of storing organized data in Solidity.

    * Defining a mapping looks like this:

    * ```solidity
        // For a financial app, storing a uint that holds the user's account balance:
        mapping (address => uint) public accountBalance;
        // Or could be used to store / lookup usernames based on userId
        mapping (uint => string) userIdToName;
        ```
    * A mapping is essentially a key-value store for storing and looking up data. In the first example, the key is an address and the value is a uint, and in the second example the key is a uint and the value a string.

## Chapter 3: Msg.sender

* msg.sender

    * In Solidity, there are certain global variables that are available to all functions. One of these is msg.sender, which refers to the address of the person (or smart contract) who called the current function.

    * Note: In Solidity, function execution always needs to start with an external caller. A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender.

    * Here's an example of using msg.sender and updating a mapping:

    * ```solidity 
        mapping (address => uint) favoriteNumber;

        function setMyNumber(uint _myNumber) public {
        // Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
        favoriteNumber[msg.sender] = _myNumber;
        // ^ The syntax for storing data in a mapping is just like with arrays
        }

        function whatIsMyNumber() public view returns (uint) {
        // Retrieve the value stored in the sender's address
        // Will be `0` if the sender hasn't called `setMyNumber` yet
        return favoriteNumber[msg.sender];
        }
        ```
    * In this trivial example, anyone could call setMyNumber and store a uint in our contract, which would be tied to their address. Then when they called whatIsMyNumber, they would be returned the uint that they stored.

    * Using msg.sender gives you the security of the Ethereum blockchain — the only way someone can modify someone else's data would be to steal the private key associated with their Ethereum address.

## Chapter 4: Require

* How can we make it so this function can only be called once per player?

* For that we use require. require makes it so that the function will throw an error and stop executing if some condition is not true:

```solidity
function sayHiToVitalik(string memory _name) public returns (string memory) {
  // Compares if _name equals "Vitalik". Throws an error and exits if not true.
  // (Side note: Solidity doesn't have native string comparison, so we
  // compare their keccak256 hashes to see if the strings are equal)
  require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")));
  // If it's true, proceed with the function:
  return "Hi!";
}
```

* If you call this function with sayHiToVitalik("Vitalik"), it will return "Hi!". If you call it with any other input, it will throw an error and not execute.

* Thus require is quite useful for verifying certain conditions that must be true before running a function.

## Chapter 5: Inheritance

```solidity
contract Doge {
  function catchphrase() public returns (string memory) {
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string memory) {
    return "Such Moon BabyDoge";
  }
}
```

* BabyDoge inherits from Doge. That means if you compile and deploy BabyDoge, it will have access to both catchphrase() and anotherCatchphrase() (and any other public functions we may define on Doge).

* This can be used for logical inheritance (such as with a subclass, a Cat is an Animal). But it can also be used simply for organizing your code by grouping similar logic together into different contracts.



## Chapter 6: Import

* When you have multiple files and you want to import one file into another, Solidity uses the import keyword:

```solidity
import "./someothercontract.sol";

contract newContract is SomeOtherContract {

}
```
* So if we had a file named someothercontract.sol in the same directory as this contract (that's what the ./ means), it would get imported by the compiler.

## Chapter 7: Storage vs Memory (Data location)

* In Solidity, there are two locations you can store variables — in storage and in memory.

* Storage refers to variables stored permanently on the blockchain. Memory variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.

* Most of the time you don't need to use these keywords because Solidity handles them by default. State variables (variables declared outside of functions) are by default storage and written permanently to the blockchain, while variables declared inside functions are memory and will disappear when the function call ends.

* However, there are times when you do need to use these keywords, namely when dealing with structs and arrays within functions:

```solidity
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ Seems pretty straightforward, but solidity will give you a warning
    // telling you that you should explicitly declare `storage` or `memory` here.

    // So instead, you should declare with the `storage` keyword, like:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
    // in storage, and...
    mySandwich.status = "Eaten!";
    // ...this will permanently change `sandwiches[_index]` on the blockchain.

    // If you just want a copy, you can use `memory`:
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...in which case `anotherSandwich` will simply be a copy of the
    // data in memory, and...
    anotherSandwich.status = "Eaten!";
    // ...will just modify the temporary variable and have no effect
    // on `sandwiches[_index + 1]`. But you can do this:
    sandwiches[_index + 1] = anotherSandwich;
    // ...if you want to copy the changes back into blockchain storage.
  }
}

```

* Don't worry if you don't fully understand when to use which one yet — throughout this tutorial we'll tell you when to use storage and when to use memory, and the Solidity compiler will also give you warnings to let you know when you should be using one of these keywords.

* For now, it's enough to understand that there are cases where you'll need to explicitly declare storage or memory!

## Chapter 8: Zombie DNA

* The formula for calculating a new zombie's DNA is simple: the average between the feeding zombie's DNA and the target's DNA.

* For example:

```solidity
function testDnaSplicing() public {
  uint zombieDna = 2222222222222222;
  uint targetDna = 4444444444444444;
  uint newZombieDna = (zombieDna + targetDna) / 2;
  // ^ will be equal to 3333333333333333
}
```

* Later we can make our formula more complicated if we want to, like adding some randomness to the new zombie's DNA. But for now we'll keep it simple — we can always come back to it later.

```solidity
//zombiefactory.sol
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    // edit function definition below
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

```


```solidity
//zombiefeeeding.sol
pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

}


```