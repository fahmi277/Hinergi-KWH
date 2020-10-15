import 'package:hinergi_kwh/database/queries/dailyQuery.dart';

import "package:hinergi_kwh/database/queries/dailyQuery.dart";

import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import 'package:sqflite/sqflite.dart';

class DbHelper {
  //membuat method singlethon

  static DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  // baris terakhir singleton;

  final tables = [
    DailyQuery.CREATE_TABLE,
  ]; //membuat daftar table yang akan dibuat

  Future<Database> openDB() async {
    final dbPath = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(path.join(dbPath, 'daily.db'),
        onCreate: (db, version) {
      tables.forEach((table) async {
        await db.execute(table).then((value) {
          print("berhasil dibuat");
        }).catchError((error) {
          print("errornya ${error.toString()}");
        });
      });

      print("Table Created");
    }, version: 1);
  }

  insert(String table, Map<String, Object> data) {
    openDB().then((db) {
      db.insert(table, data,
          conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
    }).catchError((err) {
      print("error $err");
    });
  }

  Future<List> getData(String tableName) async {
    final db = await openDB();
    var result = await db.query(tableName);
    return result.toList();
  }
}
