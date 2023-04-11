//SPDX-License-Identifier: MIT

// THIS VERSION IN ORDER TO TEST THE INTEGER ROLL AS EXAMPLE
pragma solidity 0.7.0;

contract ExampleExceptionAssert {

  //CHANGING TO uint to uint8 THE RANGE IS 0 TO 255 (PROPOSITAL BUG)
  mapping (address => uint8) public balanceReceived;

  function receiveMoney() public payable {

    // Asserts are here to check states of your Smart Contract that should never be violated. For example: a balance can only get bigger if we add values or get smaller if we reduce values.
    assert(msg.value == uint8(msg.value));

    balanceReceived[msg.sender] += uint8(msg.value);
  }

  function withdrawaMoney(address payable _to, uint8 _amount) public {
    require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting!");
    balanceReceived[msg.sender] -= _amount;
    _to.transfer(_amount);
    
  }

}