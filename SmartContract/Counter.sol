// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

    contract Counter {
        uint public count;

        //Geçerli sayıyı alma
        function get() public view returns (uint) {
            return count;
        }
        //sayıyı 1 arttır.
        function inc() external {
            count += 1;
        }
        //sayıyı 1 azalt.
        function dec() external {
            //bu fonksiyon sayı sıfır olunca çalışmaz
            count -=1;
        }
    }