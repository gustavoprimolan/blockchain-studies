//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ContractOne {

  mapping (address => uint) public addressBalances;

  function deposit() public payable {
    addressBalances[msg.sender] += msg.value;
  }

  receive() external payable {
    deposit();
  }

}

contract ContractTwo {
  receive() external payable {}

  function depositOnContractOne(address _contractOne) public {
    // ContractOne one = ContractOne(_contractOne);
    // provide 100,000 gas instead of the 2300 gas that is provided by send and transfer
    // one.deposit{value: 10, gas: 100000}();

    //same function call as above in bytes as before calling it is converted to a hash
    // bytes memory payload = abi.encodeWithSignature("deposit()");
    // (bool success, ) = _contractOne.call{value: 10, gas: 100000}(payload);
    // require(success);

    //10 wei into the call
    // fallback function ContractOne.receive() and then called deposit function
    (bool success, ) = _contractOne.call{value: 10, gas: 100000}(""); // it will hit the fallback function
    require(success);

  }
}