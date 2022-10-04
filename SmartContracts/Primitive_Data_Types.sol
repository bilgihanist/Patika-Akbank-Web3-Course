// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Primitives {
    bool public boo = true;

    /*
        uint işaretsiz tamsayıdır yani negatif olmayan sayı
        uint8  0 ile 2 ** 8 - 1 arasında değişir.
        uint16 0 ile 2 ** 16 - 1 arasında değişir.
        uint24 0 ile 2 ** 24 - 1 arasında değişir.
        ...
        uint256 0 ile 2 ** 256 - 1 arasında değişir.
    */

    uint8 public u8 = 1;
    uint public u256 = 456;
    uint public u = 123;  // uint aslında uint256 nın kısaltılmışıdır.

    /*
        negatif sayılr için int türlerine izin verilir.

        int256 ranges from -2 ** 255 to 2 ** 255 - 1
        int128 ranges from -2 ** 127 to 2 ** 127 - 1
    */

    int8 public i8 = -1;
    int public i256 = 456;
    int public i = -123;

    int public minInt = type(int).min;
    int public macInt = type(int).max;

    //address public addr = 0xabc...;

/*
     Solidity'de veri türü baytı, bir bayt dizisini temsil eder.
     Solidity 2 tür bayt türü sunar.

     fixed-sized byte arrays
     dynamically-sized byte arrays.

     Solidity'deki bayt terimi, dinamik bir bayt dizisini temsil eder.
*/

    bytes1 a = 0xb5; //[10110101]
    bytes1 b = 0x56; //[01010110]

    
}