// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {
	uint public numOfFunders;

	mapping(address => bool) private funders;
	mapping(uint => address) private lutFunders; // look up table funders

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

  function emitLog() public override pure returns (bytes32) {
		// override -> we overridee its definition from abstract contract
		return "Hello World";
	}

	function addFunds() override external payable {
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
	function withdraw(uint withdrawAmount) override external limitWithdraw(withdrawAmount) {
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

	// To talk to the node in network you can make JSON-RPC http calls
	// Read here about JSON-RPC: https://ethereum.org/en/developers/docs/apis/json-rpc/
}

// Block info
// Nonce - a hash when combined with the minHash proofs that
// the block has gone through proof of work (PoW)
// 8 bytes => 64 bits