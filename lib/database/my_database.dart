import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toda/database/task.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    var tasksCollection = FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
    return tasksCollection;
  }

  static Future<void> insertTask(Task newTask) {
    var tasksCollection = getTasksCollection();
    var doc = tasksCollection.doc();
    newTask.id = doc.id;
    return doc.set(newTask);
  }
}
