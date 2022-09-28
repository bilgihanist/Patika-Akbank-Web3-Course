// SPDX-License-I.dentifier: MIT
pragma solidity ^0.8.7;



contract GlobalVariables {
    function globalVars() external view returns (address, uint, uint){
        address sender = msg.sender;  // gönderici
        uint timestamp = block.timestamp;
        uint blockNum = block.number;
        return (sender, timestamp, blockNum);
    }
}

/*
    blok zinciri işlemi ve işlevi çağıran hesap gibi bilgileri depolar
    en sık kullanılan global değişkenler şunlardır.
    "view" akran fonksiyonlarından farklı olarak salt okunur bir fonksiyondur.
    "view" fonksiyonları durum değişkenlerinden ve global değişkenlerden veri okuyabilir.

*/

