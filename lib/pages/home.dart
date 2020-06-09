import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renda_machine/main.dart';
import 'package:renda_machine/pages/play.dart';
import 'package:renda_machine/util/shere_pref.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RouteAware {
  var time = 00.00;   // play.dartに渡す用の変数
  TextEditingController _ctrName = TextEditingController();    // 名前の入力フォームのコントローラー

  // どのメニューが選択されているか
  var selectedMenu10 = false;
  var selectedMenu60 = false;
  var selectedMenuEndless = false;

  // メニューを選択できるかどうか
  var canTapMenu10 = true;
  var canTapMenu60 = true;
  var canTapMenuEndless = true;

  // 選択中のメニュー
  var selectedMenuName = "";

  // 記録表示用の変数
  var record10 = "0";
  var record60 = "0";
  var recordEndless = "0";

  // 名前を入力した時のみPLAYできるように制御する変数
  var canPlay = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  // 上の画面がpopされて、この画面に戻ったときに呼ばれます
  void didPopNext() {
    print("aaa");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
// ユーザー名の入力欄を下から出すようにしたかったが、キーボードで隠れてしまう問題を解決できず保留
//    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 背景画像
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/planets.jpg"),
                  fit: BoxFit.cover,
                )
            )
          ),

          // 表示内容
          SingleChildScrollView(
//              reverse: true,
              child: Container(
// ユーザー名の入力欄を下から出すようにしたかったが、キーボードで隠れてしまう問題を解決できず保留
//            margin: EdgeInsets.only(bottom: bottomSpace),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // 画面上部の記録表示
                        FutureBuilder(
                          future: _blockShowRecord(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: LinearProgressIndicator(),
                              );
                            }

                            return snapshot.data;
                          },
                        ),

                        // タイトル
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Renda\nMachine",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),

                        // ユーザー名
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          color: Colors.white,
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextFormField(
                                    controller: _ctrName,
                                  )
                              ),
                              FlatButton(
                                onPressed: () async {
                                  await SharePrefs().setName(name: _ctrName.text);
                                  var _name = await SharePrefs().getName();

                                  setState(() {
                                    if (_name.length == 0) {
                                      canPlay = false;
                                    } else {
                                      canPlay = true;
                                    }
                                  });
                                },
                                child: Text("ok"),
                              )
                            ],
                          ),
                        ),

// ユーザー名の入力欄を下から出すようにしたかったが、キーボードで隠れてしまう問題を解決できず保留
//              Container(
//                padding: EdgeInsets.only(left: 100,right: 100),
//                child: TextField(
//                  decoration: InputDecoration(
//                    enabledBorder: new OutlineInputBorder(
//                      borderSide: BorderSide(
//                        color: Colors.grey,
//                      ),
//                    ),
//                    focusedBorder: OutlineInputBorder(
//                      borderSide: BorderSide(
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//                    ListTile(
//                      onTap: () {
//                        _showModalPicker(context);
//                      },
//                    ),

                        _blockPlay(),

                        // 画面下部
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            children: <Widget>[
                              // 作成者情報
                              Expanded(
                                child: Text(
                                  "FONT:\n"
                                  "Isurus Labs\n\n"
                                  "ICON:\n"
                                  "Yukichi\n\n"
                                  "SPECIAK THANKS:\n"
                                  "Yukichi, @real_onesc\n\n"
                                  "(c) 2018 sinProject inc.",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              // ランキング
                              Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 200,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Leaderboard",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "1.",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              )
          ),
        ],
      )

    );
  }

  // 画面上部の記録の１つ
  Widget recordText({var time, var record}) {
    return Expanded(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Text(
            time,
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 20
            ),
          ),
          Text(
            record,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ),
        ],
      ),
    );
  }

  // 画面中部のメニューの１つ
  Widget menuItem({var menu, var selected, var canTap}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        foregroundDecoration: BoxDecoration(
          color: selected ? Colors.red.withOpacity(0.1) : null
        ),
        child: ListTile(
          enabled: canTap,
          title: Text(
            menu,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
          ),
          onTap: () {
            setState(() {
              selectedMenuName = menu;
              if (menu == "10s") {
                time = 10.00;
                selectedMenu10 = true;
                selectedMenu60 = false;
                selectedMenuEndless = false;
                canTapMenu10 = false;
                canTapMenu60 = true;
                canTapMenuEndless = true;
              } else if (menu == "60s") {
                time = 60.00;
                selectedMenu10 = false;
                selectedMenu60 = true;
                selectedMenuEndless = false;
                canTapMenu10 = true;
                canTapMenu60 = false;
                canTapMenuEndless = true;
              } else if (menu == "ENDRESS") {
                time = -1.00;
                selectedMenu10 = false;
                selectedMenu60 = false;
                selectedMenuEndless = true;
                canTapMenu10 = true;
                canTapMenu60 = true;
                canTapMenuEndless = false;
              }
            });
          },
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
  }

  // 名前入力欄を下から出したかったが、キーボードで隠れてしまうため断念
  void _showModalPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField()
              ),
              FlatButton(
                child: Text("ok"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<Widget> _blockShowRecord() async {
    // メニュー毎の記録を取得
    var r10 = await SharePrefs().getRecord(menu: "10s");
    var r60 = await SharePrefs().getRecord(menu: "60s");
    var rEndress = await SharePrefs().getRecord(menu: "ENDRESS");

    // 記録を数値から文字列に変換して代入　nullなら”0”を代入
    record10 = r10.toString();
    if (r10 == null) {
      record10 = "0";
    }
    record60 = r60.toString() ?? "0";
    if (r60 == null) {
      record60 = "0";
    }
    recordEndless = rEndress.toString() ?? "0";
    if (rEndress == null) {
      recordEndless = "0";
    }

    // 記録を表示するウィジェットを返す
    return Container(
      child: Row(
        children: <Widget>[
          recordText(time: "10s", record: record10),
          recordText(time: "60s", record: record60),
          recordText(time: "ENDRESS", record: recordEndless),
        ],
      ),
    );
  }

  Widget _blockPlay() {
    if (canPlay) {    // 名前入力されているときはメニューとPLAYボタンを表示する
      return Column(
        children: <Widget>[
          // メニュー
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 10, left: 30, right: 30),
            child: Row(
              children: <Widget>[
                menuItem(menu: "10s", selected: selectedMenu10, canTap: canTapMenu10),
                menuItem(menu: "60s", selected: selectedMenu60, canTap: canTapMenu60),
                menuItem(menu: "ENDRESS", selected: selectedMenuEndless, canTap: canTapMenuEndless),
              ],
            ),
          ),

          // PLAYボタン
          Container(
              padding: EdgeInsets.only(bottom: 10, left: 30, right: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: RaisedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => Play(time: time, menu: selectedMenuName,),
                              ),
                            );
                          },
                          color: Colors.white.withOpacity(0.0),
                          child: Text(
                            "PLAY!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50
                            ),
                          ),
                        ),
                      )
                  )
                ],
              )
          ),
        ],
      );
    } else {    // 名前入力されていない時は何も表示しない
      return Container(
        height: 150,
      );
    }
  }
}