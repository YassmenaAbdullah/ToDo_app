import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toda/database/task.dart';
import 'package:toda/utils/date_utils.dart';

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
    newTask.dataTime = newTask.dataTime.extractDateOnly();
    return doc.set(newTask);
  }

  static Future<List<Task>> getTasks(DateTime dateTime) async {
    var querySnapshot = await getTasksCollection()
        .where('dateTime',
            isEqualTo: dateTime.extractDateOnly().millisecondsSinceEpoch)
        .get();
    var tasksList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return tasksList;
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTimeUpdates(
      DateTime dateTime) {
    return getTasksCollection()
        .where('dateTime',
            isEqualTo: dateTime.extractDateOnly().millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.delete();
  }
}
