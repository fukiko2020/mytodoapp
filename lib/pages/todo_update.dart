import 'package:flutter/material.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/repositories/local/todo.dart';

class TodoUpdatePage extends StatefulWidget {
  final int id;
  final String content;
  TodoUpdatePage({required this.id, required this.content});

  @override
  _TodoUpdatePageState createState() =>
      _TodoUpdatePageState(id: id, content: content);
}

class _TodoUpdatePageState extends State<TodoUpdatePage> {
  String _text = '';
  final todoRepository = TodoRepository();
  final int id;
  String content;
  _TodoUpdatePageState({required this.id, required this.content});

  Future _confirmDeleteDialog(BuildContext context, int id) async {
    // final int id;
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
                todoRepository.delete(id);
                Navigator.pop(context);
              },
              child: Text('削除する'),
            )
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("in TodoUpdatePageState");
    // final initialText = todoRepository.find(id);
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
                  setState(() {
                    content = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final updatedTodo = todoRepository.update(TodoModel(
                      id: id,
                      content: content,
                    ));
                    Navigator.of(context).pop(updatedTodo);
                  },
                  child: Text('Todoを更新', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    await _confirmDeleteDialog(context, id);
                    Navigator.of(context).pop(id);
                    print(todoRepository.retrieve());
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
      )
    );
  }
}
