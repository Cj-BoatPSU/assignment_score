import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assigement_1/config/routes.dart';
import 'package:assigement_1/presentation/show_page.dart';

List<Map> persons = [
  {"name": "JJ", "score": "80"},
  {"name": "Poon", "score": "77"},
  {"name": "Geng", "score": "85"},
  {"name": "John", "score": "60"}
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
      ),
      body: ListView(
        children: <Widget>[
          for (int index = 0; index < persons.length; index++)
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.show, arguments: ShowPageParameter(persons[index]["name"],persons[index]["score"]));
              },
              child: Container(
                child: ListTile(
                  leading: Text("${index + 1}"),
                  title: Text("${persons[index]["name"]}"),
                  trailing: Text(
                    "${persons[index]["score"]}",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: Colors.black) )),
                
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.add);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
