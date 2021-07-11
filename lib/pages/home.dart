import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/pages/todo_add.dart';
import 'package:mytodoapp/pages/todo_update.dart';
import 'package:mytodoapp/controllers/todo_controller.dart';

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
      home: DefaultTabController(
        length: 3,
        child: TodoListPage(),
      ),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = context.watch<TodoController>();
    List<TodoModel> todoList = todoController.todoList;
    int lastId = todoList.isNotEmpty ? todoList.last.id : 0;

    List<TodoModel> isDoneList = [];
    List<TodoModel> notDoneList = [];

    for (var todo in todoList) {
      todo.isDone == true ? isDoneList.add(todo) : notDoneList.add(todo);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
        bottom: TabBar(
          tabs: [
            Tab(text: "すべて"),
            Tab(text: "未完了"),
            Tab(text: "完了済み"),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          TodoListView(todoList: todoList, todoController: todoController),
          NotDoneListView(todoList: notDoneList,todoController: todoController),
          IsDoneListView(todoList: isDoneList, todoController: todoController),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // pushで新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面をリスト追加画面に指定

              return TodoAddPage(
                  id: lastId + 1, todoController: todoController);
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
    // });
  }
}

class TodoListView extends StatelessWidget {
  final List<TodoModel> todoList;
  final TodoController todoController;

  TodoListView({required this.todoList, required this.todoController});

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return TodoUpdatePage(
                  id: todoList[index].id,
                  content: todoList[index].content,
                  isDone: todoList[index].isDone,
                  todoController: todoController,
                );
              }),
            );
          },
          child: Card(
            child: Row(children: <Widget>[
              Checkbox(
                  value: todoList[index].isDone,
                  onChanged: (bool? value) {
                    todoController.setIsDone(todoList[index].id, value);
                    todoList[index].isDone = value;
                  }),
              Expanded(
                child: ListTile(
                  title: Text(todoList[index].content.toString()),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class NotDoneListView extends TodoListView {
  final List<TodoModel> todoList;
  final TodoController todoController;

  NotDoneListView({required this.todoList, required this.todoController})
      : super(todoList: todoList, todoController: todoController);
}

class IsDoneListView extends TodoListView {
  final List<TodoModel> todoList;
  final TodoController todoController;

  IsDoneListView({required this.todoList, required this.todoController})
      : super(todoList: todoList, todoController: todoController);
}
