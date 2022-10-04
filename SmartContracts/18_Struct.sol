// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        // 3 farklı yazım şekli vardır.
        Car memory toyota = Car("Toyota", 1990, msg.sender);
        Car memory lambo = Car({year: 1990, model:"Lamborghini", owner: msg.sender});
        Car memory tesla;
        tesla.model= "Tesla";
        tesla.year= 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari", 2020, msg.sender));

        //önce durum dğişkenininden almak ve sonra herhangi bir değişiklik yapmadan
        //okumak istiyorsak ozaman memory yazmalıyız. verileri hafızaya yükle
        //GET
        //Car memory _car = cars[0]; //tüm değerleri getirdi. (GET)
        
        //UPDATE
        Car storage _car = cars[0]; //ilk satırdaki 0. verinin yılını güncelle 
        _car.year = 1999; // ilk verinin yılı güncellenir.
        delete _car.owner;
        //memory işlem olmazsa sıfırlanır  storage kayıt edilir.

        //DELETE
        delete _car.owner; // bu sadece o verinin girdisini sıfırlar.

        //bütün dbyi varsayılan hale getirmek için ise
        delete cars[1]; 
        //[1] olmasının sebebi cars dizisindeki depolanan yapıyı siler
        // herşey varsayılan değerine sıfırlanacak.  



    
    }
}