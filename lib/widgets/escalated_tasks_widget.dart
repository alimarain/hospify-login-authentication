import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/dashboard_providers.dart';
import '../models/dashboard_models.dart';

class EscalatedTasksWidget extends ConsumerWidget {
  const EscalatedTasksWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ensure 'escalatedTasksProvider' in your providers file returns List<TaskItem>
    final tasks = ref.watch(escalatedTasksProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card, // Updated to match new theme alias
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppColors.redAccent),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Escalated Tasks",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Overdue tasks requiring attention",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: AppColors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: Text("${tasks.length} Overdue",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Task List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) =>
                _buildTaskItem(context, tasks[index] as TaskItem),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, TaskItem task) {
    // ✅ FIX: Initialize variables or provide default case
    Color severityColor;
    Color bgColor;

    switch (task.severity) {
      case TaskSeverity.critical:
        severityColor = AppColors.redAccent;
        bgColor = AppColors.redAccent.withOpacity(0.1);
        break;
      case TaskSeverity.high:
        severityColor = AppColors.orangeAccent;
        bgColor = AppColors.orangeAccent.withOpacity(0.1);
        break;
      case TaskSeverity.medium:
        severityColor = AppColors.secondaryAccent; // Cyan
        bgColor = AppColors.secondaryAccent.withOpacity(0.1);
        break;
      default: // ✅ Safety fallback
        severityColor = AppColors.textSecondary;
        bgColor = AppColors.surface;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: severityColor.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.access_time_filled, color: severityColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(task.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          border: Border.all(color: severityColor),
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(task.severity.name.toUpperCase(),
                          style: TextStyle(color: severityColor, fontSize: 10)),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text("${task.patientName} • Room ${task.room}",
                    style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 12),
                        children: [
                      TextSpan(text: "Original: ${task.originalTime}  "),
                      TextSpan(
                          text: "Overdue by ${task.overdueMinutes} mins",
                          style: TextStyle(color: severityColor)),
                    ]))
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Assigned: ${task.assignedTo}",
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.arrow_forward,
                      size: 14, color: AppColors.redAccent),
                  const SizedBox(width: 4),
                  Text(task.reportedTo,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.redAccent)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
