import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/models/todo.dart';
import 'package:flutter_assignment_02/ui/new_screen.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskScreenState();
  }
}

class TaskScreenState extends State<TaskScreen> {
  TodoProvider db = TodoProvider();
  List<Todo> todoList;
  int count = 0;

  void getList() async {
    await db.open("todo.db");
    db.getAll().then((todoList) {
      setState(() {
        this.todoList = todoList;
        count = todoList.length;
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
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TodoNewSub()));
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
                  itemCount: todoList.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, position) {
                    return Column(
                      children: <Widget>[
                        Divider(
                          height: 5.0,
                        ),
                        CheckboxListTile(
                          title: Text(todoList[position].title),
                          value: todoList[position].done,
                          onChanged: (bool value) {
                            setState(() {
                              todoList[position].done = value;
                            });
                            db.update(todoList[position]);
                          },
                        )
                      ],
                    );
                  },
                ),
        ));
  }
}
