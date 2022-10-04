// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ViewAndPure {
    uint public x=1;

    // Promise not to modify the state.
    // Durumu değişitirmeyecekse "view" yazılır.
    function addToX(uint y) public view returns (uint) {
        return x+ y;
    }

    // Promise not to modify or read from the state.
    // Durumu değiştirmeyeceğine veya durumdan okumayacağına söz ver

    function add(uint i,uint j) public pure returns (uint) {
        return i+ j;
    }

}