import 'package:flutter/material.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/pages/todo_add.dart';
import 'package:mytodoapp/repositories/local/todo.dart';

class TodoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'My ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Todoリストのデータ
  final todoRepository = TodoRepository();
  List<TodoModel> todoList = [];
  // List<TodoModel> get data => todoList;

  @override
  Widget build(BuildContext context) {
    debugPrint("todoList:" + todoList.toString());
    todoRepository.retrieve().then((value) {
      for (var i in value) {
        todoList.add(i);
        debugPrint("retrieve result:" + i.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      // データをもとにListViewを作成
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index].content.toString()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // pushで新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newTodo = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面をリスト追加画面に指定

              return TodoAddPage(id: todoList.length + 1);
            }),
          );
          print("in onpressed");
          if (newTodo != null) {
            // キャンセルした場合はnewListTextがnullとなるので分岐
            setState(() {
              // debugPrint(newListText.toString());
              print('in setstate  at home.dart');
              todoList.add(newTodo);
            });
            print("todoList updated:" + todoList.toString());
          } else {
            print("no newListText");
          }
        },
        child: Icon(Icons.add),
      ),
    );
    // });
  }
}
