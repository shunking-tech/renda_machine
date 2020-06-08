import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renda_machine/pages/play.dart';
import 'package:renda_machine/util/shere_pref.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var time = 00.00;   // play.dartに渡す用の変数
  TextEditingController _ctrName = TextEditingController();    // 名前の入力フォームのコントローラー
  var selectedMenu10 = true;
  var selectedMenu60 = true;
  var selectedMenuEndless = true;
  var canTapMenu10 = true;
  var canTapMenu60 = true;
  var canTapMenuEndless = true;

  @override
  Widget build(BuildContext context) {
// ユーザー名の入力欄を下から出すようにしたかったが、キーボードで隠れてしまう問題を解決できず保留
//    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: SingleChildScrollView(
          reverse: true,
          child: Container(
// ユーザー名の入力欄を下から出すようにしたかったが、キーボードで隠れてしまう問題を解決できず保留
//            margin: EdgeInsets.only(bottom: bottomSpace),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // 画面上部の記録表示
                    Container(
                      child: Row(
                        children: <Widget>[
                          recordText(time: "10s", record: "0"),
                          recordText(time: "60s", record: "0"),
                          recordText(time: "ENDRESS", record: "0"),
                        ],
                      ),
                    ),

                    // タイトル
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Renda\nMachine",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40
                            ),
                          ),
                        )
                      ],
                    ),

                    // ユーザー名
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
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
                              await SharePrefs().getName();
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
                                          builder: (context) => Play(time: time,),
                                        ),
                                      );
                                    },
                                    color: Colors.white,
                                    child: Text(
                                        "PLAY!"
                                    ),
                                  ),
                                )
                            )
                          ],
                        )
                    ),

                    // 画面下部
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(top: 60),
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
                                    ),
                                    Text(
                                        "1."
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
                )        ],
            ),
          )
      )

    );
  }

  // 画面上部の記録の１つ
  Widget recordText({var time, var record}) {
    return Expanded(
      child: Column(
        children: <Widget>[
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
                color: Colors.black,
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
//        color: selected ? Colors.white : Colors.red[100],
        foregroundDecoration: BoxDecoration(
          color: selected ? Colors.red.withOpacity(0.1) : null
        ),
        child: ListTile(
          enabled: canTap,
          title: Text(
            menu,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18
            ),
          ),
          onTap: () {
            setState(() {
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
}