import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static bool _isCounting = false;
  static int _defaultSeconds = 5;
  static int _seconds = _defaultSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        // OSの標準ボタンとかぶらないように表示する
        child: Column(children: <Widget>[
          Expanded(
              // めいいっぱい伸ばす
              child: Center(
                  child: Text(
            _seconds.toString(),
            style: TextStyle(fontSize: 100),
          ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(_isCounting ? 'STOP' : 'START'),
                onPressed: () {
                  _handleTimer();
                },
              ),
              Container(width: 30), // 余白

              if (!_isCounting)
                RaisedButton(
                  child: Text('RESET'),
                  onPressed: () {
                    print('RESET');
                    setState(() {
                      _seconds = _defaultSeconds;
                    });
                  },
                )
            ],
          )
        ]),
      ),
    );
  }

  Timer _timer;

  void _handleTimer() {
    setState(() {
      _isCounting = !_isCounting;
    });

    if (_isCounting) {
      // 1秒ごとにカウントダウンする
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          _seconds--;
        });
        if (_seconds <= 0) {
          // 完了dialog
          _showFinishedDialog();
          _timer.cancel();
        }
      });
    } else {
      // カウントをとめる
      _timer.cancel();
    }
  }

  void _showFinishedDialog() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('タイマー終了'),
        content: Text('完了しました'),
        actions: <Widget>[
          RaisedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    });
  }
}
