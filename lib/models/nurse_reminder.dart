import 'package:flutter/material.dart';

enum ReminderType { medication, vitals, care, documentation, other }

enum ReminderStatus { pending, completed, snoozed, overdue }

enum ReminderPriority { low, medium, high, critical }

extension ReminderTypeExtension on ReminderType {
  String get value {
    switch (this) {
      case ReminderType.medication:
        return 'medication';
      case ReminderType.vitals:
        return 'vitals';
      case ReminderType.care:
        return 'care';
      case ReminderType.documentation:
        return 'documentation';
      case ReminderType.other:
        return 'other';
    }
  }

  static ReminderType fromString(String value) {
    switch (value) {
      case 'medication':
        return ReminderType.medication;
      case 'vitals':
        return ReminderType.vitals;
      case 'care':
        return ReminderType.care;
      case 'documentation':
        return ReminderType.documentation;
      default:
        return ReminderType.other;
    }
  }

  IconData get icon {
    switch (this) {
      case ReminderType.medication:
        return Icons.medication;
      case ReminderType.vitals:
        return Icons.monitor_heart;
      case ReminderType.care:
        return Icons.medical_services;
      case ReminderType.documentation:
        return Icons.description;
      case ReminderType.other:
        return Icons.task;
    }
  }

  Color get color {
    switch (this) {
      case ReminderType.medication:
        return Colors.purple;
      case ReminderType.vitals:
        return Colors.blue;
      case ReminderType.care:
        return Colors.green;
      case ReminderType.documentation:
        return Colors.orange;
      case ReminderType.other:
        return Colors.grey;
    }
  }
}

extension ReminderStatusExtension on ReminderStatus {
  String get value {
    switch (this) {
      case ReminderStatus.pending:
        return 'pending';
      case ReminderStatus.completed:
        return 'completed';
      case ReminderStatus.snoozed:
        return 'snoozed';
      case ReminderStatus.overdue:
        return 'overdue';
    }
  }

  static ReminderStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return ReminderStatus.pending;
      case 'completed':
        return ReminderStatus.completed;
      case 'snoozed':
        return ReminderStatus.snoozed;
      case 'overdue':
        return ReminderStatus.overdue;
      default:
        return ReminderStatus.pending;
    }
  }
}

extension ReminderPriorityExtension on ReminderPriority {
  String get value {
    switch (this) {
      case ReminderPriority.low:
        return 'low';
      case ReminderPriority.medium:
        return 'medium';
      case ReminderPriority.high:
        return 'high';
      case ReminderPriority.critical:
        return 'critical';
    }
  }

  static ReminderPriority fromString(String value) {
    switch (value) {
      case 'low':
        return ReminderPriority.low;
      case 'medium':
        return ReminderPriority.medium;
      case 'high':
        return ReminderPriority.high;
      case 'critical':
        return ReminderPriority.critical;
      default:
        return ReminderPriority.medium;
    }
  }

  Color get color {
    switch (this) {
      case ReminderPriority.low:
        return Colors.green;
      case ReminderPriority.medium:
        return Colors.orange;
      case ReminderPriority.high:
        return Colors.red;
      case ReminderPriority.critical:
        return Colors.red.shade900;
    }
  }
}

class NurseReminder {
  final String id;
  final String title;
  final String? description;
  final String patient;
  final String room;
  final DateTime dueAt;
  final ReminderType type;
  final ReminderStatus status;
  final ReminderPriority priority;
  final String? nurseId;
  final DateTime createdAt;

  NurseReminder({
    required this.id,
    required this.title,
    this.description,
    required this.patient,
    required this.room,
    required this.dueAt,
    required this.type,
    this.status = ReminderStatus.pending,
    this.priority = ReminderPriority.medium,
    this.nurseId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NurseReminder.fromJson(Map<String, dynamic> json) {
    return NurseReminder(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      patient: json['patient'] as String,
      room: json['room'] as String,
      dueAt: DateTime.parse(json['due_at'] as String),
      type: ReminderTypeExtension.fromString(json['type'] as String),
      status: ReminderStatusExtension.fromString(
          json['status'] as String? ?? 'pending'),
      priority: ReminderPriorityExtension.fromString(
          json['priority'] as String? ?? 'medium'),
      nurseId: json['nurse_id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'patient': patient,
      'room': room,
      'due_at': dueAt.toIso8601String(),
      'type': type.value,
      'status': status.value,
      'priority': priority.value,
      'nurse_id': nurseId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  NurseReminder copyWith({
    String? id,
    String? title,
    String? description,
    String? patient,
    String? room,
    DateTime? dueAt,
    ReminderType? type,
    ReminderStatus? status,
    ReminderPriority? priority,
    String? nurseId,
    DateTime? createdAt,
  }) {
    return NurseReminder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      patient: patient ?? this.patient,
      room: room ?? this.room,
      dueAt: dueAt ?? this.dueAt,
      type: type ?? this.type,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      nurseId: nurseId ?? this.nurseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isOverdue =>
      dueAt.isBefore(DateTime.now()) && status == ReminderStatus.pending;

  String get timeUntilDue {
    final now = DateTime.now();
    final diff = dueAt.difference(now);
    if (diff.isNegative) {
      return '${diff.inMinutes.abs()} min overdue';
    } else if (diff.inHours > 0) {
      return 'Due in ${diff.inHours}h ${diff.inMinutes % 60}m';
    } else {
      return 'Due in ${diff.inMinutes}m';
    }
  }
}
