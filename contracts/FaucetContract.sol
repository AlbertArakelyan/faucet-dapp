// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {
    // this is a special function
    // it's called when you make a tx that doesn't specify
    // function name to call

    // External functions are part of the contract interface
    // which means they can be called via contracts and other txs
    receive() external payable {}

    function addFunds() external payable {}

    function justTesting() external pure returns (uint) {
        return 2 + 2;
    }

    // pure, view - read-only call, no gas fee
    // view - it indicates that the function will not alter the storage statee in any way
    // pure - even more strict, indicating that it won't even read the storage state

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
