(async () => {
  //CHECK MyContract.sol
  const address = "ENTER_ADDRESS_HERE_FROM_RUN_TX_PLUGIN";
  // The ABI Array contains all functions, inputs and outputs, as well as all variables and their types from a smart contract.
  // you need abi array because web3 cannot guess what the functions names are
  const abi = [
    {
        "inputs": [],
        "name": "myUint",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "newUint",
                "type": "uint256"
            }
        ],
        "name": "setMyUint",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
  ];

  
  const contractInstance = new web3.eth.Contract(abiArray, address);

  console.log(await contractInstance.methods.myUint().call());

  let accounts = await web3.eth.getAccounts();
  let txResult = await contractInstance.methods.setMyUint(345).send({from: accounts[0]});
  
  console.log(await contractInstance.methods.myUint().call());
  console.log(txResult);
})()