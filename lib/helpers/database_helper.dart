import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/number.dart';

class DatabaseHelper {
  static final _databaseName = "numbers.db";
  static final _databaseVersion = 1;

  static final table = 'numbers';
  static final columnId = 'id';
  static final columnNumber = 'number';
  static final columnDateTime = 'dateTime';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static late Database _database;
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<List<Number>> readAllNumbers() async {
    final db = await instance.database;
    final result = await db.query(table, orderBy: '$columnDateTime DESC');
    return result.map((json) => Number.fromJson(json)).toList();
  }

  Future<void> deleteNumber(int? id) async {
    if (kDebugMode) {
      print(id);
    }
    final db = await instance.database;
    await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    await db.delete(table);
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY autoincrement,
            $columnNumber TEXT NOT NULL,
            $columnDateTime TEXT NOT NULL
          )
          ''');
        });
  }
}