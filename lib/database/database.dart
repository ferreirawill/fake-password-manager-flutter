import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "StorageDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Passwords ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title TEXT,"
              "user TEXT,"
              "password TEXT"
              ")");
        });
  }

  newPassword(Map<String, dynamic> values) async{
    final db = await database;
    var res = await db.insert("Passwords", values);
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllPasswords() async{
    final db = await database;
    var res = await db.query("Passwords");
    List<Map<String,dynamic>> StorageData = res.isNotEmpty ? res : [];
    return StorageData;
  }

  deletePassword(int id) async {
    final db = await database;
    db.delete("Passwords", where: "id = ?", whereArgs: [id]);
  }

  updateData(Map<String, dynamic> data) async{
    final db = await database;
    var res = await db.update("Passwords",
        { "user": data["user"],
          "password": data["password"],},
        where: "title = ?", whereArgs: [data["title"]]);
    return res;
  }
}