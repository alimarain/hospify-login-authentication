// // lib/widgets/nurse_dashboard/nurse_dashboard_widget.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'critical_alerts_card.dart';
// import 'reminders_summary_card.dart';
// import 'quick_actions_card.dart';
// import 'patient_status_card.dart';
// import 'task_overview_card.dart';

// class NurseDashboardWidget extends ConsumerWidget {
//   final VoidCallback? onViewAllAlerts;
//   final VoidCallback? onViewAllReminders;
//   final VoidCallback? onViewPatients;

//   const NurseDashboardWidget({
//     super.key,
//     this.onViewAllAlerts,
//     this.onViewAllReminders,
//     this.onViewPatients,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Welcome Header
//           _buildWelcomeHeader(context),
//           const SizedBox(height: 20),

//           // Shift Info Card

//           // Critical Alerts & Reminders Row
//           Row(
//             children: [
//               Expanded(
//                 child: CriticalAlertsCard(
//                   onViewAll: onViewAllAlerts,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: RemindersSummaryCard(
//                   onViewAll: onViewAllReminders,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),

//           // Quick Actions
//           const QuickActionsCard(),
//           const SizedBox(height: 16),

//           // Patient Status Overview
//           PatientStatusCard(
//             onViewAll: onViewPatients,
//           ),
//           const SizedBox(height: 16),

//           // Task Overview
//           const TaskOverviewCard(),
//         ],
//       ),
//     );
//   }

//   Widget _buildWelcomeHeader(BuildContext context) {
//     final hour = DateTime.now().hour;
//     String greeting;
//     if (hour < 12) {
//       greeting = 'Good Morning';
//     } else if (hour < 17) {
//       greeting = 'Good Afternoon';
//     } else {
//       greeting = 'Good Evening';
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$greeting, Nurse Sarah',
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Here\'s your shift overview',
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: Colors.grey[600],
//               ),
//         ),
//       ],
//     );
//   }
// }
