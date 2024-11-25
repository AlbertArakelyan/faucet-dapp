// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Owned {
  address public owner;

  constructor	() {
		owner = msg.sender;
	}

  modifier onlyOwner() {
		require(msg.sender == owner, "Only owner can call this function");
		_; // _ is the body of the function that execited after modifier check e.g. withdraw()
	}
}