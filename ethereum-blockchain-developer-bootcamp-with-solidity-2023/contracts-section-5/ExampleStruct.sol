//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract Wallet {

  //IT WILL BE ANOTHER ADDRESS, AS IT IS ANOTHER CONTRACT IT WILL BE DEPLOYED
  // IT DON'T SAVE GAS AS IT IS ANOTHER CONTRACT DEPLOYING IT
  // CHILD CONTRACT
  PaymentReceived public payment;
  
  function payContract() public payable {
    payment = new PaymentReceived(msg.sender, msg.value);
  }

}

// CHILD CONTRACT
//IT WILL BE ANOTHER ADDRESS, AS IT IS ANOTHER CONTRACT IT WILL BE DEPLOYED
contract PaymentReceived {

  address public from;
  uint public amount;

  constructor(address _from, uint _amount) {
    from = _from;
    amount = _amount;
  }

}

contract Wallet2 {
  
  // NEW DATA TYPE AND IT WILL NOT BE DEPLOYED CREATING A NEW ADDRESS
  // IT IS BETTER SAVE GAS
  struct PaymentReceivedStruct {
    address from;
    uint amount;
  }

  PaymentReceivedStruct public payment;

  function payContract() public payable {
    //ONE WAY 
    // payment = PaymentReceivedStruct(msg.sender, msg.value);

    // ANOTHER WAY
    payment.from = msg.sender;
    payment.amount = msg.value;
  }

}