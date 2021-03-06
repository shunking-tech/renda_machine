import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:renda_machine/util/shere_pref.dart';
import 'package:renda_machine/util/sound.dart';
import 'package:renda_machine/util/spl.dart';

class Play extends StatefulWidget {
  // 選択された制限時間を受け取り
  double time;
  var menu;
  var userId;
  Play({this.time, this.menu, this.userId});

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  var isStart = false;   // スタートしているか判断
  var isTimesUp = false;   // タイムアップのフラグ
  var record = 0;        // タップした回数
  var canTap = true;     // タップを許可するか判断

  @override

  initState() {
    super.initState();
    SQL().getNowUserById(id: widget.userId).then((user) {
      print("initState user取得成功");
      if (widget.menu == "ENDRESS") {
        record = user["endless"];
      }
      setState(() {});
    }).catchError((err) {
      print("initState user取得失敗");
    });
  }

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
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      children: <Widget>[

                        // 時間
                        _blockTimer(),
//                        Expanded(
//                          child: Text(
//                            // タイマーの表示　ゼロ埋めがうまくいっていないけど、とりあえずよし
//                            ((widget.time * 100).ceil() / 100).toString().padRight(5, "0").padRight(5, "0"),
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                              fontSize: 50,
//                              color: Colors.white
//                            ),
//                          ),
//                        ),

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
                                            Sound().playSelectMenu();
                                            // タップ回数の保存
                                            SharePrefs().setRecord(menu: widget.menu, record: record);
                                            SQL().saveRecord(menu: widget.menu, record: record, userId: widget.userId).then((value) {
                                              print("SQLでタップ数の保存成功");
                                            }).catchError((err) {
                                              print("SQLでタップ数の保存失敗");
                                              print(err);
                                            });
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

                ],
              ),
            ],
          ),

          Align(
            alignment: Alignment(0.0, 1.0),
            child: Container(
              height: 470,
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                children: <Widget>[
                  tapAreaRow(),
                  tapAreaRow(),
                  tapAreaRow(),
                  tapAreaRow(),
                ],
              )
            ),
          )

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
        child: RaisedButton(
//          enabled: canTap,
          color: Colors.red.withOpacity(0),
          onPressed: isTimesUp ? null : () {
            //1回目のタップでのみタイマーをスタートさせる
            if (!isStart) {
              _startTimer();
            }

            setState(() {
              if (record == null) {
                record = 0;
              }
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
    if (isTimesUp) {
      return Container();
    }
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

    if (isStart || widget.menu == "ENDRESS") {

      // 制限時間が来た時
      if (isTimesUp) {
        return Container(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "${record.toString()}\nTime's Up!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 80,
                      color: Colors.white
                  ),
                ),
              )
            ],
          ),
        );
      }
      return Container(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                (record == null) ? "0" : record.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 80,
                    color: Colors.white
                ),
              ),
            )
          ],
        )
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: 20),
        child: Row(
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
        ),
      );

    }
  }

  Widget _blockTimer() {
    var f = new NumberFormat("00.00");

    if (widget.time >= 0) {   // ENDRESS以外の時にタイマーを表示
      return Expanded(
        child: Text(
          f.format(widget.time),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              color: Colors.white
          ),
        ),
      );
    } else if (widget.time == -1.00) {   // ENDRESSの時の表示
      return Expanded(
        child: Text(
          "NO LIMIT",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40,
              color: Colors.white
          ),
        ),
      );
    } else {
      return Expanded(
        child: Text(
          "00.00",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 50,
              color: Colors.white
          ),
        ),
      );
    }
  }

//  いづれかのボタンを押した時にタイマー開始
  _startTimer() {
    if (widget.time >= 0) {   // ENDRESS以外の時にタイマーを動かす
      Timer.periodic(
          Duration(milliseconds: 1),
              (Timer t) => setState(() {
            widget.time -= 0.01;

            // タイマーが０になったら
            if (widget.time <= 0) {
              t.cancel();       // タイマー止める
              canTap = false;   // タップできなくする
              changeTimesUp();
            }
          })
      );
    }
  }

  void changeTimesUp() {
    setState(() {
      isTimesUp = true;   // タイムアップのフラグ
    });
    Sound().playClear();
  }
}
