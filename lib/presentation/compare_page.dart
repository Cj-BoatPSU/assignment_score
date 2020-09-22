import 'package:flutter/material.dart';
import 'package:assigement_1/persons.dart';
import 'package:assigement_1/presentation/edit_page.dart';
//import 'package:assigement_1/config/routes.dart';

class ComparePageParameter {
  final List<Persons> personslist;
  final Persons thisperson;
  final Persons nextperson;
  const ComparePageParameter(
      this.personslist, this.thisperson, this.nextperson);
}

class ComparePageScreen extends StatefulWidget {
  final List<Persons> personslist;
  final Persons nextperson;
  final Persons thisperson;
  ComparePageScreen(this.personslist, this.thisperson, this.nextperson);

  @override
  _ComparePageScreenState createState() => _ComparePageScreenState();
}

class _ComparePageScreenState extends State<ComparePageScreen> {
  List<Persons> _personslist;
  Persons _thisperson;
  Persons _nextperson;
  bool _isTop;
  List colors = [
    Color(0xffff9aa2),
    Color(0xffffb7b2),
    Color(0xffffdac1),
    Color(0xffe2f0cb),
    Color(0xffb5ead7),
    Color(0xffc7ceea)
  ];
  @override
  void initState() {
    _personslist = widget.personslist;
    _thisperson = widget.thisperson;
    _nextperson = widget.nextperson;
    _isTop = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ranking Persons "),
        backgroundColor: Color(0xff900c3f),
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  color: new Color(0xffffc300),
                  height: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                " Ranking : ${findRanking(_thisperson, _personslist)}",
                                style: TextStyle(fontSize: 25),
                              ),
                            ]),
                        ListTile(
                          leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: _thisperson.index < 6
                                      ? colors[_thisperson.index]
                                      : colors[_thisperson.index - 6],
                                  shape: BoxShape.circle),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${_thisperson.index}",
                                      style: TextStyle(fontSize: 35),
                                    )
                                  ])),
                          title: Text(
                            _thisperson.name,
                            style: TextStyle(fontSize: 35),
                          ),
                          trailing: Text(
                            "${_thisperson.score}",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: GestureDetector(
                            onTap: () {
                              editPersonToList(context);
                            },
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (findRanking(_nextperson, _personslist) == 1)
                    Row(children: <Widget>[
                      Container(
                        child: Image.asset("images/first.png"),
                      ),
                      Text(_nextperson.name, style: TextStyle(fontSize: 35)),
                    ]),
                  if (findRanking(_nextperson, _personslist) == 2)
                    Row(children: <Widget>[
                      Container(
                        child: Image.asset("images/second.png"),
                      ),
                      Text(_nextperson.name, style: TextStyle(fontSize: 35)),
                    ]),
                  if (findRanking(_nextperson, _personslist) == 3)
                    Row(children: <Widget>[
                      Container(
                        child: Image.asset("images/third.png"),
                      ),
                      Text(_nextperson.name, style: TextStyle(fontSize: 35)),
                    ]),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                height: 200,
                color: Color(0xffffc300),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton.extended(
                            onPressed: () {
                              findNextPersonInList(context);
                            },
                            icon: Icon(Icons.arrow_forward_ios,
                                color: _isTop ? Colors.white38 : Colors.white),
                            label: Text(
                                (_isTop ? " Top person" : "Next Person"),
                                style: TextStyle(
                                    color: _isTop
                                        ? Colors.white38
                                        : Colors.white)),
                            backgroundColor:
                                _isTop ? Colors.black38 : Colors.black87,
                            splashColor: _isTop ? null : Colors.white38,
                          ),
                        ]),
                    Text(
                        " Ranking : " +
                            (_isTop
                                ? "1"
                                : "${findRanking(_nextperson, _personslist)}"),
                        style: TextStyle(fontSize: 25)),
                    ListTile(
                      leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: _nextperson.index < 6
                                  ? colors[_nextperson.index]
                                  : colors[_nextperson.index - 6],
                              shape: BoxShape.circle),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${_nextperson.index}",
                                  style: TextStyle(fontSize: 35),
                                )
                              ])),
                      title: Text(_nextperson.name,
                          style: TextStyle(fontSize: 35)),
                      trailing: Text(
                        "${_nextperson.score}",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  void editPersonToList(BuildContext context) async {
    final Persons editPersonslist = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditPageScreen(_thisperson)));
    if (editPersonslist != null) {
      setState(() {
        _thisperson = editPersonslist;
        _personslist[_thisperson.index - 1] = _thisperson;
        _nextperson = findNextPerson(_thisperson, _personslist);
      });
      Navigator.pop(context, editPersonslist);
    }
  }

  void findNextPersonInList(BuildContext context) {
    final Persons nextperson = findNextPerson(_nextperson, _personslist);
    if (_nextperson.score == nextperson.score) {
      print("Top!!");
      setState(() {
        _isTop = true;
      });
    }
    setState(() {
      _nextperson = nextperson;
    });
  }

// ignore: missing_return
  int findRanking(Persons thisperson, List<Persons> personslist) {
    List<Persons> personslistsort;
    personslistsort = List.from(personslist);
    personslistsort.sort((a, b) => a.score.compareTo(b.score));
    for (int i = 0; i < personslistsort.length; i++) {
      if (thisperson == personslistsort[i]) {
        return personslistsort.length - i;
      }
    }
  }
}

// ignore: missing_return
Persons findNextPerson(Persons thisperson, List<Persons> personslist) {
  List<Persons> personslistsort;
  personslistsort = List.from(personslist);
  personslistsort.sort((a, b) => a.score.compareTo(b.score));
  for (int i = 0; i < personslistsort.length; i++) {
    if (thisperson.score < personslistsort[i].score) {
      return personslistsort[i];
    }
  }
  return thisperson;
}
