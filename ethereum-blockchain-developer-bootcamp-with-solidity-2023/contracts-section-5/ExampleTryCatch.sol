//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract WillThrow {

error NotAllowedError(string);

  function aFunction() public pure {
    // POSSIBLE CATCH AN ERROR
    // require(false, "Error message"); 

    // POSSIBLE CATCH A PANIC
    // assert(false);

    //CUSTOM ERROR IN BYTE ARRAY
    revert NotAllowedError("You are not allowed");

  }

}

//YOU CAN ONLY HANDLE THE ERROR IN ANOTHER CONTRACT
contract ErrorHandling {
  
  // type event to me emitted
  event ErrorLogging(string reason);
  event ErrorLogCode(uint code);
  event ErrorLogBytes(bytes lowLevelData);


  function catchTheError() public {
    WillThrow will = new WillThrow();
    try will.aFunction() {
      //add code here if it works
    
    
    } catch Error(string memory reason) { // Error has message CAUSED BY REQUIRE
      emit ErrorLogging(reason);
    
    } catch Panic(uint errorCode) { // GET A CODE CAUSED BY ASSERTS
      emit ErrorLogCode(errorCode);
    
    } catch (bytes memory lowLevelData) { //CUSTOM ERROR CAUSED IN LINE 17
      emit ErrorLogBytes(lowLevelData); //IT WILL BE REQUIRED HANDLE THE BYTE TO ME TRANSLATED IN SOME MEANINGFUL TEXT
    }

  }

}