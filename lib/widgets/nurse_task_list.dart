import 'package:flutter/material.dart';

class NurseTaskList extends StatelessWidget {
  final String filterCategory;

  const NurseTaskList({
    super.key,
    required this.filterCategory,
  });

  @override
  Widget build(BuildContext context) {
    final tasks = _mockTasks
        .where((task) =>
            filterCategory == 'all' || task.category == filterCategory)
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F14),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          if (tasks.isEmpty)
            _buildEmptyState()
          else
            Column(
              children: tasks
                  .map((task) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _TaskTile(task: task),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Today’s Tasks',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Sorted by priority',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: const [
          Icon(Icons.task_alt, color: Color(0xFF374151), size: 48),
          SizedBox(height: 12),
          Text(
            'No tasks for this category',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// TASK TILE
/// ---------------------------------------------------------------------------
class _TaskTile extends StatelessWidget {
  final _NurseTask task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _statusColor(task.status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Priority Indicator
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _categoryIcon(task.category),
                      size: 16,
                      color: const Color(0xFF9CA3AF),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      task.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  task.subtitle,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildTag(task.category),
                    const SizedBox(width: 8),
                    _buildTimeTag(task.time, task.status),
                  ],
                ),
              ],
            ),
          ),

          // Action
          Icon(
            Icons.chevron_right,
            color: const Color(0xFF374151),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label[0].toUpperCase() + label.substring(1),
        style: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildTimeTag(String time, _TaskStatus status) {
    final color = _statusColor(status);
    return Row(
      children: [
        Icon(Icons.access_time, size: 12, color: color),
        const SizedBox(width: 4),
        Text(
          time,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Color _statusColor(_TaskStatus status) {
    switch (status) {
      case _TaskStatus.urgent:
        return const Color(0xFFEF4444);
      case _TaskStatus.dueSoon:
        return const Color(0xFFFBBF24);
      case _TaskStatus.normal:
        return const Color(0xFF10B981);
    }
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'medication':
        return Icons.medication;
      case 'vitals':
        return Icons.monitor_heart;
      case 'care':
        return Icons.volunteer_activism;
      case 'documentation':
        return Icons.description;
      default:
        return Icons.task_alt;
    }
  }
}

/// ---------------------------------------------------------------------------
/// MOCK DATA MODEL (Replace later with Provider / Supabase)
/// ---------------------------------------------------------------------------
enum _TaskStatus { urgent, dueSoon, normal }

class _NurseTask {
  final String title;
  final String subtitle;
  final String category;
  final String time;
  final _TaskStatus status;

  _NurseTask({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.time,
    required this.status,
  });
}

final List<_NurseTask> _mockTasks = [
  _NurseTask(
    title: 'Administer Insulin',
    subtitle: 'Room 204 • Patient: Ahmed Raza',
    category: 'medication',
    time: 'Due in 15 min',
    status: _TaskStatus.urgent,
  ),
  _NurseTask(
    title: 'Record Blood Pressure',
    subtitle: 'Room 310 • Patient: Fatima Noor',
    category: 'vitals',
    time: 'Due in 30 min',
    status: _TaskStatus.dueSoon,
  ),
  _NurseTask(
    title: 'Post-Op Wound Care',
    subtitle: 'Room 118 • Patient: Ali Hassan',
    category: 'care',
    time: 'Scheduled',
    status: _TaskStatus.normal,
  ),
  _NurseTask(
    title: 'Update Medical Notes',
    subtitle: 'Room 405 • Patient: Sarah Khan',
    category: 'documentation',
    time: 'Before shift end',
    status: _TaskStatus.normal,
  ),
];
