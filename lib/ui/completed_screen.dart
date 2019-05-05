import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/models/todo.dart';

class CompletedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CompletedScreenState();
  }
}

class CompletedScreenState extends State<CompletedScreen> {
  TodoProvider db = TodoProvider();
  List<Todo> todoDoneList;
  int count = 0;

  void getList() async {
    await db.open("todo.db");
    db.getAllDone().then((todoDoneList) {
      setState(() {
        this.todoDoneList = todoDoneList;
        count = todoDoneList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              db.deleteAllDone();
            },
          )
        ],
      ),
      body: Center(
        child: count == 0
            ? Text(
                "No data found..",
                style: TextStyle(fontSize: 14.0),
              )
            : ListView.builder(
                itemCount: todoDoneList.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, position) {
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 5.0,
                      ),
                      CheckboxListTile(
                        title: Text(todoDoneList[position].title),
                        value: todoDoneList[position].done,
                        onChanged: (bool value) {
                          setState(() {
                            todoDoneList[position].done = value;
                          });
                          db.update(todoDoneList[position]);
                        },
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
