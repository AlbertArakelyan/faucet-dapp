// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
    uint8 public a = 7; // 1 byte
    uint16 public b = 10; // 2 bytes
    address public c = 0x11Fa9f2ec225e60F36db1e8140d42F4A8DCD7b9c; // 20 bytes
	bool d = true; // 1 byte
	uint64 public e = 15; // 8 bytes
	// 32 bytes, all values will be stored in slot 0
	// 0x 0f 01 11Fa9f2ec225e60F36db1e8140d42F4A8DCD7b9c 000a 07

	uint256 public f = 200; // 32 bytes -> slot 1
	uint8 public g = 40; // 1 byte -> slot 2 // order matters, if this was before it would stay alone occupying only 1 byte and an entire slot
	uint256 public h = 789; // 32 bytes -> slot 3
	// other values will also be stored in slot 3 (if they are smaller than 32 bytes, when "g" was before "h")
}
