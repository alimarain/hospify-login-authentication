import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_completion.dart';

class TaskCompletionsNotifier extends StateNotifier<List<TaskCompletion>> {
  TaskCompletionsNotifier() : super([]);

  void setCompletions(List<TaskCompletion> completions) {
    state = completions;
  }

  void addCompletion(TaskCompletion completion) {
    state = [completion, ...state];
  }
}

final taskCompletionsProvider =
    StateNotifierProvider<TaskCompletionsNotifier, List<TaskCompletion>>((ref) {
  return TaskCompletionsNotifier();
});
