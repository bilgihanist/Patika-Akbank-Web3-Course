// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Immutable {
    //45718 gas
    address public immutable owner; // = msg.sender;
    //43585 gas immutable farkı 

constructor () {
    owner = msg.sender; 
}
// değişmez bir değişkeni constructor ile ile bildirilir.
    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x +=1;
    }
}

// değişmez değişkenler sabit gibidir.  ancak sözleşme 
// dağıtıldığında yalnızca bir kez başlatılır.

/*
İmmutable'ler değiştirilemeyen variable'lerdir. Constant'dan farkı
immutable ile işaretlenen değişkenin değerinin başlangıçta constructor
ile değiştirilebilmesidir.
*/