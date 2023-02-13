//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleMapping {

  // if public it will create a function that receives a key and search in this mapping
  mapping(uint => bool) public myMapping;
  mapping(address => bool) public myAddressMapping;

  // compositive key
  mapping(uint => mapping(uint => bool)) public uintUintBoolMapping;

  // That is the function the blockchain creates to access a public mapping
  // function myMapping(uint _key) public view returns(bool) {
  //   return myMapping[_key];
  // }


  function setValue(uint _index) public {
    myMapping[_index] = true;
  }

  function setMyAddressToTrue() public {
    myAddressMapping[msg.sender] = true;
  }

  function setUintUintBoolMapping(uint _key1, uint _key2, bool _value) public {
    // composite key
    uintUintBoolMapping[_key1][_key2] = _value;
  }

}