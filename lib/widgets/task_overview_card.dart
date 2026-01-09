// lib/widgets/nurse_dashboard/task_overview_card.dart
import 'package:flutter/material.dart';

class TaskOverviewCard extends StatelessWidget {
  const TaskOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shift Tasks',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildProgressBar(context, 'Completed', 12, 20, Colors.green),
            const SizedBox(height: 12),
            _buildProgressBar(context, 'In Progress', 5, 20, Colors.blue),
            const SizedBox(height: 12),
            _buildProgressBar(context, 'Pending', 3, 20, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
      BuildContext context, String label, int value, int total, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            Text('$value/$total',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value / total,
          backgroundColor: color.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation(color),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
