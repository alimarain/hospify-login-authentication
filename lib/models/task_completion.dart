class TaskCompletion {
  final String id;
  final String task;
  final String completedBy;
  final String role;
  final String patient;
  final String room;
  final String category;
  final DateTime completedAt;

  TaskCompletion({
    required this.id,
    required this.task,
    required this.completedBy,
    required this.role,
    required this.patient,
    required this.room,
    required this.category,
    required this.completedAt,
  });

  factory TaskCompletion.fromJson(Map<String, dynamic> json) {
    return TaskCompletion(
      id: json['id'],
      task: json['task'],
      completedBy: json['completed_by'],
      role: json['role'],
      patient: json['patient'],
      room: json['room'],
      category: json['category'],
      completedAt: DateTime.parse(json['completed_at']),
    );
  }
}
