import 'package:renda_machine/util/provider.dart';

class SQL {
  Future<void> saveName({String name}) async {
    final db = await DBProvider.db.database;
    var res;

    // 新規のユーザーかどうか判断
    var isNew = await isNewUser(name: name);
    print(isNew);

    if (isNew) {  // 新規のユーザーならDBに追加する
      res = await db.rawInsert(
          "INSERT into users "
              "(name) "
              "VALUES "
              "('$name')"
      );

      // usersテーブルの中身を確認
      var users = await getUser();
      print(users);

      return res;
    }

    // usersテーブルの中身を確認
    var users = await getUser();
    print(users);
  }

  // ユーザー全件取得
  Future<List<Map<String, dynamic>>> getUser() async {
    final db = await DBProvider.db.database;
    var res = await db.query("users");
    return res;
  }

  // 新規のユーザーかどうか判断
  Future<bool> isNewUser({String name}) async {
    final db = await DBProvider.db.database;
    var res = await db.query(
      "users",
      where: "name = ?",
      whereArgs: [name]
    );

    if (res.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  // ユーザーidを取得する
  Future getUserId({String name}) async {
    final db = await DBProvider.db.database;
    var res = await db.query(
        "users",
        where: "name = ?",
        whereArgs: [name]
    );

    return res[0]["id"];
  }
}