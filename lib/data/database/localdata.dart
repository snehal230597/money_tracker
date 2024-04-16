import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';


class DatabaseHelper {

  static final _databaseName = "moneyTracker.db";
  static final _databaseVersion = 1;

  static final table = 'moneyTracker';

  static final columnId = '_id';
  static final columnType = 'type';
  static final columnPrice = 'amount';
  static final columnDes = 'description';
  static final columndate = 'date';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnType TEXT, $columnPrice TEXT , '
        '$columndate TEXT,$columnDes TEXT)');
  }

  //Insert Data
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  //Display Data
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<dynamic> fetchProductData() async {
    Database? db = await instance.database;
    return await db!.rawQuery("SELECT * FROM $table ORDER BY $columnId DESC");
  }

  //Delete Data
  Future<int?> deleteData(int id) async {
    var db = await this.database;
    return await db?.rawDelete('DELETE FROM $table WHERE $columnId = $id');
  }

  //Update Data
  Future<dynamic> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db?.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<dynamic> deleteAll() async {
    Database? db = await instance.database;
    return await db?.rawDelete("DELETE FROM $table");
  }


}