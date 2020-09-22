import 'package:assigement_1/presentation/ScrollEventNotifier.dart';
import 'package:assigement_1/presentation/addlistperson.dart';
import 'package:flutter/material.dart';
import 'package:assigement_1/presentation/compare_page.dart';
import 'package:assigement_1/persons.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen();

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Persons> personslist;
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
    personslist = [
      Persons(1, "JJ", 80),
      Persons(2, "Poon", 77),
      Persons(3, "Geng", 85),
      Persons(4, "John", 60),
      Persons(5, "Boat", 70),
      Persons(6, "El", 69),
      Persons(7, "Eve", 46),
      Persons(8, "Roon", 54),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff581845),
      appBar: AppBar(
        title: Text("My List"),
        backgroundColor: Color(0xff900c3f),
      ),
      body: ChangeNotifierProvider.value(
        value: ScrollEventNotifier(false),
        child: Builder(
          builder: (context) {
            var scrollListener = Provider.of<ScrollEventNotifier>(context);
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                    scrollListener.isScrolling = true;
                    print("Scroll Started");
                } else if (notification is ScrollEndNotification) {
                    scrollListener.isScrolling = false;
                    print("Scroll Ended");
                }

                return true;
              },
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: personslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildPersons(context, index);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPersonToList(context);
        },
        child: Icon(Icons.person_add),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget buildPersons(BuildContext context, int index) {

    bool isScrolling = Provider.of<ScrollEventNotifier>(context).isScrolling;

    return Dismissible(
      key: Key(personslist[index].name),
      background: buildDeleteBackgroud(),
      child: TweenAnimationBuilder(
        tween: Tween(begin : isScrolling?0.0:-0.2, end: isScrolling?-0.2:0.0),
        duration: Duration( milliseconds : 300 ),
        builder: (_,double rotation, _child){
          return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.01)
          ..rotateX(rotation),
        alignment: Alignment.center,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: index < 6 ? colors[index] : colors[index - 6],
                        shape: BoxShape.circle),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${personslist[index].index}",
                            style: TextStyle(fontSize: 35),
                          )
                        ])),
                title: Text("${personslist[index].name}",
                    style: TextStyle(
                      fontSize: 35,
                    )),
                trailing: Text("${personslist[index].score}",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    )),
                onTap: () => {editPersonToList(context, index)},
              ),
            ],
          ),
          height: 100.0,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffffc300),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
        },
      ),
      // ignore: missing_return
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                      "Are you sure you want to delete ${personslist[index].name}?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        deletePerson(context, index);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
        }
      },
    );
  }

  void deletePerson(BuildContext context, int index) {
    setState(() {
      personslist.removeAt(index);
    });
    List<Persons> _personslist = personslist;
    int newindex;
    Persons afterDeletePerson;
    for (int i = index; i < _personslist.length; i++) {
      if (index != _personslist.length) {
        newindex = _personslist[i].index;
        --newindex;
        afterDeletePerson =
            Persons(newindex, _personslist[i].name, _personslist[i].score);
        _personslist[i] = afterDeletePerson;
      }
    }

    setState(() {
      personslist = _personslist;
    });
  }

  void addPersonToList(BuildContext context) async {
    final Persons addpersonslist = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddPersonPageScreen(personslist.length)));
    if (addpersonslist != null) {
      setState(() {
        personslist.add(addpersonslist);
      });
    }
  }

  void editPersonToList(BuildContext context, int index) async {
    final Persons editPersonslist = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ComparePageScreen(
                personslist,
                personslist[index],
                findNextPerson(personslist[index], personslist))));
    if (editPersonslist != null) {
      setState(() {
        personslist[editPersonslist.index - 1] = editPersonslist;
      });
      print(personslist[editPersonslist.index - 1].name);
    }
  }

  Widget buildDeleteBackgroud() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}

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
