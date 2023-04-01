import 'package:flutter/material.dart';
import 'package:toda/ui/settings/settings_tab.dart';
import 'package:toda/ui/tasks_list/tasks_tab.dart';

import '../add_task.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 3.5)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Theme(
          data: ThemeData(
            iconTheme: Theme.of(context).iconTheme,
          ),
          child: Icon(
            Icons.add,
            size: 27.7,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7.5,
        child: BottomNavigationBar(
          onTap: (Index) {
            setState(() {
              selectedIndex = Index;
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddTask();
        });
  }
}
