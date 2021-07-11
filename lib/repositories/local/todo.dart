import 'package:sqflite/sqflite.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/repositories/local/local_db.dart';

class TodoRepository {
  final db = LocalDB().instance;

  Future<void> insert(TodoModel todo) async {
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TodoModel>> retrieve() async {
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return TodoModel(
        id: maps[i]['id'],
        content: maps[i]['content'],
        isDone: maps[i]['isDone'] == 1 ? true : false,
      );
    });
  }

  Future<void> update(TodoModel todo) async {
    await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> delete(int id) async {
    await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future find(int id) async {
    List<Map> result = await db.query(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.length > 0) {
      return TodoModel(
        id: result.first["id"],
        content: result.first["content"],
        isDone: result.first["isDone"] == 1 ? true : false,
      );
    }
  }
}
