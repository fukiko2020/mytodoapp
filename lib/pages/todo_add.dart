import 'package:flutter/material.dart';
import 'package:mytodoapp/models/todo.dart';
// import 'package:mytodoapp/repositories/local/todo.dart';
import 'package:mytodoapp/controllers/todo_controller.dart';

// リスト追加画面用Widget
class TodoAddPage extends StatelessWidget {
  final int id;
  final TodoController todoController;
  TodoAddPage({required this.id, required this.todoController});


  // データをもとに表示するWidget
  @override
  Widget build(BuildContext context) {
    String _text = '';
    return Scaffold(
        appBar: AppBar(
          title: Text('Todoを追加'),
        ),
        body: Container(
          padding: EdgeInsets.all(64),
          child: SingleChildScrollView(
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
                    // setState(() {
                      // データを変更
                      _text = value;
                    // });
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
                      todoController.insert(TodoModel(
                        id: id,
                        content: _text,
                        isDone: false,
                      ));
                      Navigator.of(context).pop();
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
          )
        ));
  }
}
