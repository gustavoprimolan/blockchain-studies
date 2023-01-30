//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleConstructor {

  // address public myAddress = msg.sender;
  address public myAddress;

  // DIRECTLY CALLED AT THE THE MOMENT OF THE DEPLOY
  // CAN'T BE CALLED AGAIN
  constructor(address _someAddress) {
    myAddress = _someAddress;
  }

  function setMyAddress(address _myAddress) public {
    myAddress = _myAddress;
  }

  function setMyAddressToMsgSender() public {
    myAddress = msg.sender;
  }



}