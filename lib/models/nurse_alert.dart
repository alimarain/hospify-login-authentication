import 'package:flutter/material.dart';

enum AlertType { pre, onTime, post, admin }

enum AlertCategory { medication, vitals, care, documentation }

extension AlertTypeExtension on AlertType {
  String get value {
    switch (this) {
      case AlertType.pre:
        return 'pre';
      case AlertType.onTime:
        return 'on-time';
      case AlertType.post:
        return 'post';
      case AlertType.admin:
        return 'admin';
    }
  }

  static AlertType fromString(String value) {
    switch (value) {
      case 'pre':
        return AlertType.pre;
      case 'on-time':
        return AlertType.onTime;
      case 'post':
        return AlertType.post;
      case 'admin':
        return AlertType.admin;
      default:
        return AlertType.pre;
    }
  }

  String get label {
    switch (this) {
      case AlertType.pre:
        return 'Upcoming Task';
      case AlertType.onTime:
        return 'Task in Progress';
      case AlertType.post:
        return 'Overdue Task';
      case AlertType.admin:
        return 'Escalated Alert';
    }
  }

  Color get color {
    switch (this) {
      case AlertType.pre:
        return Colors.blue;
      case AlertType.onTime:
        return Colors.green;
      case AlertType.post:
        return Colors.orange;
      case AlertType.admin:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case AlertType.pre:
        return Icons.schedule;
      case AlertType.onTime:
        return Icons.check_circle;
      case AlertType.post:
        return Icons.warning_amber;
      case AlertType.admin:
        return Icons.shield;
    }
  }

  int get order {
    switch (this) {
      case AlertType.onTime:
        return 1;
      case AlertType.pre:
        return 2;
      case AlertType.post:
        return 3;
      case AlertType.admin:
        return 4;
    }
  }
}

extension AlertCategoryExtension on AlertCategory {
  String get value {
    switch (this) {
      case AlertCategory.medication:
        return 'medication';
      case AlertCategory.vitals:
        return 'vitals';
      case AlertCategory.care:
        return 'care';
      case AlertCategory.documentation:
        return 'documentation';
    }
  }

  static AlertCategory fromString(String value) {
    switch (value) {
      case 'medication':
        return AlertCategory.medication;
      case 'vitals':
        return AlertCategory.vitals;
      case 'care':
        return AlertCategory.care;
      case 'documentation':
        return AlertCategory.documentation;
      default:
        return AlertCategory.care;
    }
  }

  String get label {
    switch (this) {
      case AlertCategory.medication:
        return 'Medication';
      case AlertCategory.vitals:
        return 'Vitals';
      case AlertCategory.care:
        return 'Patient Care';
      case AlertCategory.documentation:
        return 'Documentation';
    }
  }

  IconData get icon {
    switch (this) {
      case AlertCategory.medication:
        return Icons.medication;
      case AlertCategory.vitals:
        return Icons.monitor_heart;
      case AlertCategory.care:
        return Icons.medical_services;
      case AlertCategory.documentation:
        return Icons.description;
    }
  }

  Color get color {
    switch (this) {
      case AlertCategory.medication:
        return Colors.purple;
      case AlertCategory.vitals:
        return Colors.blue;
      case AlertCategory.care:
        return Colors.green;
      case AlertCategory.documentation:
        return Colors.orange;
    }
  }
}

class NurseAlert {
  final String id;
  final AlertType type;
  final String title;
  final String message;
  final String patient;
  final String room;
  final String time;
  final AlertCategory category;
  final bool isRead;
  final bool triggered;
  final String? nurseId;
  final DateTime createdAt;

  NurseAlert({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.patient,
    required this.room,
    required this.time,
    required this.category,
    this.isRead = false,
    this.triggered = false,
    this.nurseId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NurseAlert.fromJson(Map<String, dynamic> json) {
    return NurseAlert(
      id: json['id'] as String,
      type: AlertTypeExtension.fromString(json['type'] as String),
      title: json['title'] as String,
      message: json['message'] as String,
      patient: json['patient'] as String,
      room: json['room'] as String,
      time: json['time'] as String,
      category: AlertCategoryExtension.fromString(json['category'] as String),
      isRead: json['is_read'] as bool? ?? false,
      triggered: json['triggered'] as bool? ?? false,
      nurseId: json['nurse_id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.value,
      'title': title,
      'message': message,
      'patient': patient,
      'room': room,
      'time': time,
      'category': category.value,
      'is_read': isRead,
      'triggered': triggered,
      'nurse_id': nurseId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  NurseAlert copyWith({
    String? id,
    AlertType? type,
    String? title,
    String? message,
    String? patient,
    String? room,
    String? time,
    AlertCategory? category,
    bool? isRead,
    bool? triggered,
    String? nurseId,
    DateTime? createdAt,
  }) {
    return NurseAlert(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      patient: patient ?? this.patient,
      room: room ?? this.room,
      time: time ?? this.time,
      category: category ?? this.category,
      isRead: isRead ?? this.isRead,
      triggered: triggered ?? this.triggered,
      nurseId: nurseId ?? this.nurseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
