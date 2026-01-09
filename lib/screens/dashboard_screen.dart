// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/patients_provider.dart';
// import '../providers/task_completions_provider.dart';
// import '../theme/app_theme.dart';
// import '../widgets/stats_card.dart';
// import '../widgets/task_completion_item.dart';
// import '../models/task_completion.dart';

// class DashboardScreen extends ConsumerStatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends ConsumerState<DashboardScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Load sample task completions
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(taskCompletionsProvider.notifier).setCompletions([
//         TaskCompletion(
//           id: '1',
//           task: 'Administered medication',
//           completedBy: 'Nurse Sarah',
//           role: 'Nurse',
//           patient: 'Muhammad Ali',
//           room: 'G-101',
//           category: 'Medication',
//           completedAt: DateTime.now().subtract(const Duration(minutes: 5)),
//         ),
//         TaskCompletion(
//           id: '2',
//           task: 'Vital signs check',
//           completedBy: 'Dr. Ahmed',
//           role: 'Doctor',
//           patient: 'Fatima Zahra',
//           room: 'ICU-05',
//           category: 'Checkup',
//           completedAt: DateTime.now().subtract(const Duration(minutes: 15)),
//         ),
//         TaskCompletion(
//           id: '3',
//           task: 'IV drip replacement',
//           completedBy: 'Nurse Ayesha',
//           role: 'Nurse',
//           patient: 'Imran Hussain',
//           room: 'ICU-02',
//           category: 'Treatment',
//           completedAt: DateTime.now().subtract(const Duration(minutes: 30)),
//         ),
//       ]);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final stats = ref.watch(patientStatsProvider);
//     final completions = ref.watch(taskCompletionsProvider);

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Dashboard',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: AppTheme.textPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Welcome back! Here\'s your hospital overview.',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: AppTheme.textSecondary,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: Badge(
//                       label: const Text('3'),
//                       child: Icon(Icons.notifications_outlined,
//                           color: AppTheme.textSecondary),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundColor: AppTheme.primary,
//                     child:
//                         const Text('AD', style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // Stats Cards
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final crossAxisCount = constraints.maxWidth > 1000 ? 4 : 2;
//               return GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: crossAxisCount,
//                 childAspectRatio: 1.8,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 children: [
//                   StatsCard(
//                     title: 'Total Patients',
//                     value: '${stats.total}',
//                     icon: Icons.people,
//                     color: AppTheme.primary,
//                     subtitle: 'Active admissions',
//                   ),
//                   StatsCard(
//                     title: 'Mild Cases',
//                     value: '${stats.mild}',
//                     icon: Icons.health_and_safety,
//                     color: AppTheme.statusMild,
//                     subtitle: 'Stable condition',
//                   ),
//                   StatsCard(
//                     title: 'Stable Cases',
//                     value: '${stats.stable}',
//                     icon: Icons.monitor_heart,
//                     color: AppTheme.statusStable,
//                     subtitle: 'Under observation',
//                   ),
//                   StatsCard(
//                     title: 'Critical Cases',
//                     value: '${stats.critical}',
//                     icon: Icons.warning,
//                     color: AppTheme.statusCritical,
//                     subtitle: 'Immediate attention',
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 32),

//           // Task Completions Log
//           Text(
//             'Recent Task Completions',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: AppTheme.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 16),
//           if (completions.isEmpty)
//             Container(
//               padding: const EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 color: AppTheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppTheme.border),
//               ),
//               child: Center(
//                 child: Text(
//                   'No task completions yet',
//                   style: TextStyle(color: AppTheme.textMuted),
//                 ),
//               ),
//             )
//           else
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: completions.length,
//               itemBuilder: (context, index) {
//                 return TaskCompletionItem(completion: completions[index]);
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import 'package:hospify/widgets/summary_cards.dart';
// import '../widgets/dashboard_header.dart';
// import '../widgets/department_activity_section.dart';
// import '../widgets/escalated_tasks_widget.dart';
// import '../widgets/monthly_trend_chart.dart';
// import '../widgets/bed_availability_widget.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const DashboardHeader(),
//           const SizedBox(height: 24),
//           const SummaryCards(),
//           const SizedBox(height: 24),

//           // Row containing Chart and Activity on Desktop
//           Responsive(
//             mobile: const Column(
//               children: [
//                 MonthlyTrendChart(),
//                 SizedBox(height: 24),
//                 DepartmentActivitySection(),
//               ],
//             ),
//             desktop: const Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(flex: 2, child: MonthlyTrendChart()),
//                 SizedBox(width: 24),
//                 Expanded(flex: 1, child: DepartmentActivitySection()),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),
//           const EscalatedTasksWidget(), // From the previous response
//           const SizedBox(height: 24),
//           const BedAvailabilityWidget(),
//           const SizedBox(height: 40), // Bottom padding
//         ],
//       ),
//     );
//   }
// }
//-------------------------------------------------------------latest---------------------------//

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import 'package:hospify/widgets/summary_cards.dart';
// import '../widgets/monthly_trend_chart.dart';
// import '../widgets/admin_tasks_widget.dart';
// import '../providers/dashboard_providers.dart';

// class DashboardScreen extends ConsumerWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SingleChildScrollView(
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         const Text("Hospital Dashboard",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//         const Text("Overview of hospital operations",
//             style: TextStyle(color: Colors.grey)),
//         const SizedBox(height: 24),
//         SummaryCards(data: ref.watch(adminSummaryProvider)),
//         const SizedBox(height: 24),
//         Responsive(
//           mobile: const Column(children: [
//             MonthlyTrendChart(),
//             SizedBox(height: 24),
//             AdminTasksWidget()
//           ]),
//           desktop: const Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(flex: 2, child: MonthlyTrendChart()),
//                 SizedBox(width: 24),
//                 Expanded(flex: 1, child: AdminTasksWidget()),
//               ]),
//         )
//       ]),
//     );
//   }
// }
//---------------------------------------05-01-2025----------------------------------//

// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Hospital Dashboard',
//             style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Overview of hospital operations',
//             style: TextStyle(color: Colors.grey.shade600),
//           ),
//           const SizedBox(height: 24),
//           // Stats Grid
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
//               return GridView.count(
//                 crossAxisCount: crossAxisCount,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 1.4,
//                 children: const [
//                   _DashboardStatCard(
//                     title: 'Total Patients',
//                     value: '352',
//                     icon: Icons.people,
//                     color: Colors.blue,
//                   ),
//                   _DashboardStatCard(
//                     title: 'Total Staff',
//                     value: '156',
//                     icon: Icons.apartment,
//                     color: Colors.green,
//                   ),
//                   _DashboardStatCard(
//                     title: 'Available Beds',
//                     value: '42',
//                     icon: Icons.bed,
//                     color: Colors.amber,
//                   ),
//                   _DashboardStatCard(
//                     title: 'Appointments Today',
//                     value: '78',
//                     icon: Icons.calendar_today,
//                     color: Colors.purple,
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 24),
//           // Department Overview
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Department Overview',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                       Icon(Icons.trending_up, color: Colors.grey.shade400),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildDepartmentRow('Emergency', 24, 18, 85),
//                   _buildDepartmentRow('ICU', 12, 24, 92),
//                   _buildDepartmentRow('General Ward', 45, 32, 75),
//                   _buildDepartmentRow('Pediatrics', 18, 14, 60),
//                   _buildDepartmentRow('Cardiology', 15, 12, 78),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 24),
//           // Bed Availability
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.bed, color: Colors.grey.shade600),
//                       const SizedBox(width: 12),
//                       const Text(
//                         'Bed Availability',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       final crossAxisCount = constraints.maxWidth > 700 ? 3 : 2;
//                       return GridView.count(
//                         crossAxisCount: crossAxisCount,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         crossAxisSpacing: 12,
//                         mainAxisSpacing: 12,
//                         childAspectRatio: 2,
//                         children: const [
//                           _BedCard(ward: 'ICU', total: 20, occupied: 18),
//                           _BedCard(ward: 'Emergency', total: 30, occupied: 25),
//                           _BedCard(
//                               ward: 'General Ward A', total: 50, occupied: 38),
//                           _BedCard(
//                               ward: 'General Ward B', total: 50, occupied: 42),
//                           _BedCard(ward: 'Pediatrics', total: 25, occupied: 15),
//                           _BedCard(ward: 'Maternity', total: 20, occupied: 15),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDepartmentRow(
//       String name, int patients, int staff, int occupancy) {
//     Color color;
//     if (occupancy >= 90) {
//       color = AppTheme.statusCritical;
//     } else if (occupancy >= 75) {
//       color = Colors.amber;
//     } else {
//       color = AppTheme.statusStable;
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
//                 Text(
//                   '$patients patients • $staff staff',
//                   style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(4),
//               child: LinearProgressIndicator(
//                 value: occupancy / 100,
//                 backgroundColor: Colors.grey.shade200,
//                 valueColor: AlwaysStoppedAnimation(color),
//                 minHeight: 8,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           SizedBox(
//             width: 40,
//             child: Text(
//               '$occupancy%',
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DashboardStatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;

//   const _DashboardStatCard({
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(icon, color: color, size: 22),
//                 ),
//               ],
//             ),
//             Text(
//               value,
//               style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _BedCard extends StatelessWidget {
//   final String ward;
//   final int total;
//   final int occupied;

//   const _BedCard({
//     required this.ward,
//     required this.total,
//     required this.occupied,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final available = total - occupied;
//     final occupancyRate = (occupied / total * 100).round();

//     Color color;
//     if (occupancyRate >= 90) {
//       color = AppTheme.statusCritical;
//     } else if (occupancyRate >= 75) {
//       color = Colors.amber;
//     } else {
//       color = AppTheme.statusStable;
//     }

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   ward,
//                   style: const TextStyle(fontWeight: FontWeight.w500),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   '$occupancyRate%',
//                   style: TextStyle(
//                     color: color,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 '$available free',
//                 style: TextStyle(
//                   color: AppTheme.statusStable,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '$occupied used',
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
//               ),
//             ],
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: LinearProgressIndicator(
//               value: occupied / total,
//               backgroundColor: Colors.grey.shade200,
//               valueColor: AlwaysStoppedAnimation(color),
//               minHeight: 6,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//-----------------06-01-2025---------------------//

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// 1. Models
// ---------------------------------------------------------------------------

class ActivityItem {
  final String title;
  final String timestamp;
  final Color color;

  ActivityItem({
    required this.title,
    required this.timestamp,
    required this.color,
  });
}

class EscalatedTask {
  final String title;
  final String priority;
  final String patient;
  final String room;
  final String originalTime;
  final String overdueTime;
  final String assignedTo;
  final String escalatedTo;

  EscalatedTask({
    required this.title,
    required this.priority,
    required this.patient,
    required this.room,
    required this.originalTime,
    required this.overdueTime,
    required this.assignedTo,
    required this.escalatedTo,
  });
}

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

// New Model for Shifts
class StaffShift {
  final String role;
  final String time;
  final int dayIndex; // 0=Mon, 1=Tue...
  final Color color;
  final Color textColor;

  StaffShift({
    required this.role,
    required this.time,
    required this.dayIndex,
    required this.color,
    this.textColor = Colors.white,
  });
}

// ---------------------------------------------------------------------------
// 2. Main Dashboard Screen
// ---------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Data ---
    final recentActivities = [
      ActivityItem(
          title: "New patient admitted to Emergency",
          timestamp: "2 min ago",
          color: Colors.blue),
      ActivityItem(
          title: "Dr. Ahmed completed surgery in OR-2",
          timestamp: "15 min ago",
          color: Colors.purple),
      ActivityItem(
          title: "Patient discharged from General Ward",
          timestamp: "30 min ago",
          color: Colors.green),
    ];

    final escalatedTasks = [
      EscalatedTask(
        title: "Wound Dressing Change",
        priority: "CRITICAL",
        patient: "Hassan Malik",
        room: "Room 210",
        originalTime: "10:30 AM",
        overdueTime: "45 mins",
        assignedTo: "Nurse Maria",
        escalatedTo: "Admin",
      ),
      EscalatedTask(
        title: "Medication Administration",
        priority: "HIGH",
        patient: "Zainab Hussain",
        room: "Room 212",
        originalTime: "11:00 AM",
        overdueTime: "30 mins",
        assignedTo: "Nurse John",
        escalatedTo: "Supervisor",
      ),
      EscalatedTask(
        title: "Vital Signs Check",
        priority: "MEDIUM",
        patient: "Ahmed Khan",
        room: "Room 204",
        originalTime: "11:15 AM",
        overdueTime: "20 mins",
        assignedTo: "Nurse Sarah",
        escalatedTo: "Charge Nurse",
      ),
    ];

    final completedTasks = [
      CompletedTask(
        title: "Medication Administration",
        tag: "Medication",
        user: "Nurse John Smith",
        patient: "Ahmed Khan",
        room: "Room 204",
        date: "12/30/2025",
        time: "03:47 PM",
        icon: Icons.monitor_heart_outlined,
        iconColor: Colors.blueAccent,
        iconBgColor: Colors.blue.withOpacity(0.1),
      ),
      CompletedTask(
        title: "Post-Surgery Checkup",
        tag: "Surgery",
        user: "Dr. Ahmed Khan",
        patient: "Fatima Ali",
        room: "Room 207",
        date: "12/30/2025",
        time: "03:27 PM",
        icon: Icons.medical_services_outlined,
        iconColor: Colors.purpleAccent,
        iconBgColor: Colors.purple.withOpacity(0.1),
      ),
      CompletedTask(
        title: "Wound Dressing Change",
        tag: "Wound Care",
        user: "Nurse Sarah Lee",
        patient: "Omar Hassan",
        room: "Room 215",
        date: "12/30/2025",
        time: "03:00 PM",
        icon: Icons.healing_outlined,
        iconColor: Colors.orangeAccent,
        iconBgColor: Colors.orange.withOpacity(0.1),
      ),
      CompletedTask(
        title: "ECG Recording",
        tag: "Diagnostics",
        user: "Dr. Emily Chen",
        patient: "Aisha Rahman",
        room: "Room 203",
        date: "12/30/2025",
        time: "02:42 PM",
        icon: Icons.monitor_heart,
        iconColor: Colors.pinkAccent,
        iconBgColor: Colors.pink.withOpacity(0.1),
      ),
      CompletedTask(
        title: "IV Fluid Change",
        tag: "IV Care",
        user: "Nurse Maria Garcia",
        patient: "Khalid Mahmood",
        room: "Room 209",
        date: "12/30/2025",
        time: "02:12 PM",
        icon: Icons.water_drop_outlined,
        iconColor: Colors.blue,
        iconBgColor: Colors.blue.withOpacity(0.1),
      ),
    ];

    final shifts = [
      StaffShift(
          role: "Dr.",
          time: "08:00-16:00",
          dayIndex: 1,
          color: const Color(0xFF1E3A5F)),
      StaffShift(
          role: "Nurse",
          time: "07:00-15:00",
          dayIndex: 1,
          color: const Color(0xFF3E2723)),
      StaffShift(
          role: "Dr.",
          time: "09:00-17:00",
          dayIndex: 1,
          color: const Color(0xFF311B92)),
      StaffShift(
          role: "Nurse",
          time: "15:00-23:00",
          dayIndex: 2,
          color: const Color(0xFF4A3418)),
      StaffShift(
          role: "Dr.",
          time: "08:00-16:00",
          dayIndex: 2,
          color: const Color(0xFF1B5E20)),
      StaffShift(
          role: "Nurse",
          time: "23:00-07:00",
          dayIndex: 3,
          color: const Color(0xFF3E2723)),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hospital Dashboard',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Overview of hospital operations',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // --- Section 1: Top Stats Grid ---
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1100 ? 4 : 2;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.4,
                  children: const [
                    _DashboardStatCard(
                        title: 'Total Patients',
                        value: '352',
                        icon: Icons.people,
                        color: Colors.blue),
                    _DashboardStatCard(
                        title: 'Total Staff',
                        value: '156',
                        icon: Icons.apartment,
                        color: Colors.green),
                    _DashboardStatCard(
                        title: 'Available Beds',
                        value: '42',
                        icon: Icons.bed,
                        color: Colors.amber),
                    _DashboardStatCard(
                        title: 'Appointments Today',
                        value: '78',
                        icon: Icons.calendar_today,
                        color: Colors.purple),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // --- Section 2: Split View (Departments + Recent Activity) ---
            LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _DepartmentOverviewCard()),
                    const SizedBox(width: 24),
                    Expanded(
                        flex: 1,
                        child:
                            _RecentActivityCard(activities: recentActivities)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _DepartmentOverviewCard(),
                    const SizedBox(height: 24),
                    _RecentActivityCard(activities: recentActivities),
                  ],
                );
              }
            }),

            const SizedBox(height: 24),

            // --- Section 3: Escalated Tasks ---
            _EscalatedTasksSection(tasks: escalatedTasks),

            const SizedBox(height: 24),

            // --- Section 4: Task Completions ---
            _TaskCompletionsSection(tasks: completedTasks),

            const SizedBox(height: 24),

            // --- Section 5: Shift Scheduling (NEW ADDITION) ---
            _ShiftSchedulingSection(shifts: shifts),

            const SizedBox(height: 24),

            // --- Section 6: Bed Availability ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bed, color: Colors.grey.shade600),
                        const SizedBox(width: 12),
                        const Text(
                          'Bed Availability',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount =
                            constraints.maxWidth > 700 ? 3 : 2;
                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2,
                          children: const [
                            _BedCard(ward: 'ICU', total: 20, occupied: 18),
                            _BedCard(
                                ward: 'Emergency', total: 30, occupied: 25),
                            _BedCard(
                                ward: 'General Ward A',
                                total: 50,
                                occupied: 38),
                            _BedCard(
                                ward: 'General Ward B',
                                total: 50,
                                occupied: 42),
                            _BedCard(
                                ward: 'Pediatrics', total: 25, occupied: 15),
                            _BedCard(
                                ward: 'Maternity', total: 20, occupied: 15),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Helper Widgets
// ---------------------------------------------------------------------------

// --- NEW: Shift Scheduling Section (Fixed Layout) ---
class _ShiftSchedulingSection extends StatelessWidget {
  final List<StaffShift> shifts;

  const _ShiftSchedulingSection({required this.shifts});

  @override
  Widget build(BuildContext context) {
    // Days config
    final List<Map<String, dynamic>> days = [
      {'day': 'Mon', 'date': '5'},
      {'day': 'Tue', 'date': '6'},
      {'day': 'Wed', 'date': '7'},
      {'day': 'Thu', 'date': '8'},
      {'day': 'Fri', 'date': '9'},
      {'day': 'Sat', 'date': '10'},
      {'day': 'Sun', 'date': '11'},
    ];

    return Card(
      color: const Color(0xFF111111),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.calendar_month_outlined,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Shift Scheduling",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Manage staff shifts and schedules",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (MediaQuery.of(context).size.width > 700) ...[
                  _buildNavButton(Icons.chevron_left),
                  const SizedBox(width: 12),
                  const Text("Jan 5 - Jan 11, 2026",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  _buildNavButton(Icons.chevron_right),
                  const SizedBox(width: 24),
                ],
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C2C2C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Add Shift"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Horizontal Scroll Calendar
            // FIX: Uses Fixed Width Containers instead of Expanded to avoid layout errors
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(days.length, (index) {
                  final dayData = days[index];
                  final dayShifts =
                      shifts.where((s) => s.dayIndex == index).toList();

                  return Container(
                    width: 150, // Fixed width prevents crash
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161616),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          dayData['day'],
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dayData['date'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        if (dayShifts.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                              "No shifts",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                          )
                        else
                          ...dayShifts.map((shift) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: _buildShiftCard(shift),
                              )),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(color: Color(0xFF333333)),
            const SizedBox(height: 16),

            // Legend
            Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("Departments:",
                    style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                _buildLegendItem("Cardiology", const Color(0xFF1E3A5F)),
                _buildLegendItem("ICU", const Color(0xFF3E2723)),
                _buildLegendItem("Surgery", const Color(0xFF311B92)),
                _buildLegendItem("Emergency", const Color(0xFF4A3418)),
                _buildLegendItem("Pediatrics", const Color(0xFF1B5E20)),
                _buildLegendItem("General Ward", Colors.grey[800]!),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }

  Widget _buildShiftCard(StaffShift shift) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: shift.color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, size: 14, color: shift.textColor),
              const SizedBox(width: 4),
              Text(
                shift.role,
                style: TextStyle(
                    color: shift.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time,
                  size: 12, color: shift.textColor.withOpacity(0.7)),
              const SizedBox(width: 4),
              Text(
                shift.time,
                style: TextStyle(
                    color: shift.textColor.withOpacity(0.7), fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
      ],
    );
  }
}

// --- Task Completions Section ---
class _TaskCompletionsSection extends StatelessWidget {
  final List<CompletedTask> tasks;

  const _TaskCompletionsSection({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF111111),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_outline,
                      color: Colors.green, size: 20),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Task Completions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Live updates • Recent completed tasks",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (MediaQuery.of(context).size.width > 600) ...[
                  _buildHeaderChip(
                    label: "Live",
                    textColor: Colors.greenAccent,
                    dotColor: Colors.greenAccent,
                    bgColor: Colors.green.withOpacity(0.1),
                  ),
                  const SizedBox(width: 8),
                  _buildHeaderChip(
                    label: "4 Nurse",
                    textColor: Colors.blueAccent,
                    icon: Icons.favorite,
                    bgColor: Colors.blue.withOpacity(0.1),
                  ),
                  const SizedBox(width: 8),
                  _buildHeaderChip(
                    label: "4 Doctor",
                    textColor: Colors.purpleAccent,
                    icon: Icons.medical_services,
                    bgColor: Colors.purple.withOpacity(0.1),
                  ),
                ]
              ],
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildTaskRow(tasks[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderChip({
    required String label,
    required Color textColor,
    Color? dotColor,
    IconData? icon,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null)
            Container(
              margin: const EdgeInsets.only(right: 6),
              width: 6,
              height: 6,
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(icon, color: textColor, size: 14),
            ),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskRow(CompletedTask task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: task.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(task.icon, color: task.iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        task.tag,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.person_outline,
                        size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        "${task.user} • ${task.patient} (${task.room})",
                        style: TextStyle(color: Colors.grey[400], fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: Colors.greenAccent, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    task.date,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                task.time,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// --- Escalated Tasks Component ---
class _EscalatedTasksSection extends StatelessWidget {
  final List<EscalatedTask> tasks;

  const _EscalatedTasksSection({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.warning_amber_rounded,
                      color: Colors.red),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Escalated Tasks",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Overdue tasks requiring attention",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${tasks.length} Overdue",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                const Text("View All >",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildTaskItem(tasks[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(EscalatedTask task) {
    Color statusColor;
    if (task.priority == 'CRITICAL') {
      statusColor = Colors.redAccent;
    } else if (task.priority == 'HIGH') {
      statusColor = Colors.orangeAccent;
    } else {
      statusColor = Colors.amber;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.access_time_filled, color: statusColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: statusColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            task.priority,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${task.patient} • ${task.room}",
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          "Original: ${task.originalTime}",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Overdue by ${task.overdueTime}",
                          style: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Assigned: ${task.assignedTo}",
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.subdirectory_arrow_right,
                          color: statusColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        task.escalatedTo,
                        style: TextStyle(color: statusColor, fontSize: 13),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- RECENT ACTIVITY ---
class _RecentActivityCard extends StatelessWidget {
  final List<ActivityItem> activities;

  const _RecentActivityCard({required this.activities});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.timeline, color: Colors.grey.shade400),
              ],
            ),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: activity.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activity.timestamp,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- DEPARTMENT OVERVIEW ---
class _DepartmentOverviewCard extends StatelessWidget {
  const _DepartmentOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Department Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.trending_up, color: Colors.grey.shade400),
              ],
            ),
            const SizedBox(height: 16),
            _buildDepartmentRow('Emergency', 24, 18, 85),
            _buildDepartmentRow('ICU', 12, 24, 92),
            _buildDepartmentRow('General Ward', 45, 32, 75),
            _buildDepartmentRow('Pediatrics', 18, 14, 60),
            _buildDepartmentRow('Cardiology', 15, 12, 78),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentRow(
      String name, int patients, int staff, int occupancy) {
    Color color;
    if (occupancy >= 90) {
      color = Colors.red;
    } else if (occupancy >= 75) {
      color = Colors.amber;
    } else {
      color = Colors.teal;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(
                  '$patients patients • $staff staff',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: occupancy / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(color),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 40,
            child: Text(
              '$occupancy%',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// --- STAT CARD ---
class _DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _DashboardStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// --- BED CARD ---
class _BedCard extends StatelessWidget {
  final String ward;
  final int total;
  final int occupied;

  const _BedCard({
    required this.ward,
    required this.total,
    required this.occupied,
  });

  @override
  Widget build(BuildContext context) {
    final available = total - occupied;
    final occupancyRate = (occupied / total * 100).round();

    Color color;
    if (occupancyRate >= 90) {
      color = Colors.red;
    } else if (occupancyRate >= 75) {
      color = Colors.amber;
    } else {
      color = Colors.teal;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ward,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$occupancyRate%',
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$available free',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '$occupied used',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: occupied / total,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation(color),
                  minHeight: 4,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
