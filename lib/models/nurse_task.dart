enum TaskPriority { low, medium, high }

enum TaskCategory { medication, vitals, care, documentation }

class NurseTask {
  final String id;
  final String title;
  final String patient;
  final String room;
  final String time;
  bool completed;
  final TaskPriority priority;
  final TaskCategory category;

  NurseTask({
    required this.id,
    required this.title,
    required this.patient,
    required this.room,
    required this.time,
    this.completed = false,
    required this.priority,
    required this.category,
  });

  String get categoryLabel {
    switch (category) {
      case TaskCategory.medication:
        return 'Medication';
      case TaskCategory.vitals:
        return 'Vitals';
      case TaskCategory.care:
        return 'Care';
      case TaskCategory.documentation:
        return 'Documentation';
    }
  }
}
