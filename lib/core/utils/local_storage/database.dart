import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../common/models/todo_model.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE todo ( 
      id $idType, 
      title $textType,
      details $textType,
      dueDate $textType,
      isCompleted $boolType
      )
    ''');
  }

  // CRUD Operations
  Future<void> insertTodo(Todo todo) async {
    final db = await instance.database;
    await db.insert('todo', todo.toMap());
  }

  Future<List<Todo>> fetchTodos() async {
    final db = await instance.database;
    final result = await db.query('todo');
    return result.map((map) => Todo.fromMap(map)).toList();
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await instance.database;
    await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodoById(int id) async {
    final db = await instance.database;
    await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
