import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toda/database/my_database.dart';
import 'package:toda/database/task.dart';
import 'package:toda/ui/tasks_list/task_item.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            leftMargin: 40,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              stream: MyDatabase.getTasksRealTimeUpdates(selectedDate),
              builder: (buildContext, snapshot) {
                var task = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'Error Loading Tasks'
                          'Try again later',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  );
                }
                var tasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return TaskItem(
                      tasks![index],
                    );
                  },
                  itemCount: tasks?.length ?? 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
