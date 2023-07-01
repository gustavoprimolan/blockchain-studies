(async () => {
  let accounts = web3.eth.getAccounts();
  console.log(accounts, accounts.length);
  let balance = await web3.eth.getBalance(accounts[0]);
  console.log(balance);
  let balanceInEth = await web3.utils.fromWei(balance, "ether");
  console.log(balanceInEth);
})()