class Task {
  int? id;
  String heading;
  String details;
  DateTime dueDate;
  bool isCompleted;

  Task({
    this.id,
    required this.heading,
    required this.details,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'heading': heading,
      'details': details,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      heading: map['heading'],
      details: map['details'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
