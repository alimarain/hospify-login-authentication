enum TaskPriority { low, medium, high }

class DoctorTask {
  final String id;
  final String title;
  final String time;
  final TaskPriority priority;
  bool completed;

  DoctorTask({
    required this.id,
    required this.title,
    required this.time,
    required this.priority,
    this.completed = false,
  });
}
