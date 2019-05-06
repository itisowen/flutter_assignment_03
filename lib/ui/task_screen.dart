import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/models/firestore_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assignment_03/ui/new_screen.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskScreenState();
  }
}

class TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('todo')
            .where('done', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Todo"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoNewSub()));
                      },
                    )
                  ],
                ),
                body: Center(
                  child: snapshot.data.documents.length == 0
                      ? Text(
                          "No data found..",
                          style: TextStyle(fontSize: 14.0),
                        )
                      : ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return CheckboxListTile(
                              title: Text(document['title']),
                              value: document['done'],
                              onChanged: (bool value) {
                                FirestoreUtils.update(
                                    document.documentID, value);
                              },
                            );
                          }).toList(),
                        ),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
