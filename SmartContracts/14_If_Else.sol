// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract IfElse {
    function deneme(uint _x) external pure  returns (uint) {
        if (_x < 10) {
            return 1;
        } else if (_x < 20){
            return 2;
        } else {
            return 3;
        }
    }

    function deneme2(uint _y) external pure returns (uint) {
        if (_y < 10){
            return 4;
        } 
        return 5; // else yazmadan sadece sonucu yazabiliriz kısaltma olarak!!!
        }
    

    function deneme3(uint _z) external pure returns (uint) {
        return _z < 10 ? 1 : 2;  // en kısa şekli if elsenin 
    } 
}