import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    print("initDB");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "renda_machine.db");
    const scripts = {
//      '2' : ["ALTER TABLE users ADD COLUMN tenSec INTEGER;"],
//      '3' : ["ALTER TABLE users ADD COLUMN sixtySec INTEGER;"],
//      '4' : ["ALTER TABLE users ADD COLUMN endless INTEGER;"],
    };

    return await openDatabase(
        path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE users("
                  "id INTEGER PRIMARY KEY,"
                  "name TEXT,"
                  "tenSec INTEGER,"
                  "sixtySec INTEGER,"
                  "endless INTEGER"
              ");"
          );
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          for (var i = oldVersion + 1; i <= newVersion; i++) {
            var queries = scripts[i.toString()];
            for (String query in queries) {
              await db.execute(query);
            }
          }
        }
    );
  }
}