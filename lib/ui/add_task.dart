import 'package:flutter/material.dart';
import 'package:toda/database/my_database.dart';
import 'package:toda/database/task.dart';
import 'package:toda/utils/date_utils.dart';
import 'package:toda/utils/dialog_utils.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      padding: EdgeInsets.all(26),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: titleController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Please enter a valid title';
                }
                return null;
              },
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                fillColor: Colors.black,
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: descriptionController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Please enter a valid description';
                }
                if (input.length < 5) {
                  return 'description should be at least 5 characters';
                }
                return null;
              },
              maxLines: 4,
              minLines: 2,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                fillColor: Colors.black,
                labelText: 'description',
                labelStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Select Date',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  width: 25,
                ),
                InkWell(
                  onTap: () {
                    showTaskDatePicker();
                  },
                  child: Text(
                    MyDateUtils.formatTaskDate(selectedDate),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                insertTask();
              },
              child: Text(
                'Submit',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Color(0xff06730c),
                elevation: 6.0,
                shadowColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();

  void insertTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        dataTime: selectedDate);
    DialogUtils.showProgressDialog(context, 'Loading... ');
    await MyDatabase.insertTask(task);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessage(context, 'Task inserted successfully',
        posActionText: 'Done', posAction: () {
      Navigator.pop(context);
    }, isDismissible: false);
  }

  void showTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
          Duration(days: 365),
        ),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
    if (userSelectedDate == null) {
      return;
    }
    // Rebuild function
    setState(() {
      selectedDate = userSelectedDate;
    });
  }
}
