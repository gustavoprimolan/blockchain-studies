//SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

contract EventExample {

    mapping(address => uint) public tokenBalance;

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    

}