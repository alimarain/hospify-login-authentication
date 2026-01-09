// import 'package:flutter/material.dart';

// // --- Shared / Admin Models ---
// class SummaryCardData {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color? iconColor; // Added for Doctor view specific colors
//   SummaryCardData(this.title, this.value, this.icon, {this.iconColor});
// }

// class DepartmentData {
//   final String name;
//   final int patients;
//   final int staff;
//   final double percentage;
//   final Color color;
//   DepartmentData(
//       this.name, this.patients, this.staff, this.percentage, this.color);
// }

// class ActivityItem {
//   final String description;
//   final String timeAgo;
//   final Color color;
//   ActivityItem(this.description, this.timeAgo, this.color);
// }

// enum TaskSeverity { critical, high, medium }

// // ✅ ADDED: This class was missing and causing your error
// class TaskItem {
//   final String title;
//   final TaskSeverity severity;
//   final String patientName;
//   final String room;
//   final String originalTime;
//   final int overdueMinutes;
//   final String assignedTo;
//   final String reportedTo;

//   TaskItem({
//     required this.title,
//     required this.severity,
//     required this.patientName,
//     required this.room,
//     required this.originalTime,
//     required this.overdueMinutes,
//     required this.assignedTo,
//     required this.reportedTo,
//   });
// }

// // Keeping AdminTaskItem in case you use it elsewhere,
// // but TaskItem above handles the widget you pasted.
// class AdminTaskItem {
//   final String title;
//   final TaskSeverity severity;
//   final String patientName;
//   final String room;
//   final String originalTime;
//   final int overdueMinutes;
//   final String assignedTo;
//   final String reportedTo;
//   AdminTaskItem({
//     required this.title,
//     required this.severity,
//     required this.patientName,
//     required this.room,
//     required this.originalTime,
//     required this.overdueMinutes,
//     required this.assignedTo,
//     required this.reportedTo,
//   });
// }

// class ChartDataPoint {
//   final int x;
//   final double patients;
//   final double appointments;
//   ChartDataPoint(this.x, this.patients, this.appointments);
// }

// // --- Doctor View Models ---
// class AppointmentItem {
//   final String name;
//   final String type;
//   final String time;
//   final String duration;
//   AppointmentItem(this.name, this.type, this.time, this.duration);
// }

// class DoctorTaskItem {
//   final String id;
//   final String title;
//   final String time;
//   final String priority; // 'high', 'medium', 'low'
//   final bool isCompleted;
//   DoctorTaskItem(
//       this.id, this.title, this.time, this.priority, this.isCompleted);
// }

// class WardSummaryItem {
//   final String name;
//   final int count;
//   final int criticalCount;
//   final Color color;
//   WardSummaryItem(this.name, this.count, this.criticalCount, this.color);

//   get totalPatients => null;
// }

// models/dashboard_models.dart
import 'package:flutter/material.dart';

// Model for Escalated Tasks
class EscalatedTask {
  final String title;
  final String priority; // CRITICAL, HIGH, MEDIUM
  final String staffName;
  final String room;
  final String originalTime;
  final String overdueTime;
  final String assignedTo;
  final String escalationTarget; // e.g., "Admin", "Supervisor"

  EscalatedTask({
    required this.title,
    required this.priority,
    required this.staffName,
    required this.room,
    required this.originalTime,
    required this.overdueTime,
    required this.assignedTo,
    required this.escalationTarget,
  });
}

// Model for Completed Tasks (From your image)
class CompletedTask {
  final String title;
  final String tag;
  final String user;
  final String patient;
  final String room;
  final String date;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  CompletedTask({
    required this.title,
    required this.tag,
    required this.user,
    required this.patient,
    required this.room,
    required this.date,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}

class DashboardStat {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  DashboardStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class Department {
  final String name;
  final int patients;
  final int staff;
  final int occupancy; // in percent

  Department({
    required this.name,
    required this.patients,
    required this.staff,
    required this.occupancy,
  });
}

class Bed {
  final String ward;
  final int total;
  final int occupied;

  Bed({required this.ward, required this.total, required this.occupied});
}
