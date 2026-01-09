// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/dashboard_models.dart';
// import '../theme/app_theme.dart';

// // Navigation State: 0 = Admin Dashboard, 1 = Doctor Dashboard
// final selectedNavItemProvider = StateProvider<int>((ref) => 0);

// // --- Admin Dashboard Data ---
// final adminSummaryProvider = Provider<List<SummaryCardData>>((ref) => [
//       SummaryCardData("Total Patients", "352", Icons.people),
//       SummaryCardData("Total Staff", "156", Icons.business),
//       SummaryCardData("Available Beds", "42", Icons.bed),
//       SummaryCardData("Appointments Today", "78", Icons.calendar_today),
//     ]);

// final departmentDataProvider = Provider<List<DepartmentData>>((ref) => [
//       DepartmentData("Emergency", 24, 18, 0.85, AppColors.orangeAccent),
//       DepartmentData("ICU", 12, 24, 0.92, AppColors.redAccent),
//       DepartmentData("General Ward", 45, 32, 0.75, AppColors.orangeAccent),
//       DepartmentData("Pediatrics", 18, 14, 0.60, AppColors.secondaryAccent),
//       DepartmentData("Cardiology", 15, 12, 0.78, AppColors.orangeAccent),
//     ]);

// final recentActivityProvider = Provider<List<ActivityItem>>((ref) => [
//       ActivityItem(
//           "New patient admitted to Emergency", "2 min ago", Colors.blue),
//       ActivityItem(
//           "Dr. Ahmed completed surgery in OR-2", "15 min ago", Colors.purple),
//       ActivityItem(
//           "Patient discharged from General Ward", "30 min ago", Colors.green),
//       ActivityItem(
//           "Equipment maintenance completed", "2 hours ago", Colors.grey),
//     ]);

// final escalatedTasksProvider = Provider<List<AdminTaskItem>>((ref) => [
//       AdminTaskItem(
//           title: "Wound Dressing Change",
//           severity: TaskSeverity.critical,
//           patientName: "Hassan Malik",
//           room: "210",
//           originalTime: "10:30 AM",
//           overdueMinutes: 45,
//           assignedTo: "Nurse Maria",
//           reportedTo: "Admin"),
//       AdminTaskItem(
//           title: "Medication Admin",
//           severity: TaskSeverity.high,
//           patientName: "Zainab Hussain",
//           room: "212",
//           originalTime: "11:00 AM",
//           overdueMinutes: 30,
//           assignedTo: "Nurse John",
//           reportedTo: "Supervisor"),
//       AdminTaskItem(
//           title: "Vital Signs Check",
//           severity: TaskSeverity.medium,
//           patientName: "Ahmed Khan",
//           room: "204",
//           originalTime: "11:15 AM",
//           overdueMinutes: 20,
//           assignedTo: "Nurse Sarah",
//           reportedTo: "Charge Nurse"),
//     ]);

// final monthlyTrendProvider = Provider<List<ChartDataPoint>>((ref) => [
//       ChartDataPoint(0, 170, 210),
//       ChartDataPoint(1, 190, 230),
//       ChartDataPoint(2, 200, 250),
//       ChartDataPoint(3, 220, 270),
//       ChartDataPoint(4, 240, 300),
//       ChartDataPoint(5, 250, 320),
//     ]);

// // --- Doctor Dashboard Data ---
// final doctorSummaryProvider = Provider<List<SummaryCardData>>((ref) => [
//       SummaryCardData("Total patients", "352", Icons.people_outline,
//           iconColor: Colors.grey),
//       SummaryCardData("Mild patients", "180", Icons.favorite_border,
//           iconColor: Colors.blue),
//       SummaryCardData("Stable patients", "150", Icons.monitor_heart_outlined,
//           iconColor: Colors.green),
//       SummaryCardData("Critical patients", "22", Icons.warning_amber_rounded,
//           iconColor: Colors.red),
//     ]);

