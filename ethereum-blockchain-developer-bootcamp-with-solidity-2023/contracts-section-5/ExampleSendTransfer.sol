//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract Sender {

  receive() external payable {}

  function withdrawTransfer(address payable _to) public {
    // transfer function will throw an exception for an error when the transfer fails
    _to.transfer(10);
  }

  function withdrawSend(address payable _to) public {
    // send function will return a boolean
    // in case you're using any kind of low level interaction with smart contracts and the send function
    // is a low level interaction
    bool isSent = _to.send(10);

    require(isSent, "Sending the funds was unsuccessful");
  }
}


// NOT DOING ANYTHING. ONLY GETTING THE MONEY TO INSIDE THE SMART CONTRACT
contract ReceiverNoAction {

  function balance() public view returns(uint) {
    return address(this).balance; //money of this smart contract
  }

  receive() external payable {}
}


// THIS ONE IS STORING IN A STORAGE VARIABLE. IT COSTS GAS AND IT COST QUITE A LOT OF GAS 
// IF YOU WANT TO WRITE TO A STORAGE VARIABLE IF YOU WRITE THE FIRST TIME, ESPECIALLY THE FIRST TIME
contract ReceiverAction {
  uint public balanceReceived;

  receive() external payable {
    balanceReceived += msg.value;
  }

  function balance() public view returns(uint) {
    return address(this).balance; //money of this smart contract
  }

}