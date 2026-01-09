import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/reminder.dart';
import '../providers/reminders_provider.dart';

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen> {
  @override
  Widget build(BuildContext context) {
    final reminders = ref.watch(remindersProvider);
    final pending = reminders
        .where((r) =>
            r.status == ReminderStatus.pending ||
            r.status == ReminderStatus.snoozed)
        .toList()
      ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    final completed =
        reminders.where((r) => r.status == ReminderStatus.completed).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Reminders',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddReminderDialog(context)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildUpcomingSection(pending),
          const SizedBox(height: 24),
          _buildCompletedSection(completed),
        ],
      ),
    );
  }

  Widget _buildUpcomingSection(List<Reminder> reminders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.schedule, color: Colors.teal),
            const SizedBox(width: 8),
            const Text('Upcoming',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(12)),
              child: Text('${reminders.length}',
                  style: TextStyle(
                      color: Colors.teal.shade700,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (reminders.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.check_circle,
                      size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  Text('All caught up!',
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
          )
        else
          ...reminders.map((r) => _ReminderCard(
                reminder: r,
                onComplete: () =>
                    ref.read(remindersProvider.notifier).completeReminder(r.id),
                onSnooze: (duration) => ref
                    .read(remindersProvider.notifier)
                    .snoozeReminder(r.id, duration),
                onDelete: () =>
                    ref.read(remindersProvider.notifier).deleteReminder(r.id),
              )),
      ],
    );
  }

  Widget _buildCompletedSection(List<Reminder> reminders) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            const Text('Completed Today',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        if (reminders.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12)),
            child: Text('No completed reminders',
                style: TextStyle(color: Colors.grey.shade600)),
          )
        else
          ...reminders.map((r) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(r.title,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              decoration: TextDecoration.lineThrough)),
                    ),
                    Text(DateFormat('h:mm a').format(r.completedAt!),
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              )),
      ],
    );
  }

  void _showAddReminderDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    ReminderType selectedType = ReminderType.task;
    DateTime selectedTime = DateTime.now().add(const Duration(hours: 1));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('New Reminder'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: 'Title', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                        labelText: 'Description', border: OutlineInputBorder()),
                    maxLines: 2),
                const SizedBox(height: 12),
                DropdownButtonFormField<ReminderType>(
                  value: selectedType,
                  decoration: const InputDecoration(
                      labelText: 'Type', border: OutlineInputBorder()),
                  items: ReminderType.values
                      .map((t) => DropdownMenuItem(
                          value: t, child: Text(t.name.toUpperCase())))
                      .toList(),
                  onChanged: (v) => setDialogState(() => selectedType = v!),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Scheduled Time'),
                  subtitle:
                      Text(DateFormat('MMM d, h:mm a').format(selectedTime)),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: selectedTime,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)));
                    if (date != null) {
                      final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(selectedTime));
                      if (time != null) {
                        setDialogState(() => selectedTime = DateTime(date.year,
                            date.month, date.day, time.hour, time.minute));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  ref.read(remindersProvider.notifier).addReminder(Reminder(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        type: selectedType,
                        title: titleController.text,
                        description: descController.text,
                        scheduledTime: selectedTime,
                      ));
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onComplete;
  final Function(Duration) onSnooze;
  final VoidCallback onDelete;

  const _ReminderCard(
      {required this.reminder,
      required this.onComplete,
      required this.onSnooze,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final config = _getTypeConfig(reminder.type);
    final now = DateTime.now();
    final diff = reminder.scheduledTime.difference(now);
    final isOverdue = diff.isNegative;
    final isSoon = !isOverdue && diff.inMinutes <= 15;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isOverdue
            ? Border.all(color: Colors.red.shade300, width: 2)
            : isSoon
                ? Border.all(color: Colors.orange.shade300, width: 2)
                : null,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: config['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(config['icon'], color: config['color']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reminder.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      if (reminder.description.isNotEmpty)
                        Text(reminder.description,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 13)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(isOverdue ? Icons.warning : Icons.schedule,
                              size: 14,
                              color: isOverdue
                                  ? Colors.red
                                  : isSoon
                                      ? Colors.orange
                                      : Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            isOverdue
                                ? 'Overdue'
                                : isSoon
                                    ? 'Due soon'
                                    : DateFormat('h:mm a')
                                        .format(reminder.scheduledTime),
                            style: TextStyle(
                                fontSize: 12,
                                color: isOverdue
                                    ? Colors.red
                                    : isSoon
                                        ? Colors.orange
                                        : Colors.grey.shade600,
                                fontWeight: (isOverdue || isSoon)
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          if (reminder.patientName != null) ...[
                            const SizedBox(width: 12),
                            Icon(Icons.person,
                                size: 14, color: Colors.grey.shade500),
                            const SizedBox(width: 4),
                            Text(reminder.patientName!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade600)),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                if (reminder.isRecurring)
                  Icon(Icons.repeat, color: Colors.grey.shade400, size: 20),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16))),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                TextButton.icon(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Delete'),
                    onPressed: onDelete,
                    style: TextButton.styleFrom(foregroundColor: Colors.grey)),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.snooze, size: 18),
                  label: const Text('Snooze'),
                  onPressed: () => _showSnoozeOptions(context),
                  style: TextButton.styleFrom(foregroundColor: Colors.orange),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Done'),
                  onPressed: onComplete,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnoozeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Snooze for...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('5 minutes'),
                onTap: () {
                  onSnooze(const Duration(minutes: 5));
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('15 minutes'),
                onTap: () {
                  onSnooze(const Duration(minutes: 15));
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('30 minutes'),
                onTap: () {
                  onSnooze(const Duration(minutes: 30));
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('1 hour'),
                onTap: () {
                  onSnooze(const Duration(hours: 1));
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getTypeConfig(ReminderType type) {
    switch (type) {
      case ReminderType.medication:
        return {'icon': Icons.medication, 'color': Colors.purple};
      case ReminderType.vitals:
        return {'icon': Icons.monitor_heart, 'color': Colors.blue};
      case ReminderType.task:
        return {'icon': Icons.task_alt, 'color': Colors.orange};
      case ReminderType.followUp:
        return {'icon': Icons.follow_the_signs, 'color': Colors.teal};
      case ReminderType.handover:
        return {'icon': Icons.swap_horiz, 'color': Colors.indigo};
    }
  }
}
