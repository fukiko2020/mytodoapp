import 'package:flutter/material.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/controllers/todo_controller.dart';

class TodoUpdatePage extends StatelessWidget {
  final int id;
  String content;
  bool? isDone;
  final TodoController todoController;
  TodoUpdatePage(
      {required this.id,
      required this.content,
      this.isDone,
      required this.todoController});

  Future _confirmDeleteDialog(BuildContext context, int id) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(content: Text('本当に削除しますか？'), actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('キャンセル')),
            TextButton(
              onPressed: () {
                todoController.delete(id);
                Navigator.pop(context);
              },
              child: Text('削除する'),
            )
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    print("in TodoUpdatePage");
    final isDoneText = isDone! ? "未完了にする" : "完了済みにする";
    return Scaffold(
        appBar: AppBar(
          title: Text('Todoを編集'),
        ),
        body: Container(
          padding: EdgeInsets.all(64),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(content, style: TextStyle(color: Colors.cyan)),
                const SizedBox(height: 8),
                TextField(
                  controller: TextEditingController(text: content),
                  onChanged: (String value) {
                    content = value;
                  },
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      todoController.update(TodoModel(
                        id: id,
                        content: content,
                        isDone: isDone,
                      ));
                      Navigator.of(context).pop();
                    },
                    child:
                        Text('Todoを更新', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      todoController.update(TodoModel(
                        id: id,
                        content: content,
                        isDone: isDone! ? false : true,
                      ));
                      Navigator.of(context).pop();
                    },
                    child:
                        Text(isDoneText, style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      await _confirmDeleteDialog(context, id);
                      Navigator.of(context).pop();
                    },
                    child: Text('Todoを削除'),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('キャンセル'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
