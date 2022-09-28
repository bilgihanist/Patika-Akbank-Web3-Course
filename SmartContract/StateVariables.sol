// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract StateVariables {
    /*
Solidity’de 3 tür değişken vardır:

1.)	Yerel(Local)
    a.	Blockchain’de saklanmaz
    b.	Fonksiyon içinde bildirilir
2.)	Durum(State)
    a.	Fonksiyon dışında bildirilir.
    b.	Blockchain’de saklanır
3.)	Global
    a.	Blockchainvil ilgili değişkenler
*/

// Durum değişkenleri Blockchain'de saklanır.

    uint public myUint = 12;

    function foo() external {
        uint notStateVariable = 16;
    }


    string public text = "Hello";
    uint public num = 1234;

    function doSomething() public {
        //Yerel değişkenler blockchain'de saklanmaz.
        uint i= 19;
    }

    //Global değişkenler
    uint timestamp = block.timestamp; // geçerli block zaman damgası
    address  sender = msg.sender; // arayanın adresi
}