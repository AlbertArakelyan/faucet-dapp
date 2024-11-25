// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";

contract Faucet is Owned {
	uint public numOfFunders;
	// address[] private funders; -> converted into mapping (kind of converts to [key => value] pairs)
	mapping(address => bool) private funders;
	mapping(uint => address) private lutFunders; // look up table funders

	// private -> can be accesible only within the smart contract
	// internal -> can be accesible within the smart contract and also derived smart contract

	modifier limitWithdraw(uint withdrawAmount) {
		require(
			withdrawAmount <= 100000000000000000,
			"Cannot withdraw more than 0.1 ether"
		);
		_; // _ is the body of the function that execited after modifier check e.g. withdraw()
	}

	// this is a special function
	// it's called when you make a tx that doesn't specify
	// function name to call

	// External functions are part of the contract interface
	// which means they can be called via contracts and other txs
	receive() external payable {}

	function addFunds() external payable {
		// funders.push(msg.sender); // works with ordinary array, for mappings a bit different
		address funder = msg.sender;
		if (!funders[funder]) {
			uint index = numOfFunders++;
			funders[funder] = true;
			lutFunders[index] = funder;
		}
	}

	function test1() external onlyOwner {
		// some managing stuff that only admin should have access to (0x11Fa...)
	}

	function test2() external onlyOwner {
		// some managing stuff that only admin should have access to (0x11Fa...)
	}

	// first will be executed limitWithdraw modifier than the function
	function withdraw(uint withdrawAmount) external limitWithdraw(withdrawAmount) {
		payable(msg.sender).transfer(withdrawAmount);
	}

	// function getAllFunders() public view returns (address[] memory) { // this worked for ordinary array
	// 	return funders;
	// }

	function getAllFunders() external view returns (address[] memory) {
		address[] memory _funders = new address[](numOfFunders);

		for (uint i = 0; i < numOfFunders; i++) {
			_funders[i] = lutFunders[i];
		}

		return _funders;
	}

	function getFunderAtIndex(uint8 index) external view returns (address) {
		return lutFunders[index];
	}

	// pure, view - read-only call, no gas fee
	// view - it indicates that the function will not alter the storage statee in any way
	// pure - even more strict, indicating that it won't even read the storage state
	// with this keyword I can even call external functions, but gas pricess will be higher

	// external functions -> cannot be called inside of my smart contract
	// public functions -> can be called inside of my smart contract and from outside
	// external should be used for functions when you expect them to be called from outside, and public when you expect them to be called from inside

	// Transaction (can generate state changes) and require gas fee
	// read-only call, no gas fee

	// To talk to the node in network you can make JSON-RPC http calls
	// Read here about JSON-RPC: https://ethereum.org/en/developers/docs/apis/json-rpc/
}

// const instance = await Faucet.deployed() // (in truffle console)

// Block info
// Nonce - a hash when combined with the minHash proofs that
// the block has gone through proof of work (PoW)
// 8 bytes => 64 bits

// TODO write all comments in README with references to appropriate pieces of the code
