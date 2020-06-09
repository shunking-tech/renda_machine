import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renda_machine/util/shere_pref.dart';

class Play extends StatefulWidget {
  // 選択された制限時間を受け取り
  double time;
  var menu;
  Play({this.time, this.menu});

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  var isStart = false;   // スタートしているか判断
  var record = 0;        // タップした回数
  var canTap = true;     // タップを許可するか判断

  @override
  Widget build(BuildContext context) {
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
          ListView(
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
                              fontSize: 50,
                              color: Colors.white
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
                                            // タップ回数の保存
                                            SharePrefs().setRecord(menu: widget.menu, record: record);
                                            // 確認
                                            SharePrefs().getRecord(menu: widget.menu);
                                            print(widget.menu);
                                            // ページ戻る
                                            Navigator.pop(context);
                                          },
                                          color: Colors.red.withOpacity(0.2),
                                          child: Text(
                                            "QUIT",
                                            style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.white
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

                  // 最初は案内　タップし始めたら回数　を表示
                  guideOrRecord(),

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
        ],
      )
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
          color: Colors.red.withOpacity(0.2)
        ),
        child: ListTile(
          enabled: canTap,
          onTap: () {
            //1回目のタップでのみタイマーをスタートさせる
            if (!isStart) {
              _startTimer();
            }

            setState(() {
              record += 1;
            });

            isStart = true;  // スタートしたことを知らせる
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

  // 最初は案内　タップし始めたら回数　を表示する箇所
  Widget guideOrRecord() {

    if (isStart) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Text(
              record.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "Press any\nbutton to start",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white
              ),
            ),
          )
        ],
      );
    }
  }

//  いづれかのボタンを押した時にタイマー開始
  _startTimer() {
    Timer.periodic(
        Duration(milliseconds: 1),
            (Timer t) => setState(() {
              widget.time -= 0.01;

              // タイマーが０になったら
              if (widget.time <= 0) {
                t.cancel();       // タイマー止める
                canTap = false;   // タップできなくする
              }
        })
    );
  }
}
