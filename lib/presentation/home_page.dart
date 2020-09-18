import 'package:assigement_1/presentation/addlistperson.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assigement_1/config/routes.dart';
import 'package:assigement_1/presentation/compare_page.dart';
import 'package:assigement_1/persons.dart';

  

class HomePageScreen extends StatefulWidget {

  HomePageScreen();

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Persons> personslist;
  @override
  void initState() {
   personslist = [
    Persons(1, "JJ", 80),
    Persons(2, "Poon", 77),
    Persons(3, "Geng", 85),
    Persons(4, "John", 60),
    ];
    super.initState();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
      ),
      body: ListView.builder(
        itemCount: personslist.length,
        itemBuilder: (BuildContext context, int index){
          return buildPersons(context, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPersonToList(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
  Widget buildPersons(BuildContext context, int index) {
    return ListTile(
      leading: Text("${personslist[index].index}",style: TextStyle(fontSize: 25,)),
      title: Text("${personslist[index].name}", style: TextStyle(fontSize: 25,)),
      trailing: Text("${personslist[index].score}",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      onTap: () => {
        Navigator.of(context)
                    .pushNamed(AppRoutes.compare, 
                    arguments: ComparePageParameter(personslist, personslist[index], findNextPerson(personslist[index], personslist))),
        //editPersonToList(context, index)
                    },
    );
    
  }
  void addPersonToList(BuildContext context) async {
    final Persons addpersonslist = await Navigator.push( context,
    MaterialPageRoute(builder: (context) => AddPersonPageScreen(personslist.length))
    );
  if(addpersonslist != null){
    setState(() {
      personslist.add(addpersonslist);
    });
   }
  }
  void editPersonToList(BuildContext context, int index) async {
    final Persons editPersonslist = await Navigator.push( context,
    MaterialPageRoute(builder: (context) => ComparePageScreen(personslist, personslist[index], findNextPerson(personslist[index], personslist)))
    );
    if( editPersonslist != null){
    setState(() {
      personslist[editPersonslist.index-1] = editPersonslist;
    });
    }
  }
  
}
Persons findNextPerson(Persons thisperson, List<Persons> personslist){
    List<Persons> personslistsort;
    personslistsort = List.from(personslist);
    personslistsort.sort((a, b) => a.score.compareTo(b.score));
     for(int i = 0 ; i < personslistsort.length ; i++){
          if( thisperson.score < personslistsort[i].score){
              return personslistsort[i];
          }
           
      }
    return thisperson;
 }




