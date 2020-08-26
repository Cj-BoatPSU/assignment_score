import 'package:assigement_1/config/routes.dart';
import 'package:assigement_1/presentation/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  @override
  List<String> _todoItems = [];
  List<Map> _todoStart = [
    {"name": 'JJ', "score": "80"},
    {"name": 'Poon', "score": "77"},
    {"name": "Geng", "score": "85"},
    {"name": "John", "score": "60"}
  ];

  // This will be called each time the + button is pressed
  void _addTodoItem() {
    // Putting our code inside "setState" tells the app that our state has changed, and
    // it will automatically re-render the list
    setState(() {
      int index = _todoItems.length;
      _todoItems.add('Item ' + index.toString());
    });
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem();
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem() {
    var _people = _todoStart;
    return new ListView(
      children: _people
          .map((person) => Row(
                children: [
                  Text(person["name"]),
                  Text(person["score"]),
                ],
              ))
          .toList(),
    );
  }

  Widget _initpage() {
    var _people_1 = _todoStart;
    return Column(
      children: <Widget>[
        Container(
          child: ListView(
            children: [
              Container(
                child: ListTile(
                  title: Text("My List",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                ),
                decoration: BoxDecoration(border: Border.all()),
              ),
              Container(
                child: ListView(
                  children: [
                     Row(
                        children: [
                          Text(_people_1[0]["name"]),
                          Text(_people_1[0]["score"]),
                        ],
                      ),
                  ]
                ),
                height: 40,
                decoration: BoxDecoration(border: Border.all()),
              ),
              Container(
                child: ListView(
                  children: [
                     Row(
                        children: [
                          Text(_people_1[1]["name"]),
                          Text(_people_1[1]["score"]),
                        ],
                      ),
                  ]
                ),
                height: 40,
                decoration: BoxDecoration(border: Border.all()),
              ),
              Container(
                child: ListView(
                  children: [
                     Row(
                        children: [
                          Text(_people_1[2]["name"]),
                          Text(_people_1[2]["score"]),
                        ],
                      ),
                  ]
                ),
                height: 40,
                decoration: BoxDecoration(border: Border.all()),
              ),
              Container(
                child: ListView(
                  children: [
                     Row(
                        children: [
                          Text(_people_1[3]["name"]),
                          Text(_people_1[3]["score"]),
                        ],
                      ),
                  ]
                ),
                height: 40,
                decoration: BoxDecoration(border: Border.all()),
              ),
            ],
            
          ),
          height: 240,
          decoration: BoxDecoration(border: Border.all()),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _initpage(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
