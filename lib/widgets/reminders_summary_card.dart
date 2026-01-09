import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/models/nurse_reminder.dart';
import '../../providers/nurse_reminders_provider.dart';

class RemindersSummaryCard extends ConsumerWidget {
  const RemindersSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(pendingRemindersProvider);
    final overdue = ref.watch(overdueRemindersProvider);
    final upcoming = ref.watch(upcomingRemindersProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.orange),
                const SizedBox(width: 8),
                const Text('Reminders',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Spacer(),
                if (overdue.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, size: 14, color: Colors.red),
                        const SizedBox(width: 4),
                        Text('${overdue.length} overdue',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12)),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _StatBox(
                    label: 'Pending',
                    value: pending.length.toString(),
                    color: Colors.blue),
                const SizedBox(width: 12),
                _StatBox(
                    label: 'Overdue',
                    value: overdue.length.toString(),
                    color: Colors.red),
                const SizedBox(width: 12),
                _StatBox(
                    label: 'Next Hour',
                    value: upcoming.length.toString(),
                    color: Colors.orange),
              ],
            ),
            if (upcoming.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Upcoming',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...upcoming.take(3).map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(r.type.icon, size: 16, color: r.type.color),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(r.title,
                                maxLines: 1, overflow: TextOverflow.ellipsis)),
                        Text(r.timeUntilDue,
                            style: TextStyle(
                                fontSize: 12,
                                color: r.isOverdue ? Colors.red : Colors.grey)),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatBox(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: TextStyle(fontSize: 12, color: color)),
          ],
        ),
      ),
    );
  }
}
