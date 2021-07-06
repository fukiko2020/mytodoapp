import 'package:flutter/material.dart';
import 'package:mytodoapp/models/todo.dart';
import 'package:mytodoapp/repositories/local/todo.dart';

class TodoController extends ChangeNotifier {
  List<TodoModel> _todoList = [];
  List<TodoModel> get todoList => _todoList;
  bool _isDone = false;
  bool get isDone => _isDone;

  TodoController();

  Future<void> retrieve() async {
    print("controller: in retrieve");
    _todoList = await TodoRepository().retrieve();
    print(_todoList);
    notifyListeners();
  }

  Future<void> insert(TodoModel todo) async {
    print("controller: in insert");
    await TodoRepository().insert(todo);
    _todoList = await TodoRepository().retrieve();
    print(_todoList);
    notifyListeners();
  }

  Future<void> update(TodoModel todo) async {
    print("controller: in update");
    await TodoRepository().update(todo);
    _todoList = await TodoRepository().retrieve();
    notifyListeners();
  }

  Future<void> delete(int id) async {
    print("controller: in delete");
    await TodoRepository().delete(id);
    _todoList = await TodoRepository().retrieve();
    notifyListeners();
  }

  Future<void> setIsDone(int id, bool? value) async {
    final todo = await TodoRepository().find(id);
    await TodoRepository()
        .update(TodoModel(id: id, content: todo.content, isDone: value));
    _todoList = await TodoRepository().retrieve();
    print("in isdone setter");
    notifyListeners();
  }
}
