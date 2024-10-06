class Todo {
  int? id;
  String title;
  String details;
  String dueDate;
  bool isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.details,
    required this.dueDate,
    this.isCompleted = false,
  });

  // Convert Todo object to Map (to store in database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'dueDate': dueDate,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Convert Map to Todo object
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      details: map['details'],
      dueDate: map['dueDate'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
