import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static LocalDB? _localDB;
  static Database? _db;
  Database get instance => _db!;

  factory LocalDB() => _localDB ??= LocalDB._();

  LocalDB._();

  static Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    print("DB path:" + databasesPath);
    final path = p.join(databasesPath, 'local.db');
    print("in init()");
    _db = await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(
        _LocalDBTables.todo,
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion == 1) {
        await db.execute(_LocalDBTables.todoMigration);
      }
    });
  }
}

class _LocalDBTables {
  static const todoMigration = '''
    ALTER TABLE todo ADD isDone INTAGER
  ''';

  static const todo = '''
    CREATE TABLE todo (
      id INTEGER PRIMARY KEY,
      content TEXT,
      isDone INTEGER,
    )
  ''';
}
