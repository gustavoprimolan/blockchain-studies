//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

//Any one can store ether on its own wallet
//Can transfer money to other addresses
//Validate amount of that wallet
contract MySmartWallet {

  mapping(address => uint) private userWallet;

  // https://www.tutorialspoint.com/solidity/solidity_events.htm
  event Deposited(address from, uint amount);

  function deposit() public payable {
    require(msg.value > 0, "You need to deposit values higher than 0 wei");
    userWallet[msg.sender] = msg.value;
    emit Deposited(msg.sender, msg.value);
  }

  function withdrawal(address _to, uint _amount) public payable {
    require(
      msg.value == 0, 
      "You can't send money to this method"
    );
    
    uint userBalance = userWallet[msg.sender];
    
    require(
      userBalance >= _amount, 
      "You don't have balance to transfer this amount"
    );
    
    payable(_to).transfer(_amount);
    uint balanceAfterWithdrawal = userBalance - _amount;
    userWallet[msg.sender] = balanceAfterWithdrawal;
  }

  function getWalletTotalBalance() external view returns(uint) {
    return address(this).balance;
  }
  // View functions ensure that they will not modify the state. 
  // A function can be declared as view.
  function checkMyBalance() external view returns(uint) {
    return userWallet[msg.sender];
  }

}