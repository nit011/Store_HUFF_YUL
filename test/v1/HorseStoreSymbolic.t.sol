// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Base_TestV1, HorseStore, HorseStoreYul} from "./Base_TestV1.t.sol";

contract HorseStoreSymbolic is Base_TestV1 {
    function setUp() public override {
        super.setUp();

        
        bytes memory deployBytecode =
            hex"602b8060093d393df35f3560e01c8063cdfead2e1461001b578063e026c01714610022575b6004355f55005b5f545f5260205ff3";
        address horseStoreHuffAddr;
        assembly {
            horseStoreHuffAddr := create(0, add(deployBytecode, 0x20), mload(deployBytecode))
        }
        horseStoreHuff = HorseStore(horseStoreHuffAddr);
    }

    
    function check_storeAndReadAreIdentical(uint256 randomNumber) public {
        horseStoreHuff.updateHorseNumber(randomNumber);
        horseStoreYul.updateHorseNumber(randomNumber);
        horseStoreSol.updateHorseNumber(randomNumber);

        assert(horseStoreHuff.readNumberOfHorses() == randomNumber);
        assert(horseStoreYul.readNumberOfHorses() == randomNumber);
        assert(horseStoreSol.readNumberOfHorses() == randomNumber);
    }
}
