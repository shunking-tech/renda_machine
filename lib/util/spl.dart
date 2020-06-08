import 'package:renda_machine/util/provider.dart';

class SQL {
  Future<void> saveName({String name}) async {
    final db = await DBProvider.db.database;
    var res;

      res = await db.rawInsert(
          "INSERT into users "
              "(title, pass_id, pass) "
              "VALUES "
              "('$name')"
      );

//    if(widget.id == null){
//      res = await db.rawInsert(
//          "INSERT into users "
//              "(title, pass_id, pass) "
//              "VALUES "
//              "('$name')"
//      );
//    } else {
//      Map<String, dynamic> users = Map();
//      users["name"] = name;
//
//      res = await db.update(
//          "passwords",
//          users,
//          where: "id = ?",
//          whereArgs: [widget.id]
//      );
//    }
    return res;

  }

  Future<List<Map<String, dynamic>>> searchUser({String name}) async {
    final db = await DBProvider.db.database;
    var res = await db.query(
      "users",
      where: "name = ?",
      whereArgs: [name]
    );
    return res;
  }
}