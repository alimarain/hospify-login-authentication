import 'package:flutter/material.dart';

enum ShiftType { morning, afternoon, night }

enum ShiftStatus { scheduled, inProgress, completed, cancelled }

class Shift {
  final String id;
  final String staffId;
  final String staffName;
  final String role;
  final String department;
  final DateTime date;
  final ShiftType type;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final ShiftStatus status;
  final String? notes;

  Shift({
    required this.id,
    required this.staffId,
    required this.staffName,
    required this.role,
    required this.department,
    required this.date,
    required this.type,
    required this.startTime,
    required this.endTime,
    this.status = ShiftStatus.scheduled,
    this.notes,
  });

  Shift copyWith({
    String? id,
    String? staffId,
    String? staffName,
    String? role,
    String? department,
    DateTime? date,
    ShiftType? type,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    ShiftStatus? status,
    String? notes,
  }) {
    return Shift(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      role: role ?? this.role,
      department: department ?? this.department,
      date: date ?? this.date,
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  String get shiftTypeLabel {
    switch (type) {
      case ShiftType.morning:
        return 'Morning';
      case ShiftType.afternoon:
        return 'Afternoon';
      case ShiftType.night:
        return 'Night';
    }
  }

  Color get shiftColor {
    switch (type) {
      case ShiftType.morning:
        return Colors.orange;
      case ShiftType.afternoon:
        return Colors.blue;
      case ShiftType.night:
        return Colors.indigo;
    }
  }

  String get timeRange {
    String formatTime(TimeOfDay time) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
    }

    return '${formatTime(startTime)} - ${formatTime(endTime)}';
  }
}
