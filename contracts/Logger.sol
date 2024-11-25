// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// It's a way for designeer to say that
// "any child of this abstract contract has to implement specific methods"

abstract contract Logger {
  // just provides function definations, not the implementations
  // the contract inheriting this has to implement those functions
  uint public testNum;

  constructor() {
    testNum = 100;
  }

  function emitLog() public pure virtual returns (bytes32);

  function test3() external pure returns (uint) {
    return 100;
  }
}