import 'package:flutter/material.dart';

class ShowPageParameter {
  final String title;
  final String score;
  const ShowPageParameter(this.title, this.score);
}

class ShowPageScreen extends StatefulWidget {
  final String title;
  final String score;
  ShowPageScreen({this.title, this.score});

  @override
  _ShowPageScreenState createState() => _ShowPageScreenState();
}

class _ShowPageScreenState extends State<ShowPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[buildName(), buildscore(), buildNumPadWidget()],
        ),
      ),
    );
  }

  Widget buildName() {
    return Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints.expand(height: 90),
        color: Color(0xffecf0f1),
        child: Align(
            alignment: Alignment.center,
            child: Text("Name : ${widget.title}",
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                ),
                );
  }

  Widget buildscore(){
      return Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints.expand(height: 90),
          color: Colors.blue[300],
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Container(
                      //color: Colors.blue[300],
                      child: Text(widget.score,
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,))),
                ]
                )
                );
  }

  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffecf0f1),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
          mainAxisSize: MainAxisSize.max,
         // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(children: <Widget>[
              buildNumberButton("7"),
              buildNumberButton("8"),
              buildNumberButton("9"),
            ]),
            Row(children: <Widget>[
              buildNumberButton("4"),
              buildNumberButton("5"),
              buildNumberButton("6"),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1"),
              buildNumberButton("2"),
              buildNumberButton("3"),
            ]),
            Row(children: <Widget>[
              buildNumberButton("CLR"),
              buildNumberButton("0"),
              buildNumberButton("OK"),
            ]),
          ],
        ),));
  }

  Expanded buildNumberButton(String str) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(2),
            color: Colors.white,
            height: 70,
            child: Center(
                child: Text(str,
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold)))));
  }

}
