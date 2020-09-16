import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Add Persons',
      // theme: ThemeData(
      //   primarySwatch: Colors.blueGrey,
      // ),
      home: AddPage(title: 'Add Persons'),
    );
  }
}

class AddPage extends StatefulWidget {
  AddPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  String answer;
  String inputFull;

  @override
  void initState() {
    answer = "0";
    inputFull = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xffecf0f1),
      ),
      body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[buildTextField(),buildAnswerWidget(),
            buildNumPadWidget()
            ],
          )),
    );
  }

  Widget buildTextField(){
    var _textController = new TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Name : ", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Container(
            width: 120,
            child: TextField(
            controller: _textController,style:TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),)
        ],
      ),
    );
  }

  Widget buildAnswerWidget() {
    return Container(
     //  constraints: BoxConstraints.expand(height: 90),
        padding: EdgeInsets.all(10),
        color: Colors.blue[300],
        child: Align(
            alignment: Alignment.center,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text(inputFull + " ", style: TextStyle(fontSize: 18)),
                  Text(answer,
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
                ])));
  }

  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffdbdbdb),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
              }),
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
            ]),
            Row(
              children: <Widget>[
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
              }),
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
            ]),
            Row(
              children: <Widget>[
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
              }),
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
            ]),
            Row(
              children: <Widget>[
              buildNumberButton("CLR", onTap: () {
                clearAnswer();
              }),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
              }),
              buildNumberButton("OK", onTap: () {
                addDotToAnswer();
              }),
            ]),
          ],
        ));
  }


  void clearAnswer() {
    setState(() {
      answer = "0";
    });
  }

  
  void addDotToAnswer() {
    setState(() {
      if (!answer.contains(".")) {
        answer = answer + ".";
      }
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
        // Not do anything.
      }
      else if (number != 0 && answer == "0") {
        answer = number.toString();
      }
      else {
        answer += number.toString();
      }
    });
  }

  Widget buildNumberButton(String str, { @required Function()onTap}) {
    Widget widget;
      widget = Container(
          margin: EdgeInsets.all(10),
          child: Material(
              color: Colors.white,
              child: InkWell(
                  onTap: onTap, highlightColor: Colors.blue[300],
                  child: Container(
                      height: 70,
                      child: Center(
                          child: Text(str,
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold)))))));
    return Expanded(child: widget);
  }
}
