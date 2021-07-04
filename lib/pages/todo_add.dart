import 'package:flutter/material.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/repositories/local/todo.dart';

// リスト追加画面用Widget
class TodoAddPage extends StatefulWidget {
  final int id;
  TodoAddPage({required this.id});

  @override
  _TodoAddPageState createState() => _TodoAddPageState(id: id);
}

class _TodoAddPageState extends State<TodoAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = '';
  final todoRepository = TodoRepository();
  final int id;
  _TodoAddPageState({required this.id});

  // データをもとに表示するWidget
  @override
  Widget build(BuildContext context) {
    debugPrint("in TodoAddPageState");
    return Scaffold(
        appBar: AppBar(
          title: Text('Todoを追加'),
        ),
        body: Container(
          padding: EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 入力されたテキストを表示
              Text(_text, style: TextStyle(color: Colors.cyan)),
              const SizedBox(height: 8),
              // テキスト入力フィールド
              TextField(
                // 入力されたテキストの値を受け取る
                onChanged: (String value) {
                  // データの変更を知らせる（画面更新）
                  setState(() {
                    // データを変更
                    _text = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // リスト追加ボタン
                child: ElevatedButton(
                  // color: Colors.cyan,
                  onPressed: () {
                    // popで前の画面に戻る
                    // popの引数から前の画面にデータを渡す
                    final newTodo = todoRepository.insert(TodoModel(
                      id: id,
                      content: _text,
                    ));
                    debugPrint("in onPressed before Navigator.of:" +
                        newTodo.toString());
                    Navigator.of(context).pop(newTodo);
                  },
                  child: Text('リストに追加', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                // キャンセルボタン
                child: TextButton(
                    onPressed: () {
                      // popで前の画面に戻る
                      Navigator.of(context).pop();
                    },
                    child: Text('キャンセル')),
              )
            ],
          ),
        ));
  }
}
