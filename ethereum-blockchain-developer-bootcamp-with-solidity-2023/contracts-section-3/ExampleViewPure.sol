//SPDX-License-Identifier: MIT

contract ExampleViewPure {

  uint public myStorageVariable;


  //A view function is a function that reads from the state but doesn't write to the state. 
  // A classic view function woule be a getter-function.
  function getMyStorageVariable() public view returns(uint) {
    return myStorageVariable;
  }


  // A pure function is a function that neither writes, 
  //nor reads from state variables. 
  //It can only access its own arguments and other pure functions.
  function getAddition(uint a, uint b) public pure returns(uint) {
    return a+b;
  }

  // writing function can have return variables, 
  //but they won't actually return anything to the transaction initializer.
  
  function setMyStorageVariable(uint _newVar) public returns(uint) {
    myStorageVariable = _newVar;
    return _newVar;
  }

}
