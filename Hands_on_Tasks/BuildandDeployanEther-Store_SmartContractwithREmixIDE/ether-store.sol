// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract FeeCollector {  //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
                        //0x5E683ceF9A50EA5A5FA15dd4314DfEBb5804Ed8B

    address public owner;
    uint256 public balance;  //balansı takip edebilebilmek için gerekir.

    constructor() {
        owner = msg.sender; 
    }

    receive() payable external {
        // balance += msg.value;
        balance =balance + msg.value; //ne kadar bakiye olduğunu bilebilmemiz için gerekiyor.
    }

    function withdraw(uint amount, address payable destAddr) public {
        require(msg.sender == owner, "Only owner can witthdraw"); // parayı sadece hesap sahibi gönderebilir.
        require(amount <= balance, "Insufficient funds"); // bakiye eşit veya az ise hata ver
        destAddr.transfer(amount); // tranfer etmek istediğimiz adresi gir.
        balance -= amount; //parayı gönderdikten sonra bakiyeden azalt.


    }
}   