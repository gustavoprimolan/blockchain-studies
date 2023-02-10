//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;



// however there is no function on this contract you can do a LOW LEVEL INTERACTIONS
// it will basically just send one single transfer, one single transaction
// By default the SMART CONTRACT CANNOT receive anything
// There's only one chance the smart contract can receive something, and that is by letting another smart contract
// self-destruct with these smart contracts address as a beneficiary
contract SampleFallback {

  //if the constructor is noy payable, then you cannot send a value together witht the deployment
  // the constructor is not payable by default

  uint public lastValueSent;
  string public lastFunctionCalled;
  uint public myUint;

  function setMyUint(uint _myNewUint) public {
    myUint = _myNewUint;
  }

  //receiver function is a function that can receive ether and then it needs to be defined as receive
  // you can execute it as a LOW LEVEL INTERACTION WITHOUT DATA
  // otherwise, if there is a calldata, it will need a fallback function
  // the problem with the receiver function is it can only rely on 2300 gas, which is really low
  // it so called gas steepened because if somebody is sending a transaction without any data
  // or anything to the smart contract, especially if another contract is interacting with this contract
  // and just sending and ether or some value, then it will not have enough gas to actually
  // do something meaninful
  // you cannot even write a function where any call any other function or write any storage variable
  // we are still going to do that because we are providing here enough gas
  // we are sinding enough gas to the smart contract with our transcation, but you cannot rely on it
  // you sould never rely on more than 2300 gas
  receive() external payable {
    lastValueSent = msg.value;
    lastFunctionCalled = "receive";
  }


  // if you have a fallback function that is payable but NO RECEIVE FUNCTION, then no matter if
  // a calldata or there's a data sent, it WILL CALL the FALLBACK FUNCTION
  // payable is optional
  // if you want to have a function that gets called in case no other function matches the data
  // then it will hit the fallback function
  // if you want that fallback function to also be able to receive any value, then you add the payable modifier
  fallback() external payable {
    lastValueSent = msg.value;
    lastFunctionCalled = "fallback";
  }

}