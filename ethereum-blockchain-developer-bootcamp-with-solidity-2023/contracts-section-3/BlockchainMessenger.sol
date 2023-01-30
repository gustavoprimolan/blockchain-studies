//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

// IT CAN STORE A STRING ON THE BLOCKCHAIN
// READABLE FOR EVERYONE, 
// BUT IT'S WRITEABLE ONLY FOR THE PERSON WHO DEPLOYED THE SMART CONTRACT

contract BlockchainMessenger {

  string public myString;
  address public deployedAddress;

  constructor() {
    deployedAddress = msg.sender;
  }


  function setMyString(string memory _myString) public {
    if(deployedAddress == msg.sender) {
      myString = _myString;
    }
  }

}