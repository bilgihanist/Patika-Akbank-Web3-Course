// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract FunctionModifier{

    address public owner;
    uint public x= 10;
    bool public locked;

    constructor() {
// Set the transaction sender as the owner of the contract.
//  işlem göndercisini sözlşmenin sahibi olarak ayarlayın

    owner = msg.sender;
    }
// Modifier to check that the caller is the owner of the contract.
// Arayanın sözleşmenin sahibi olup olmadığını kontrol etmek için değiştirici.

    modifier  onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
//en- Underscore is a special character only used inside a function modifier and it tells Solidity to execute the rest of the code.
//tr- Alt çizgi, yalnızca bir işlev değiştirici içinde kullanılan özel bir karakterdir ve Solidity'ye kodun geri kalanını yürütmesini söyler.
    }

// Modifiers can take inputs. This modifier checks that the address passed in is not the zero address.
// Değiştiriciler girdi alabilir. Bu değiştirici, iletilen adresin sıfır adres olmadığını kontrol eder.
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner (address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

// Modifiers can be called before and / or after a function. This modifier prevents a function from being called while it is still executing.
// Değiştiriciler bir fonksiyondan önce ve/veya sonra çağrılabilir. Bu değiştirici, bir işlevin hala yürütülürken çağrılmasını engeller.

    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReentrancy {
        x -= i;
        if(i > 1) {
            decrement(i - 1);
        }
    }

}