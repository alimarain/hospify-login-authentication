// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/utils/app_colors%20copy.dart';
// import '../providers/auth_provider.dart';
// import '../widgets/dashboard_card.dart';
// import '../widgets/dashboard_header.dart';

// class DoctorDashboard extends ConsumerWidget {
//   const DoctorDashboard({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//     final userData = authState.userData;

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               DashboardHeader(
//                 title: 'Doctor Dashboard',
//                 subtitle:
//                     'Welcome back, Dr. ${userData?['last_name'] ?? 'Doctor'}',
//                 color: AppColors.doctorColor,
//                 icon: Icons.medical_services,
//                 onLogout: () => ref.read(authStateProvider.notifier).signOut(),
//               ),
//               const SizedBox(height: 32),

//               // Quick Stats
//               Row(
//                 children: [
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Appointments',
//                       value: '12',
//                       icon: Icons.calendar_today,
//                       color: AppColors.doctorColor,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Surgeries',
//                       value: '3',
//                       icon: Icons.local_hospital,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Consultations',
//                       value: '8',
//                       icon: Icons.phone_in_talk,
//                       color: Colors.green,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Lab Results',
//                       value: '5',
//                       icon: Icons.science,
//                       color: Colors.orange,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),

//               // Today's Appointments
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.card,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Today's Appointments",
//                           style: TextStyle(
//                             color: AppColors.foreground,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {},
//                           child: const Text('View All'),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     _buildAppointmentItem(
//                         'Sarah Williams', '10:00 AM', 'Checkup'),
//                     _buildAppointmentItem(
//                         'Mike Brown', '11:30 AM', 'Follow-up'),
//                     _buildAppointmentItem(
//                         'Emma Davis', '02:00 PM', 'Consultation'),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Medical Actions
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.card,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Medical Actions',
//                       style: TextStyle(
//                         color: AppColors.foreground,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     _buildActionButton(
//                       'Write Prescription',
//                       Icons.description,
//                       AppColors.doctorColor,
//                     ),
//                     const SizedBox(height: 12),
//                     _buildActionButton(
//                       'View Medical Records',
//                       Icons.folder_open,
//                       Colors.purple,
//                     ),
//                     const SizedBox(height: 12),
//                     _buildActionButton(
//                       'Order Lab Tests',
//                       Icons.biotech,
//                       Colors.orange,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAppointmentItem(String name, String time, String type) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.doctorBg,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.person, color: AppColors.doctorColor),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     color: AppColors.foreground,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   type,
//                   style: const TextStyle(
//                     color: AppColors.mutedForeground,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.doctorBg,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               time,
//               style: const TextStyle(
//                 color: AppColors.doctorColor,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton(String title, IconData icon, Color color) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: color, size: 24),
//           const SizedBox(width: 12),
//           Text(
//             title,
//             style: const TextStyle(
//               color: AppColors.foreground,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const Spacer(),
//           const Icon(Icons.arrow_forward_ios,
//               color: AppColors.mutedForeground, size: 16),
//         ],
//       ),
//     );
//   }
// }
//
//----------------------------------------------------------------------latest-------------------------------------------//

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../utils/responsive_utils.dart';
// import '../widgets/summary_cards.dart';
// import '../widgets/doctor_specific_widgets.dart'; // ✅ Imports WardSummary, Tasks, and Appointments
// import '../widgets/dashboard_header.dart'; // Assumes you have this widget
// import '../providers/dashboard_providers.dart';

// class DoctorDashboard extends ConsumerWidget {
//   const DoctorDashboard({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // This widget simply returns the Scrollable Content.
//     // The MainLayout handles the Sidebar and Background.
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(32),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // --- Header ---
//           DashboardHeader(
//             title: "Doctor's Dashboard",
//             subtitle: "Welcome back, Dr. Sarah Johnson",
//             userProfileName: "Dr. Sarah",
//             userRole: "Cardiologist",
//             onViewAllPressed: () {},
//           ),

//           const SizedBox(height: 32),

//           // --- Summary Cards (Total Patients, Mild, Stable, Critical) ---
//           SummaryCards(data: ref.watch(doctorSummaryProvider)),

//           const SizedBox(height: 32),

//           // --- Ward Summary (The new dark grid widget) ---
//           const WardSummaryWidget(),

//           const SizedBox(height: 32),

//           // --- Tasks & Appointments (Responsive Layout) ---
//           Responsive(
//             mobile: const Column(
//               children: [
//                 DoctorTasksWidget(),
//                 SizedBox(height: 32),
//                 AppointmentsWidget(),
//               ],
//             ),
//             desktop: const Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Tasks take up more space (flex: 3)
//                 Expanded(flex: 3, child: DoctorTasksWidget()),
//                 SizedBox(width: 24),
//                 // Appointments take up less space (flex: 2)
//                 Expanded(flex: 2, child: AppointmentsWidget()),
//               ],
//             ),
//           ),

//           const SizedBox(height: 48),
//         ],
//       ),
//     );
//   }
// }
//-----------------------------------------------------------------------------------------------------------------//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hospify/utils/responsive_utils.dart';
// import 'package:hospify/widgets/summary_cards.dart';
// import '../widgets/doctor_specific_widgets.dart';
// import '../providers/dashboard_providers.dart';

// class DoctorDashboard extends ConsumerWidget {
//   const DoctorDashboard({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SingleChildScrollView(
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text("Doctor's Dashboard",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             Text("Welcome back, Dr. Sarah Johnson",
//                 style: TextStyle(color: Colors.grey)),
//           ]),
//           TextButton(onPressed: () {}, child: const Text("View All Patients"))
//         ]),
//         const SizedBox(height: 24),
//         SummaryCards(data: ref.watch(doctorSummaryProvider)),
//         const SizedBox(height: 24),
//         const WardSummaryWidget(),
//         const SizedBox(height: 24),
//         Responsive(
//           mobile: const Column(children: [
//             DoctorTasksWidget(),
//             SizedBox(height: 24),
//             AppointmentsWidget()
//           ]),
//           desktop: const Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(flex: 3, child: DoctorTasksWidget()),
//                 SizedBox(width: 24),
//                 Expanded(flex: 2, child: AppointmentsWidget()),
//               ]),
//         )
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/doctor_task.dart';
import '../providers/auth_provider.dart';
import '../providers/doctor_tasks_provider.dart';
import '../providers/navigation_provider.dart';
import '../data/patients_data.dart';
import '../providers/patients_provider.dart';
import '../theme/app_theme.dart';

class DoctorsDashboardScreen extends ConsumerWidget {
  const DoctorsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(doctorTasksProvider);
    final pendingTasks = tasks.where((t) => !t.completed).toList();
    final completedTasks = tasks.where((t) => t.completed).toList();
    final patientStats = ref.watch(patientStatsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Doctor's Dashboard",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Welcome back, Dr. Sarah Johnson',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.people),
                label: const Text('View All Patients'),
                onPressed: () => ref
                    .read(currentScreenProvider.notifier)
                    .state = AppScreen.patients,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2,
                children: [
                  _buildStatCard(Icons.people, patientStats.total.toString(),
                      'Total patients'),
                  _buildStatCard(Icons.favorite, patientStats.mild.toString(),
                      'Mild patients'),
                  _buildStatCard(Icons.show_chart,
                      patientStats.stable.toString(), 'Stable patients'),
                  _buildStatCard(Icons.warning,
                      patientStats.critical.toString(), 'Critical patients'),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          // Tasks Section
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today's Tasks",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${pendingTasks.length} pending • ${completedTasks.length} completed',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Task Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 600
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  final task = pendingTasks[index];
                  return _buildTaskCard(ref, task);
                },
              );
            },
          ),
          if (completedTasks.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Completed',
                style: TextStyle(
                    color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            ...completedTasks.map((task) => _buildCompletedTaskItem(ref, task)),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text(label,
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(WidgetRef ref, DoctorTask task) {
    Color priorityColor;
    switch (task.priority) {
      case TaskPriority.high:
        priorityColor = AppTheme.statusCritical;
        break;
      case TaskPriority.medium:
        priorityColor = Colors.orange;
        break;
      case TaskPriority.low:
        priorityColor = AppTheme.statusStable;
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: task.completed,
              onChanged: (_) => ref
                  .read(doctorTasksProvider.notifier)
                  .toggleComplete(task.id),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(task.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.schedule,
                          size: 12, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(task.time,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: priorityColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: priorityColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          task.priority.name,
                          style: TextStyle(
                              color: priorityColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedTaskItem(WidgetRef ref, DoctorTask task) {
    return Opacity(
      opacity: 0.6,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: Checkbox(
            value: task.completed,
            onChanged: (_) =>
                ref.read(doctorTasksProvider.notifier).toggleComplete(task.id),
          ),
          title: Text(
            task.title,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
        ),
      ),
    );
  }
}
