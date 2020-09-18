
import 'package:assigement_1/persons.dart';
import 'package:flutter/material.dart';

class EditPageParameter {
   final Persons thisperson;
   const EditPageParameter(this.thisperson);
}

class EditPageScreen extends StatefulWidget {
   final Persons thisperson;
   EditPageScreen(this.thisperson);
  @override
  _EditPageScreenState createState() => _EditPageScreenState();
}

class _EditPageScreenState extends State<EditPageScreen> {
  int indexperson;
  String answer;
  Persons newperson;
  TextEditingController _textController;
  @override
  void initState() {
    indexperson = widget.thisperson.index;
    answer = "${widget.thisperson.score}";
    newperson = widget.thisperson;
    _textController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Edit persons"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[buildTextField(), buildAnswerWidget(), buildNumPadWidget()],
        ),
      ),
    );
  }

 Widget buildTextField(){
   
    _textController.text = widget.thisperson.name;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Name : ", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Container(
            width: 120,
            child: TextField(controller: _textController,style:TextStyle(fontSize: 35, fontWeight: FontWeight.bold),    
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
                    editToPerson();
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


  void editToPerson() {
    
    setState(() {
      newperson = Persons(indexperson, _textController.text, int.parse(answer));
    });
    print("${newperson.score}");
    Navigator.pop(context, newperson);
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
