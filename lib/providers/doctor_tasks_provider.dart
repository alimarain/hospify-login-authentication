import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/doctor_task.dart';

final doctorTasksProvider =
    StateNotifierProvider<DoctorTasksNotifier, List<DoctorTask>>((ref) {
  return DoctorTasksNotifier();
});

class DoctorTasksNotifier extends StateNotifier<List<DoctorTask>> {
  DoctorTasksNotifier()
      : super([
          DoctorTask(
              id: '1',
              title: 'Call Mariam Sheikh about test results',
              time: '10:30 AM',
              priority: TaskPriority.high),
          DoctorTask(
              id: '2',
              title: "Review Bilal Ahmed's MRI scan",
              time: '11:00 AM',
              priority: TaskPriority.medium),
          DoctorTask(
              id: '3',
              title: 'Follow up with Zainab Noor prescription',
              time: '2:00 PM',
              priority: TaskPriority.low),
          DoctorTask(
              id: '4',
              title: 'Prepare discharge summary for Room 205',
              time: '3:30 PM',
              priority: TaskPriority.medium),
          DoctorTask(
              id: '5',
              title: 'Review lab results for new admissions',
              time: '4:00 PM',
              priority: TaskPriority.medium,
              completed: true),
        ]);

  void toggleComplete(String id) {
    state = state.map((task) {
      if (task.id == id) {
        return DoctorTask(
          id: task.id,
          title: task.title,
          time: task.time,
          priority: task.priority,
          completed: !task.completed,
        );
      }
      return task;
    }).toList();
  }
}
