//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleMsgSender {

  address public someAddress;

  function updateSomeAddress() public {
    // if an account is calling the contract, then it will contain the address of the account
    // Acc -> Contract 
    // msg.sender = Acc
    someAddress = msg.sender;
  }

}