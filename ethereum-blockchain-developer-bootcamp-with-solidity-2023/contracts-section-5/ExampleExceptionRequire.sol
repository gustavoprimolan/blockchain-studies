//SPDX-License-Identifier: MIT

// THIS VERSION IN ORDER TO TEST THE INTEGER ROLL AS EXAMPLE
pragma solidity 0.7.0;

contract ExampleExceptionRequire {

  mapping (address => uint) public balanceReceived;

  function receiveMoney() public payable {
    balanceReceived[msg.sender] += msg.value;
  }

  function withdrawaMoney(address payable _to, uint _amount) public {
    // if(_amount <= balanceReceived[msg.sender]) {
    //     balanceReceived[msg.sender] -= _amount;
    //     _to.transfer(_amount);
    // }

    // if evaluate to false, then it will rollback the complete transaction
    // everything with the transaction will be rollbacked and it won't exist anymore
    require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting!");
    balanceReceived[msg.sender] -= _amount;
    _to.transfer(_amount);
    
  }

}