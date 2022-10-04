// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SentEther {
    constructor() payable {}

    receive() external payable {}
    
//eth göndermenin 3 yolu vardır.

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {// kullanılmaz
        bool sent = _to.send(123);
        require(sent,"send failed");
    }

    function sendViaCall(address payable _to) external payable {
       // (bool success, bytes memory data ) = _to.call{value:123}("");  // byte olarak memoryde saklamak için kullanılır
        (bool success, ) = _to.call{value:123}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}