// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

// Data types - values and references

contract Variables{
    // Yorum satırı
    /*
        Yorum satırı
    */

}

contract ValueTypes {

    // fixed-size Types
    bool public b = true;
    bool isTrue = true; // varsayılan false
    int256 number = 55; // -2^256 to 2^256 -1
    uint number2 = 100; // 0 to 2^256 -1
    address adr; // 0x123...  - 20 byte
    bytes32 data; // bytes1 0> bytes32

    //Dynamic-Size Types
    string name;
    bytes datas;
    uint[] numbers; // [1,2,3,4]

    //User Defined Value Types

    struct Woman {
        uint ID;
        string name;
        string surname;
        uint age;
    }

    enum trafficLight {
        Red,
        yellow,
        Green
    }
        /*
        Operatörler:
        ! : (mantıksal olumsuzlama)
        && : (mantıksal bağlaç, “ve”)
        || :  (mantıksal ayrılma, “veya”)
        == : eşitlik
        != : eşitsizlik

        Ether Birimleri
        1 wei: 1
        1 gwei: 10^9 wei =  1000000000
        1 ether: 10^18 wei = 1000000000000000000

        Zaman Birimleri
        1 seconds = 1
        1 minutes = 60
        1 hours = 3600
        1 days = 86400
        1 weeks=  6048000

        */

        //State Variables
        string public name2 = "Deneme";
        uint256 public name1 = 2022;
        bool private poor = false;

        function add(int256 _number) public pure returns (int256) {
            // Local Variables
            int256 minus = -1;
            int256 lucky = 33;

            return _number + minus + lucky;
        }

        //Global Variables
/*
        block.difficulty (uint) Current block difficulty
        block.gaslimit (uint)   Current block gaslimit
        block.number (uint)     Current block number
        block.timestamp (uint)  Current block timestamp as seconds since unix epoch
        msg.data (bytes calldata)   Complete calldata
        msg.sender (address payable)
*/

    //POZİTİF DEĞER ATAMAK İSTİYORSAK 
    uint public u = 123;  // uint = uint256 0 to 2**256 - 1
                          //        uint8   0 to 2**8 - 1
                          //        uint16  0 to 2**16 - 1
    //NEGATİF DEĞER ATAMAK İSTİYORSAK
    int public i = -123;  // int = int256   -2**255 to 2**255 -1
                          //       int128   -2**127 to 2**127 -1

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

/*
    address public addr = 0x123; // buraya 0x ile başlayan eth wallet adresi yazılır.
    bytes32 public b32 =  0x123; // 0x ile başlayan 66 karakterlik hash adresi yazılır. 
*/
}