// final wardSummaryProvider = Provider<List<WardSummaryItem>>((ref) => [
//       WardSummaryItem("General", 6, 0, Colors.blue),
//       WardSummaryItem("ICU", 2, 2, Colors.redAccent),
//       WardSummaryItem("Emergency", 1, 0, Colors.orange),
//       WardSummaryItem("Pediatrics", 2, 0, Colors.pinkAccent),
//       WardSummaryItem("Cardiology", 2, 1, Colors.purple),
//       WardSummaryItem("Orthopedics", 2, 0, Colors.teal),
//     ]);

// final appointmentsProvider = Provider<List<AppointmentItem>>((ref) => [
//       AppointmentItem(
//           "Muhammad Ali Khan", "Follow-up checkup", "09:00 AM", "30 min"),
//       AppointmentItem("Fatima Zahra", "Consultation", "10:30 AM", "45 min"),
//       AppointmentItem(
//           "Ahmed Raza", "Blood pressure monitoring", "02:00 PM", "30 min"),
//     ]);

// class DoctorTasksNotifier extends StateNotifier<List<DoctorTaskItem>> {
//   DoctorTasksNotifier()
//       : super([
//           // Pending Tasks
//           DoctorTaskItem("1", "Call Mariam Sheikh about test results",
//               "10:30 AM", "high", false),
//           DoctorTaskItem("2", "Review Bilal Ahmed's MRI scan", "11:00 AM",
//               "medium", false),
//           DoctorTaskItem("3", "Follow up with Zainab Noor prescription",
//               "2:00 PM", "low", false),
//           DoctorTaskItem("4", "Prepare discharge summary for Room 205",
//               "3:30 PM", "medium", false),

//           // Completed Task (Added to match your UI)
//           DoctorTaskItem("5", "Review lab results for new admissions",
//               "09:00 AM", "medium", true),
//         ]);

//   void toggleTask(String id) {
//     state = [
//       for (final t in state)
//         if (t.id == id)
//           DoctorTaskItem(t.id, t.title, t.time, t.priority, !t.isCompleted)
//         else
//           t
//     ];
//   }
// }

// final doctorTasksProvider =
//     StateNotifierProvider<DoctorTasksNotifier, List<DoctorTaskItem>>(
//         (ref) => DoctorTasksNotifier());

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// /// Tracks the currently selected sidebar item
// final selectedNavItemProvider = StateProvider<int>((ref) => 0);

// /// Optional: tracks filters for departments (like ICU, Emergency, etc.)
// final departmentFilterProvider = StateProvider<String?>((ref) => null);

// /// Optional: tracks which stat card is highlighted
// final selectedStatCardProvider = StateProvider<int>((ref) => -1);

// providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dashboard_models.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// Stats Provider
final statsProvider = Provider<List<DashboardStat>>((ref) {
  return [
    DashboardStat(
      title: 'Total Patients',
      value: '352',
      icon: Icons.people,
      color: Colors.blue,
    ),
    DashboardStat(
      title: 'Total Staff',
      value: '156',
      icon: Icons.apartment,
      color: Colors.green,
    ),
    DashboardStat(
      title: 'Available Beds',
      value: '42',
      icon: Icons.bed,
      color: Colors.amber,
    ),
    DashboardStat(
      title: 'Appointments Today',
      value: '78',
      icon: Icons.calendar_today,
      color: Colors.purple,
    ),
  ];
});

// Departments Provider
final departmentsProvider = Provider<List<Department>>((ref) {
  return [
    Department(name: 'Emergency', patients: 24, staff: 18, occupancy: 85),
    Department(name: 'ICU', patients: 12, staff: 24, occupancy: 92),
    Department(name: 'General Ward', patients: 45, staff: 32, occupancy: 75),
    Department(name: 'Pediatrics', patients: 18, staff: 14, occupancy: 60),
    Department(name: 'Cardiology', patients: 15, staff: 12, occupancy: 78),
  ];
});

// Beds Provider
final bedsProvider = Provider<List<Bed>>((ref) {
  return [
    Bed(ward: 'ICU', total: 20, occupied: 18),
    Bed(ward: 'Emergency', total: 30, occupied: 25),
    Bed(ward: 'General Ward A', total: 50, occupied: 38),
    Bed(ward: 'General Ward B', total: 50, occupied: 42),
    Bed(ward: 'Pediatrics', total: 25, occupied: 15),
    Bed(ward: 'Maternity', total: 20, occupied: 15),
  ];
});
