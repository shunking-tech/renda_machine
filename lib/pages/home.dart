import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renda_machine/pages/play.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var time = 00.00;

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: SingleChildScrollView(
          reverse: true,
          child: Container(
            margin: EdgeInsets.only(bottom: bottomSpace),
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
                    ListTile(
                      onTap: () {
                        _showModalPicker(context);
                      },
                    ),

                    // メニュー
                    Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10, left: 30, right: 30),
                      child: Row(
                        children: <Widget>[
                          menuItem(menu: "10s"),
                          menuItem(menu: "60s"),
                          menuItem(menu: "ENDRESS"),
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
  Widget menuItem({var menu}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: ListTile(
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
              } else if (menu == "60s") {
                time = 60.00;
              } else if (menu == "ENDRESS") {
                time = -1.00;
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