import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper with ChangeNotifier {
  static final tableName = 'todo';
  sql.Database? db;

  DBHelper() {
    // this will run when provider is instantiate the first time
    init();
  }

  void init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(
      path.join(dbPath, 'todo_master.db'),
      onCreate: (db, version) {
        final stmt = '''CREATE TABLE IF NOT EXISTS $tableName (
            id TEXT PRIMARY KEY,
            title TEXT,
            tasks TEXT,
            dateTime INTEGER,
            note TEXT,
            done INTEGER,
            star INTEGER
        )'''.trim().replaceAll(RegExp(r'[\s]{2,}'), ' ');
        return db.execute(stmt);
      },
      version: 1,
    );
    // the init function is async so it won't block the main thread
    // notify provider that depends on it when done
    notifyListeners();
  }

  Future<void> insert(String table, Map<String, Object> data) async {
    await db?.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<void> update(String table, Map<String, Object> data, id) async {
    await db?.update(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> delete(String table, id) async {
    await db?.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>?> getData(String table) async {
    return await db?.query(table);
  }
}