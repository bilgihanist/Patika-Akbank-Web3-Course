// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constructor {
    // durum değişkeni tipinde bir adres sahibine sahibiz.
    // x adında bir birim durum değişkeni
    address public owner;
    uint public x;

    // sözleşme dğıtılırken sadece bir kez çağrılan bir işlevdir.
    constructor(uint _x){
        owner = msg.sender;
        x = _x;
    }
}

/*-----------------------------------------*/

//Basit contract X
contract X {
    string public name;
    constructor(string memory _name) {
        name = _name;
    }
}

//Base Constract Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// üst sözleşmeyi parametrelerle başlatmanın 2 yolu vardır.
// There are 2 ways to initialize parent contract with parameters.

//parametreleri kalıtım listesinde buraya iletin

// Pass the parameters here in the inheritance list.
contract B is X("Input to X"), Y("Input to Y") {

}

contract C is X,Y {
/*
Pass the parameters here in the constructor
Parametreleri constructor'de buraya iletin.
similar to function modifiers.
Fonksiyon değiştiricilere benzer.
*/
constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}
/*
Parent constructors are always called in the order of inheritance
Üst yapıcılar her zaman kalıtım sırasına göre çoğalır.
regardless of the order of parent contracts listed in the
Listede listelenen ana sözleşmenlerin sırasına bakılmaksızın
constructor of the child contract.
*/

// Order of constructors called:
// 1. X
// 2. Y
// 3. D
contract D is X,Y {
    constructor() X("X was called") Y("Y was called") {}
}

// Order of constructors called:
//Çağrılan yapıcıların sırası:
// 1. X
// 2. Y
// 3. E
contract E is X,Y {
    constructor() Y("Y was called") X("X was called") {}
}






