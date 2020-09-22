
import 'package:assigement_1/persons.dart';
import 'package:flutter/material.dart';

class AddPersonPageParameter {
   final int personslength;
   const AddPersonPageParameter(this.personslength);
}

class AddPersonPageScreen extends StatefulWidget {
   final int personslength;
   AddPersonPageScreen(this.personslength);
  @override
  _AddPersonPageScreenState createState() => _AddPersonPageScreenState();
}

class _AddPersonPageScreenState extends State<AddPersonPageScreen> {
  String answer;   
  Persons newperson;
  int personslength; 
  TextEditingController _textController;
  @override
  void initState() {
    answer = "0";
    personslength = widget.personslength;
    _textController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Add persons"),
        backgroundColor: Color(0xff900c3f),
      ),
      body: Container(
        color: Color(0xff581845),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[buildTextField(), buildAnswerWidget(), buildNumPadWidget()],
        ),
      ),
    );
  }

 Widget buildTextField(){
    return Container(
      color: Color(0xffff5733),
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
              maxLength: 8,
            ),)
        ],
      ),
    );
  }

  Widget buildAnswerWidget() {
    return Container(
      //  constraints: BoxConstraints.expand(height: 90),
        padding: EdgeInsets.all(10),
        color: Color(0xffff5733),
        child: Align(
            alignment: Alignment.center,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text("Score : "+answer,
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
                ])));
  }

  Widget buildNumPadWidget() {
    return Container(
        margin: EdgeInsets.only(top : 20),
        color: Color(0xff581845),
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
                    addPersonToList();
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


  void addPersonToList() {
  //  Persons newpersons = Persons(6, _name, answer);
    setState(() {
      newperson = Persons(personslength+1, _textController.text, int.parse(answer));
      
    }); 
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
            color: Color(0xffffc300),
            child: InkWell(
                onTap: onTap, highlightColor: Colors.blue[300],
                child: Container(
                    height: 70,
                    child: Center(
                        child: Text(str,
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)))))));
    return Expanded(child: widget);
  }

}
