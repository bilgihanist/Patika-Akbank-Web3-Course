// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract TodoList {
    struct Todo { //yapı içinde 2 alan saklanacak  
        string text;  //1.text yapılacakların açıklaması
        bool completed; //2. yapılanlar tamamlandımı

    }
    Todo[] public todos;

    //Yapılandırma dizisini saklayacağız 

    /* string: girdi için bir metin sağlar.
    memory/calldata kullanılır, fakat memory daha fazla gas tüketir. 
    _text: isim vermek için kullanılır.

    */
    function create(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    } 
        

/* */
    function updateText(uint _index, string calldata _text) external {
      todos[_index].text = _text;   //yapılacaklar dizisine erişin, metnin girdiden metinin altını çizmeye eşit olduğunu söylemek güncelle
      
      /*2. güncelleme seçeneği: Bir değişken oluştur, böylece depolama yapmak 
      Todo[_index].text = _text;
      todo.text = _text;
      */
    }

    function get(uint _index) external view returns (string memory, bool){
        //yapılacakları güncellemeyeceğiz oyüzden  memory kullancağız.
        //yazacağımız metne ve tamamlanan duruma veriye geri döneceğiz.
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }


}


/*
function updateText(uint _index, string calldata _text) external {
//diziye her eriştiğimizde ve ardından yapıyı aldığımızda ve metni güncellediğimizde diziye 4 kez eriştiğimizi gereksiz gaz yakımı olacaktır.
    todos[_index].text =_text;
    todos[_index].text =_text;
    todos[_index].text =_text;
    todos[_index].text =_text;

  //Diziye bir kere erişilir güncelleme yapılır ve kayıt edilir
    Todo storage todo = todo = todos[_index];
    todo.text = _text;
    todo.text = _text;
    todo.text = _text;
    todo.text = _text;
*/