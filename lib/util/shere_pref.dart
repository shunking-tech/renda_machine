import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  // 名前を保存する
  Future<void> setName({String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
  }

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("name"));
    return prefs.getString("name");
  }
}