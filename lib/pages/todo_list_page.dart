import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_list_item.dart';


class TodoListPage extends StatefulWidget {
  const TodoListPage({ Key? key }) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  
  final TextEditingController todoControler = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lista de Tarefas',
                    style: TextStyle(
                      fontSize: 25
                    )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: todoControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Adicione uma tarefa'
                            ),
                          )
                        ),
                        const SizedBox(
                          width: 10,  
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff00d7f3),
                            padding: const EdgeInsets.all(14)
                          ),
                          onPressed: (){     
                            setState(() { 
                              String text = todoControler.text;
                              Todo newTodo = Todo(
                                title: text,
                                datetime: DateTime.now(),
                              ); 
                              todos.add(newTodo);
                            });       
                            todoControler.clear();               
                          },
                          child: const Icon(
                            Icons.add,
                            size: 30
                          )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for(Todo todo in todos)
                          TodoListItem(
                            todo: todo,
                            onDeleted: onDeleted,
                          ),        
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Você tem ${todos.length} tarefas pendentes',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff00d7f3),
                          padding: const EdgeInsets.all(14)
                        ),
                        onPressed: dialogConfirmation,
                        child: Text('Limpar tudo')
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onDeleted(Todo todo){
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {      
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa ${todo.title} foi removida!',
          style: TextStyle(color: Color(0xff060708)),
          ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Theme.of(context).primaryColor,
          onPressed: (){
            setState(() {
            todos.insert(deletedTodoPos!, deletedTodo!);
            });
          },
        ),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),   
    );
  }

  void dialogConfirmation(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Limpar tudo?"),
        content: Text("Você tem certeza que deseja apagar todas as tarefas? "),
        actions: [
          TextButton(
            style: TextButton.styleFrom(primary: Color(0xff000000)),
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            child: Text("Cancelar")
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff00d7f3),
              padding: const EdgeInsets.all(14)
            ),
            onPressed: (){
              Navigator.of(context).pop();
              deletedAllTodos();
            }, 
            child: Text('Limpar tudo')
          )
        ],
      )
    );
  }

  void deletedAllTodos(){
    setState(() {
      todos.clear();
    });
  }

}
