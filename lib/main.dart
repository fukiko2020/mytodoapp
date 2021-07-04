import 'package:flutter/material.dart';
import 'package:mytodoapp/pages/home.dart';
import 'package:mytodoapp/pages/todo_add.dart';
import 'package:mytodoapp/pages/todo_update.dart';
import 'package:mytodoapp/repositories/local/local_db.dart';
import 'package:mytodoapp/routes/home/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();
  debugPrint("DB initialized");

  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  final int id = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeRoutes.home: (context) => TodoHomePage(),
        HomeRoutes.add: (context) => TodoAddPage(id: id),
        HomeRoutes.update: (context) => TodoUpdatePage(id: id, content: ''),
      },
    );
  }
}
