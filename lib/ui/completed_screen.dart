import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assignment_03/models/firestore_model.dart';

class CompletedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CompletedScreenState();
  }
}

class CompletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('todo')
            .where('done', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Todo"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        FirestoreUtils.deleteAllDone();
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
