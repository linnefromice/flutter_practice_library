import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// https://medium.com/@suragch/simple-sqflite-database-example-in-flutter-e56a5aaa3f91
class DatabaseHelper {
  static final _dbName = 'my.db';
  static final _dbVersion = 1;

  static final table = 'EXAMPLE_TABLE';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAge = 'age';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> getDatabase() async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _dbName);
    return await openDatabase(path,
      version: _dbVersion,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.getDatabase();
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.getDatabase();
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.getDatabase();
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.getDatabase();
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}