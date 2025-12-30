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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/utils/responsive_utils.dart';
import 'package:hospify/widgets/summary_cards.dart';
import '../widgets/monthly_trend_chart.dart';
import '../widgets/admin_tasks_widget.dart';
import '../providers/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Hospital Dashboard",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text("Overview of hospital operations",
            style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        SummaryCards(data: ref.watch(adminSummaryProvider)),
        const SizedBox(height: 24),
        Responsive(
          mobile: const Column(children: [
            MonthlyTrendChart(),
            SizedBox(height: 24),
            AdminTasksWidget()
          ]),
          desktop: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: MonthlyTrendChart()),
                SizedBox(width: 24),
                Expanded(flex: 1, child: AdminTasksWidget()),
              ]),
        )
      ]),
    );
  }
}
