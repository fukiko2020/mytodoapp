// import 'package:path/path.dart' as p;
// import 'package:sqflite/sqflite.dart';

class TodoModel {
  final int id;
  final String content;

  TodoModel({
    required this.id,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Todo {id: $id, content: $content}';
  }
}
