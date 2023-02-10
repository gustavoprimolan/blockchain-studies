//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SampleContract {
  string public myString = "Hello World";

  // payable keyword - we have to mark functions that are meant to receive ETH with a payabla modifier
  // now the method can receive ether
  // the ether can be stuck in the contract and as long as we're not sending it away
  // it will stay there forever
  // it is necessary send it back to an address
  function updateString(string memory _newString) public payable {
    // ether is global unit
    // likey gwei. There's a couple of them
    // value get the ether sent to the smart contract
    if(msg.value == 1 ether) {
      myString = _newString;
    
    } else {
      // else send the ether back
      // as sender is just an address it needs to be wrapped in payable casting modifiers
      // with payable every variable of the type address has a transfer function
      // and this transfer function will transfer from the SMART CONTRACT the value to the ADDRESS back
      // now the smart contract can take care of his own money
      // so you can send money to the smart contract, it can be stored there, there is nothign that the logic itself needs to do it is natively on the EVM level and it can send it back
      payable(msg.sender).transfer(msg.value);
    }
  }

}