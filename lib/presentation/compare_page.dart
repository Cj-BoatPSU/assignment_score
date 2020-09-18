import 'package:flutter/material.dart';
import 'package:assigement_1/persons.dart';
import 'package:assigement_1/presentation/edit_page.dart';
import 'package:assigement_1/config/routes.dart';

class ComparePageParameter {
  final List <Persons> personslist;
  final Persons thisperson;
  final Persons nextperson;
  const ComparePageParameter(this.personslist ,this.thisperson, this.nextperson);
}

class ComparePageScreen extends StatefulWidget {
  final List <Persons> personslist;
  final Persons nextperson;
  final Persons thisperson;
  ComparePageScreen(this.personslist ,this.thisperson, this.nextperson);

  @override
  _ComparePageScreenState createState() => _ComparePageScreenState();
}

class _ComparePageScreenState extends State<ComparePageScreen> {
  List <Persons> _personslist;
  Persons _thisperson;
  //int _personslength;
  @override
  void initState() {
    _personslist = widget.personslist;
    _thisperson = widget.thisperson;
  // _personslength = widget.personslist.length;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Sequence Persons "),
        ),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    color: Colors.blue[300],
                    height: 150,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pushNamed(
                                //     AppRoutes.editperson,
                                //     arguments:
                                //         EditPageParameter(widget.thisperson));
                                editPersonToList(context);
                              },
                              child: ListTile(
                                leading: Text(
                                  "${_thisperson.index}",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                title: Text(
                                  _thisperson.name,
                                  style: TextStyle(fontSize: 25),
                                ),
                                trailing: Text(
                                  "${_thisperson.score}",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ])),
                Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Next Person >>",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Text("${widget.nextperson.index}",
                            style: TextStyle(fontSize: 25)),
                        title: Text(widget.nextperson.name,
                            style: TextStyle(fontSize: 25)),
                        trailing: Text(
                          "${widget.nextperson.score}",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ));
  }

  void editPersonToList(BuildContext context) async {
    final Persons editPersonslist = await Navigator.push( context,
    MaterialPageRoute(builder: (context) => EditPageScreen(_thisperson))
    );
    setState(() {
      _thisperson = editPersonslist;
      _personslist.add(editPersonslist);
    });
  }

}
