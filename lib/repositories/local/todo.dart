import 'package:sqflite/sqflite.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/repositories/local/local_db.dart';

class TodoRepository {
  final db = LocalDB().instance;

  insert(TodoModel todo) async {
    print("in insert");
    try {
      final newTodoId = await db.insert(
        'todo',
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("newTodoId:" + newTodoId.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<List<TodoModel>> retrieve() async {
    final List<Map<String, dynamic>> maps = await db.query('todo');
    print("in retrieve");
    print(maps);
    return List.generate(maps.length, (i) {
      return TodoModel(
        id: maps[i]['id'],
        content: maps[i]['content'],
        isDone: maps[i]['isDone'] == 1 ? true : false,
      );
    });
  }

  Future<void> update(TodoModel todo) async {
    print("in update");
    await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    print("finished update");
  }

  Future<void> delete(int id) async {
    print("in delete");
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
    print('query result:' + result.toString());
    if (result.length > 0) {
      print("found:" + result.first.toString());
      return TodoModel(
        id: result.first["id"],
        content: result.first["content"],
        isDone: result.first["isDone"] == 1 ? true : false,
      );
    }
  }
}
