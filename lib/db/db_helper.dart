import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
class DBHelper {
  //Singleton
  DBHelper._();
  static final DBHelper instance
  = DBHelper._();

 // static const _dbName = "xyz.db";
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'ahmed';
  var list = <Task>[];
  _initiateDatabase() async {
    if(_db != null){
      debugPrint('not null db');
      return;
    }else{
      try{
       String _path = await getDatabasesPath()+'mytaskK.db';
       debugPrint('in database path');
        return await openDatabase(_path, version: _version,onCreate: _onCreate);
      }catch(e){
        print(e);
      }
    }
    // String _path = await getDatabasesPath() + 'xyzf.db';
    // debugPrint('IN DATABASE PATH');
    // Directory directory = await getApplicationDocumentsDirectory();
    // String path = join(directory.path, _dbName);
  }
  Future _onCreate(Database db, int version)async {
    debugPrint('create new database');
    const dd='CREATE TABLE $_tableName(''id INTEGER PRIMARY KEY AUTOINCREMENT'')';

    const sql = '''CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
             date STRING,title STRING,note TEXT,
              startTime STRING,endTime STRING,
              remind INTEGER,repeat STRING,
              color INTEGER,isCompleted INTEGER)''';
    await db.execute(sql);
  }

  Future insert(Task? task)async{
    print("inserted");
    try{
      Database db = await instance._initiateDatabase();
      return await db.insert(_tableName, task!.toJson());
    }catch(e){
      print('we are here'+e.toString());
      return 90000;
    }
  }
  static Future<int> delete (Task? task)async{
    print("deleted");
    Database db = await instance._initiateDatabase();
    return await db.delete(_tableName,where:'id = ?',whereArgs: [task!.id]);
  }
  static Future<int> update (int id)async{
    print("update");
    Database db = await instance._initiateDatabase();
    return await db.rawUpdate('''
    UPDATE tasks SET isCompleted = ? WHERE id = ?
    ''',[1,id]);
  }
  static Future<List<Map<String, Object?>>> query() async{
    print("query");
    Database db = await instance._initiateDatabase();
    print(db.query(_tableName));
    return await db.query(_tableName);


  }
  Future getNoteList() async {
    Database db = await instance._initiateDatabase();
    final List<Map> maps = await db.query(_tableName);
    maps.forEach((element) {
    print(element);
    });
  }



}

// static Future<void> initDb()async {
// String _path = await getDatabasesPath() + 'task.db';
// debugPrint('IN DATABASE PATH');
// _db = await openDatabase(_path, version: _version,
// onCreate: (Database db, int version) async {
// const sql = '''CREATE TABLE $_tableName(
//           id INTEGER PRIMARY KEY AUTOINCREMENT,'
//               'title STRING,note TEXT,date STRING,'
//               'startTime STRING,endTime STRING,
//               remind INTEGER,repeat STRING'
//               'color INTEGER,isCompleted INTEGER)''';
// await db.execute(sql).then((value) => {
// print("Database Created")
// }).catchError((onError){
// print(onError.toString());
// });
// });
//
//
// }
//
// static Future<int> insert(Task? task)async{
// print("inserted");
// try{
// return await _db!.insert(_tableName, task!.toJson());
// }catch(e){
// print("we are here");
// return 90000;
// }
// }
// static Future<int> delete (Task? task)async{
// print("deleted");
// return await _db!.delete(_tableName,where:'id = ?',whereArgs: [task!.id]);
// }
// static Future<int> update (int id)async{
// print("update");
// return await _db!.rawUpdate('''
//     UPDATE tasks SET isCompleted = ? WHERE id = ?
//     ''',[1,id]);
// }
// static Future<List<Map<String, Object?>>> query() async{
// print("query");
// return await _db!.query(_tableName);
// }
//
//
//
//
// }
