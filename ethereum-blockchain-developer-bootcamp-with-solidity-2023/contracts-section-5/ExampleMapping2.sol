//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleMappingWithdrawals {

  mapping(address => uint) public balanceReceived;

  // if there is a function without anything
  // the funds when executed this method is stored at the contract
  function sendMoney() public payable {
    balanceReceived[msg.sender] += msg.value;
  }

  function getBalance() public view returns(uint) {

  }

  //first check if the user has enough balance
  function withdrawalAllMoney(address payable _to) public {
    uint balanceToSendOut = balanceReceived[msg.sender];
    balanceReceived[msg.sender] = 0;
    _to.transfer(balanceToSendOut);
  }

}