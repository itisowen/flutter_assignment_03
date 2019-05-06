import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoNewSub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoNewSubState();
  }
}

class TodoNewSubState extends State<TodoNewSub> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Subject'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill subject";
                  }
                },
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () async {
                  _formkey.currentState.validate();
                  if (subjectController.text.isNotEmpty) {
                    Firestore.instance.collection('todo').document().setData(
                        {'title': subjectController.text, 'done': false});
                    Navigator.pop(context, true);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
