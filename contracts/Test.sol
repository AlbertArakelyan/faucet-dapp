// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Test {
    function test(uint testNum) external pure returns (uint data) {
        assembly {
            // you can write lower level code

            // let _num := 4
            // let _fmp := mload(0x40)
			mstore(0x40, 0x90)
        }

        uint8[3] memory items = [1, 2, 3];

        // return testNum;
		assembly {
			data := mload(add(0x90, 0x20)) // points to number 2 in array, as 1 starts at 0x90 and we add 2 bytes
		}
    }

    function test2() external pure returns (bytes32 data) {
        assembly {
            let fmp := mload(0x40)
            // hello
            mstore(add(fmp, 0x00), 0x68656C6C6F)
            data := mload(add(fmp, 0x00))
        }
    }
}
