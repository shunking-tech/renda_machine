import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  // 選択された制限時間を受け取り
  double time;
  Play({this.time});

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[

              // 画面上部
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  children: <Widget>[

                    // 時間
                    Expanded(
                      child: Text(
                        // タイマーの表示　ゼロ埋めがうまくいっていないけど、とりあえずよし
                        ((widget.time * 100).ceil() / 100).toString().padRight(5, "0").padRight(5, "0"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50
                        ),
                      ),
                    ),

                    // 終了ボタン
                    Expanded(
                      child: Container(
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
                                        Navigator.pop(context);
                                      },
                                      color: Colors.white,
                                      child: Text(
                                        "QUIT",
                                        style: TextStyle(
                                          fontSize: 50
                                        ),
                                      ),
                                    ),
                                  )
                              )
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),

              // 案内
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Press any\nbutton to start",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40
                      ),
                    ),
                  )
                ],
              ),

              // タップ部分
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  children: <Widget>[
                    tapAreaRow(),
                    tapAreaRow(),
                    tapAreaRow(),
                    tapAreaRow(),
                  ],
                )
              )

            ],
          ),
        ],
      ),
    );
  }

  // タップ箇所の１つ
  Widget tapAreaOne() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
        ),
        child: ListTile(
          onTap: () {
            _startTimer();
          },
        ),
      )
    );
  }

  // タップエリア
  Widget tapAreaRow() {
    return Row(
      children: <Widget>[
        tapAreaOne(),
        tapAreaOne(),
        tapAreaOne(),
        tapAreaOne()
      ],
    );
  }

//  いづれかのボタンを押した時にタイマー開始
  _startTimer() {
    Timer.periodic(
        Duration(milliseconds: 1),
            (Timer t) => setState(() {
              widget.time -= 0.01;

              if (widget.time <= 0) {
                t.cancel();
              }
        })
    );
  }
}
