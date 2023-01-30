//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleAddress {
  // DEFAULT: 20 bytes of zeros
  // DEFAULT: 0x0000000000000...
  address public someAddress;

  function setSomeAddress(address _someAddress) public {
    someAddress = _someAddress;
  }

  function getAddressBalance() public view returns(uint) {
    // it should show you the balance in Wei
    return someAddress.balance;
  }

}