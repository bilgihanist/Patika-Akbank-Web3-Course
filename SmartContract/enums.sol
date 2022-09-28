// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Enum {
    // gönderim durumunu temsil eden enum
    enum Status {
        None,       //0
        Pending,    //1
        Shipped,    //2
        Completed,  //3
        Rejected,   //4
        Canceled    //5
    }

    // Varsayılan değer listelenen ilk değerdir.
    // türün tanımı, bu durumda "pending" de kalır.
    Status public status;


    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;


    function get() view external returns (Status) {
        return status;
    }
    //Girişe uint ileterek durumu güncelleyin
    function set(Status _status) external {
        status = _status;
    }

    //belirli bir numaraya güncelleme
    function cancel() public {
        status = Status.Canceled;
    }

    function ship() external {
        status = Status.Shipped;
    }
    // delete numaralandırmayı sıfırlar, 0 
    function reset() external {
        delete status;
    }
}

