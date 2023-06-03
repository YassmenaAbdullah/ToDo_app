import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toda/database/my_database.dart';
import 'package:toda/database/task.dart';
import 'package:toda/utils/dialog_utils.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .2,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (buildContext) {
                deleteTask();
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
          ],
        ),
        child: Container(
          height: 90,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                height: 55,
                width: 3.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.task.description,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).primaryColor,
                ),
                child: Theme(
                  data: ThemeData(
                    iconTheme: Theme.of(context).iconTheme,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 27,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(
      context,
      'Are you sure. you want to delete this task',
      posActionText: 'Yes',
      posAction: () async {
        DialogUtils.showProgressDialog(context, 'Loading..');
        await MyDatabase.deleteTask(widget.task);
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, 'Task Deleted successfully',
            posActionText: 'Ok', negActionText: 'Undo', negAction: () {});
      },
      negActionText: 'Cancel',
    );
  }
}
