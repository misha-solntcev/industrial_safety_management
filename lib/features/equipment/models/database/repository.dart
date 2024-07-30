import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../task.dart';

// /run/media/EXTERNAL_USB/Файлы/Flutter/Dev/industrial_safety_management/.dart_tool/sqflite_common_ffi/databases/tasks.db

class Repository {
  static const String databaseName = 'tasks.db';
  static const String tableName = 'tasks';

  static Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  static Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  static Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(tableName, task.toMap());
  }

  static Future<void> updateTask(Task task) async {
    final db = await database;
    await db
        .update(tableName, task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<void> deleteTask(Task task) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
  }
}
