import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea( // OSの標準ボタンとかぶらないように表示する
        child: Column(children: <Widget>[
          Expanded( // めいいっぱい伸ばす
            child:  Container(color: Colors.green)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(_isCounting ? 'STOP' : 'START'),
                onPressed: () {
                  setState(() {
                    _isCounting = !_isCounting;
                  });
                },
              ),
              Container(width: 30), // 余白

              if (!_isCounting)
                RaisedButton(
                  child: Text('RESET'),
                  onPressed: () {
                    print('RESET');
                  },
                )
            ],
          )
        ]),
      ),
    );
  }
}
