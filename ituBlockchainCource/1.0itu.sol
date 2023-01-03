// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Variables {
    //Fixed-Size Types
    bool isTrue = false;
    int8 number = 12; //int256  -2^256 to 2^256
    uint number2 = 12; // 0 to 2^256

    address myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bytes32 name = "bilgihan";

    //DYNAMIC-SIZE TYPES

    string name3 = "bilgihan";

    // uint[] array = [0,1,2,3,4,5];

    // mapping(uint => address) isim;
    // isim[2]

    struct Human {
        uint ID;
        string name;
        uint age;
        address address1;
    }
    mapping (uint => Human) isim2;
    // Human person1;
    // person1.ID = 111;
    // person1.name = "bilgihan";
    // person1.age = 11;
    // person1.address1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;



    string public deneme = "atlas";

    function isim3() public view returns(string memory){
        return  deneme;
    }

    function show3() public view returns(address) {
            

        return msg.sender;
    }


}