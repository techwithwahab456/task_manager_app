class Task {
  int? id;
  String title;
  String description;
  bool isCompleted;
  String createdAt;
  int userId;
   String priority; 
 DateTime? deadline = DateTime.now(); // default to current time

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
    required this.userId,
     this.priority = "Low",
    this.deadline,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt,
      'userId':userId,
       'priority': priority,
       'deadline': deadline.toString()
       
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      createdAt: map['createdAt'],
      userId: map['userId'],
       priority: map['priority'] ?? "Low",
    deadline: map['deadline'] != null && map['deadline'].toString().isNotEmpty
    ? DateTime.tryParse(map['deadline'])
    : null,// ✅ parse string to DateTime
    );
  }
}