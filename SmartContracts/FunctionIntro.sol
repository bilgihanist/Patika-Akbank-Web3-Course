// SPDX-License-Identifier: MIT
pragma solidity '0.8.7';


/* -------------------Toplama Çıkarma------------------- */
// contract FunctionIntro {
//     function add(uint x, uint y) external pure returns (uint) {
//         return x+y;
//     }

//     function sub(uint x, uint y) external pure returns (uint) {
//         return x-y;
//     }
// }

/*----------------------------------------------*/

contract Function {
    //Fonksiyonlar birden fazla değer alabilirler.
    function returnWay()
        public 
        pure 
        returns (
            uint,
            bool,
            uint
        )

        {
            return (1, true, 2);
        }

        //dönüş değerleri adlandırılabilir.
    function named()
        public
        pure
        returns (
            uint x,
            bool b,
            uint y
        )
    {
        return (1, true, 2);
    }

        // Dönüş değerleri isimlerine atanabilir.
        // bu durumda return ifadesi atlanabilir.

    function assigned()
        public
        pure
        returns (
            uint x,
            bool b,
            uint y
        )
    {
        x = 1;
        b = true;
        y = 2;
    }

        // Use destructuring assignment when calling another
        //başka birini çağırırken yıkım atamasını kullan

        // function that returns multiple values.
        // birden çok değer döndüren function

         function destructuringAssignments()
        public
        pure
        returns (
            uint,
            bool,
            uint,
            uint,
            uint
        )
    {
        (uint i, bool b, uint j) = returnMany();

       
        // Values can be left out.
        // değerler dışarıda bırakılabilir.

        (uint x, , uint y) = (4, 5, 6);

        return (i, b, j, x, y);
         }

        // Cannot use map for either input or output
        // Girdi ve çıktı için map kullanılamaz

        // Can use array for input
        // Girdi için dizi kullanılabilir.
        function arrayInput(uint[] memory _arr) public {}

        // Can use array for output
        // Çıktı için dizi kullanılabilir.
        uint[] public arr;

        function arrayOutput() public view returns (uint[] memory) {
            return arr;
        }
    }
        //Call function with key-value inputs
        //key-value girişli çağrı functionu

        contract XYZ {
            function someFuncWithManyInputs(
                uint x,
                uint y,
                uint z,
                address a,
                bool b,
                string memory c
            ) public pure returns (uint) {}

            function callFunc() external pure returns (uint) {
                return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
            }

            function callFuncWithKeyValue() external pure returns (uint) {
                return
                    someFuncWithManyInputs({a: address(0), b: true, c: "c", x: 1, y: 2, z: 3});
            }
        }
