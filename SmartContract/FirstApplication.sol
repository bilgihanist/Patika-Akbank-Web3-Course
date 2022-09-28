// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Counter {
    uint public count;

    //Geçerli sayıyı alma işlevi
    function get() public view returns (uint){
        return count
    }

    //Sayıyı 1 arttırmak için
    function inc() public {
        count += 1;
    }

    //sayıyı 1 azalmak için
    function dec() public {
        // bu komut 0 da başarısız olacak.
        count -= 1;
    }
}