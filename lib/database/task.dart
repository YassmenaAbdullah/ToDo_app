class Task {
  String id;
  String title;
  String description;
  DateTime dataTime;
  bool isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dataTime,
      this.isDone = false});

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          dataTime: DateTime.fromMillisecondsSinceEpoch(data['dataTime']),
          isDone: data['isDone'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dataTime': dataTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
