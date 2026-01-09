import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nurse_task.dart';

final nurseTasksProvider =
    StateNotifierProvider<NurseTasksNotifier, List<NurseTask>>((ref) {
  return NurseTasksNotifier();
});

class NurseTasksNotifier extends StateNotifier<List<NurseTask>> {
  NurseTasksNotifier()
      : super([
          NurseTask(
              id: '1',
              title: 'Administer morning medication',
              patient: 'Ahmed Khan',
              room: '204',
              time: '08:00 AM',
              priority: TaskPriority.high,
              category: TaskCategory.medication),
          NurseTask(
              id: '2',
              title: 'Check vital signs',
              patient: 'Fatima Ali',
              room: '207',
              time: '08:30 AM',
              priority: TaskPriority.high,
              category: TaskCategory.vitals),
          NurseTask(
              id: '3',
              title: 'Change wound dressing',
              patient: 'Hassan Malik',
              room: '210',
              time: '09:00 AM',
              priority: TaskPriority.medium,
              category: TaskCategory.care),
          NurseTask(
              id: '4',
              title: 'Update patient chart',
              patient: 'Sara Noor',
              room: '203',
              time: '09:30 AM',
              priority: TaskPriority.low,
              category: TaskCategory.documentation),
          NurseTask(
              id: '5',
              title: 'Assist with physical therapy',
              patient: 'Omar Sheikh',
              room: '215',
              time: '10:00 AM',
              priority: TaskPriority.medium,
              category: TaskCategory.care),
          NurseTask(
              id: '6',
              title: 'Post-op monitoring',
              patient: 'Zainab Hussain',
              room: '212',
              time: '10:30 AM',
              priority: TaskPriority.high,
              category: TaskCategory.vitals),
        ]);

  void toggleComplete(String id) {
    state = state.map((task) {
      if (task.id == id) {
        return NurseTask(
          id: task.id,
          title: task.title,
          patient: task.patient,
          room: task.room,
          time: task.time,
          completed: !task.completed,
          priority: task.priority,
          category: task.category,
        );
      }
      return task;
    }).toList();
  }
}

final taskFilterProvider = StateProvider<TaskCategory?>((ref) => null);
