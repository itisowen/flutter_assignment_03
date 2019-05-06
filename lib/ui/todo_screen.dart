import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/ui/completed_screen.dart';
import 'package:flutter_assignment_03/ui/task_screen.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoScreenState();
  }
}

class TodoScreenState extends State {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [new TaskScreen(), new CompletedScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Center(
                child: _children.elementAt(_currentIndex),
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Colors.black,
                    primaryColor: Colors.orange[400],
                    textTheme: Theme.of(context)
                        .textTheme
                        .copyWith(caption: TextStyle(color: Colors.grey))),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: onTabTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      title: Text("Task"),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done_all), title: Text("Completed")),
                  ],
                ),
              ),
            )));
  }
}
