import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renda_machine/pages/play.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                padding: EdgeInsets.only(left: 100,right: 100),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: new OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                      ),
                    ),
                  ),
                ),
              ),

              // メニュー
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10, left: 30, right: 30),
                child: Row(
                  children: <Widget>[
                    menuItem(time: "10s"),
                    menuItem(time: "60s"),
                    menuItem(time: "ENDRESS"),
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
                                    builder: (context) => Play(),
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
  Widget menuItem({var time}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: ListTile(
          title: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18
            ),
          ),
          onTap: () {},
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      )
    );
  }
}