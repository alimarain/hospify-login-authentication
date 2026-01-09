// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart'; // Make sure this path is correct
// import '../providers/auth_provider.dart';
// import '../widgets/dashboard_card.dart';
// import '../widgets/dashboard_header.dart'; // Ensure correct import

// class NurseDashboard extends ConsumerWidget {
//   const NurseDashboard({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//     final userData = authState.userData;

//     return Scaffold(
//       backgroundColor: AppTheme.background, // Use theme-aware background
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // --- 1. Updated Header ---
//               DashboardHeader(
//                 title: 'Nurse Dashboard',
//                 subtitle: 'Welcome back, ${userData?['first_name'] ?? 'Nurse'}',
//                 userProfileName: userData?['first_name'] ?? 'Nurse User',
//                 userRole: "Nurse", // Hardcoded role for this screen
//                 onLogout: () async {
//                   await ref.read(authStateProvider.notifier).signOut();
//                 },
//               ),

//               const SizedBox(height: 32),

//               // --- 2. Quick Stats ---
//               Row(
//                 children: [
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Patients Today',
//                       value: '24',
//                       icon: Icons.people_outline,
//                       color: AppColors.nurseColor,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Pending Tasks',
//                       value: '8',
//                       icon: Icons.task_alt,
//                       color: Colors.orange,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Medications',
//                       value: '15',
//                       icon: Icons.medication,
//                       color: Colors.purple,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: DashboardCard(
//                       title: 'Rounds',
//                       value: '3',
//                       icon: Icons.access_time,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),

//               // --- 3. Recent Patients ---
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppTheme.cardColor,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppTheme.border),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Recent Patients',
//                           style: TextStyle(
//                             color: AppTheme.textPrimary,
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
//                     _buildPatientItem('John Doe', 'Room 101', 'Stable'),
//                     _buildPatientItem('Jane Smith', 'Room 102', 'Critical'),
//                     _buildPatientItem('Bob Johnson', 'Room 103', 'Stable'),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // --- 4. Quick Actions ---
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppTheme.cardColor,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: AppTheme.border),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Quick Actions',
//                       style: TextStyle(
//                         color: AppTheme.textPrimary,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     _buildActionButton(
//                       'Add Patient Notes',
//                       Icons.note_add,
//                       AppColors.nurseColor,
//                     ),
//                     const SizedBox(height: 12),
//                     _buildActionButton(
//                       'Record Vitals',
//                       Icons.monitor_heart,
//                       Colors.red,
//                     ),
//                     const SizedBox(height: 12),
//                     _buildActionButton(
//                       'Medication Schedule',
//                       Icons.schedule,
//                       Colors.blue,
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

//   Widget _buildPatientItem(String name, String room, String status) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppTheme.background,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppTheme.border),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.nurseBg, // Using static AppColors for specific styling
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Icon(Icons.person, color: AppColors.nurseColor),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(
//                     color: AppTheme.textPrimary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   room,
//                   style: TextStyle(
//                     color: AppTheme.textSecondary,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: status == 'Critical'
//                   ? Colors.red.withOpacity(0.1)
//                   : AppColors.nurseBg,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               status,
//               style: TextStyle(
//                 color: status == 'Critical' ? Colors.red : AppColors.nurseColor,
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
//         color: AppTheme.background,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppTheme.border),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: color, size: 24),
//           const SizedBox(width: 12),
//           Text(
//             title,
//             style: TextStyle(
//               color: AppTheme.textPrimary,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const Spacer(),
//           Icon(Icons.arrow_forward_ios,
//               color: AppTheme.textSecondary, size: 16),
//         ],
//       ),
//     );
//   }
// }

// //----------------------------------------------------------------------latest-------------------------------------------//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart';
// import '../utils/responsive_utils.dart'; // Ensure correct import
// import '../providers/auth_provider.dart';
// import '../widgets/dashboard_card.dart';
// import '../widgets/dashboard_header.dart';
// import '../widgets/sidebar.dart'; // ✅ Import Sidebar

// class NurseDashboard extends ConsumerWidget {
//   const NurseDashboard({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
//     final userData = authState.userData;
//     final isMobile = ResponsiveUtils.isMobile(context);

//     return Scaffold(
//       backgroundColor: AppTheme.background,

//       // 1. Mobile Sidebar
//       drawer: isMobile ? const Drawer(child: SideBar()) : null,

//       // 2. Mobile AppBar
//       appBar: isMobile
//           ? AppBar(
//               backgroundColor: AppTheme.background,
//               elevation: 0,
//               leading: Builder(
//                 builder: (context) => IconButton(
//                   icon: const Icon(Icons.menu, color: AppColors.textPrimary),
//                   onPressed: () => Scaffold.of(context).openDrawer(),
//                 ),
//               ),
//             )
//           : null,

//       // 3. Main Body with Sidebar
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Sidebar (Desktop/Tablet)
//           if (!isMobile) const SizedBox(width: 250, child: SideBar()),

//           // Content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(32),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DashboardHeader(
//                     title: 'Nurse Dashboard',
//                     subtitle:
//                         'Welcome back, ${userData?['first_name'] ?? 'Nurse'}',
//                     userProfileName: userData?['first_name'] ?? 'Nurse User',
//                     userRole: "Nurse",
//                     onLogout: () =>
//                         ref.read(authStateProvider.notifier).signOut(),
//                   ),

//                   const SizedBox(height: 32),

//                   // Quick Stats Row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: DashboardCard(
//                           title: 'Patients Today',
//                           value: '24',
//                           icon: Icons.people_outline,
//                           color: AppColors.nurseColor,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: DashboardCard(
//                           title: 'Pending Tasks',
//                           value: '8',
//                           icon: Icons.task_alt,
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: DashboardCard(
//                           title: 'Medications',
//                           value: '15',
//                           icon: Icons.medication,
//                           color: Colors.purple,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: DashboardCard(
//                           title: 'Rounds',
//                           value: '3',
//                           icon: Icons.access_time,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // ... (Add Recent Patients / Quick Actions widgets below as needed) ...
//                   const SizedBox(height: 48),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//----------------09-01-2026--------------------------------------///

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_provider.dart';
// import '../providers/nurse_tasks_provider.dart';
// import '../providers/navigation_provider.dart';
// import '../models/nurse_task.dart';
// import '../theme/app_theme.dart';

// class NursesDashboardScreen extends ConsumerWidget {
//   const NursesDashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tasks = ref.watch(nurseTasksProvider);
//     final filterCategory = ref.watch(taskFilterProvider);

//     final filteredTasks = filterCategory == null
//         ? tasks
//         : tasks.where((t) => t.category == filterCategory).toList();

//     final pendingTasks = filteredTasks.where((t) => !t.completed).toList();
//     final completedTasks = filteredTasks.where((t) => t.completed).toList();

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
//                   const Text(
//                     "Nurse's Dashboard",
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Welcome back, Nurse Emily Carter',
//                     style: TextStyle(color: Colors.grey.shade600),
//                   ),
//                 ],
//               ),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.people),
//                 label: const Text('View All Patients'),
//                 onPressed: () => ref
//                     .read(currentScreenProvider.notifier)
//                     .state = AppScreen.patients,
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//           // Stats Cards
//           Row(
//             children: [
//               Expanded(
//                   child: _buildGradientCard(
//                       'Patients Assigned',
//                       '18',
//                       '+3 today',
//                       Icons.people,
//                       AppTheme.statsBlueStart,
//                       AppTheme.statsBlueEnd)),
//               const SizedBox(width: 16),
//               Expanded(
//                   child: _buildGradientCard(
//                       'Medications Due',
//                       '7',
//                       'Next in 15 min',
//                       Icons.medication,
//                       AppTheme.statsPinkStart,
//                       AppTheme.statsPinkEnd)),
//               const SizedBox(width: 16),
//               Expanded(
//                   child: _buildGradientCard(
//                       'Vitals Pending',
//                       '5',
//                       '2 urgent',
//                       Icons.monitor_heart,
//                       AppTheme.statsCyanStart,
//                       AppTheme.statsCyanEnd)),
//             ],
//           ),
//           const SizedBox(height: 24),
//           // Task Filters
//           Wrap(
//             spacing: 8,
//             children: [
//               _buildFilterChip(ref, null, 'All', filterCategory == null),
//               _buildFilterChip(ref, TaskCategory.medication, 'Medication',
//                   filterCategory == TaskCategory.medication),
//               _buildFilterChip(ref, TaskCategory.vitals, 'Vitals',
//                   filterCategory == TaskCategory.vitals),
//               _buildFilterChip(ref, TaskCategory.care, 'Care',
//                   filterCategory == TaskCategory.care),
//               _buildFilterChip(ref, TaskCategory.documentation, 'Documentation',
//                   filterCategory == TaskCategory.documentation),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             '${pendingTasks.length} pending • ${completedTasks.length} completed',
//             style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//           ),
//           const SizedBox(height: 16),
//           // Tasks List
//           ...pendingTasks.map((task) => _buildTaskCard(ref, task)),
//           if (completedTasks.isNotEmpty) ...[
//             const SizedBox(height: 24),
//             Text(
//               'Completed Tasks',
//               style: TextStyle(
//                   color: Colors.grey.shade600, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 12),
//             ...completedTasks
//                 .map((task) => _buildTaskCard(ref, task, completed: true)),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildGradientCard(String title, String value, String subtitle,
//       IconData icon, Color startColor, Color endColor) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [startColor, endColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   color: Colors.white70, fontWeight: FontWeight.w500)),
//           Text(subtitle,
//               style: const TextStyle(color: Colors.white54, fontSize: 12)),
//           const SizedBox(height: 12),
//           Text(value,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterChip(
//       WidgetRef ref, TaskCategory? category, String label, bool isSelected) {
//     return FilterChip(
//       label: Text(label),
//       selected: isSelected,
//       onSelected: (_) => ref.read(taskFilterProvider.notifier).state = category,
//     );
//   }

//   Widget _buildTaskCard(WidgetRef ref, NurseTask task,
//       {bool completed = false}) {
//     Color priorityColor;
//     switch (task.priority) {
//       case TaskPriority.high:
//         priorityColor = AppTheme.statusCritical;
//         break;
//       case TaskPriority.medium:
//         priorityColor = Colors.amber;
//         break;
//       case TaskPriority.low:
//         priorityColor = AppTheme.statusStable;
//         break;
//     }

//     Color categoryColor;
//     switch (task.category) {
//       case TaskCategory.medication:
//         categoryColor = Colors.purple;
//         break;
//       case TaskCategory.vitals:
//         categoryColor = Colors.blue;
//         break;
//       case TaskCategory.care:
//         categoryColor = Colors.green;
//         break;
//       case TaskCategory.documentation:
//         categoryColor = Colors.orange;
//         break;
//     }

//     return Opacity(
//       opacity: completed ? 0.6 : 1,
//       child: Card(
//         margin: const EdgeInsets.only(bottom: 8),
//         child: ListTile(
//           leading: Checkbox(
//             value: task.completed,
//             onChanged: (_) =>
//                 ref.read(nurseTasksProvider.notifier).toggleComplete(task.id),
//           ),
//           title: Text(
//             task.title,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               decoration: completed ? TextDecoration.lineThrough : null,
//             ),
//           ),
//           subtitle: Row(
//             children: [
//               Text('${task.patient} • Room ${task.room} • '),
//               Icon(Icons.schedule, size: 12, color: Colors.grey.shade600),
//               const SizedBox(width: 2),
//               Text(task.time),
//             ],
//           ),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: priorityColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   task.priority.name,
//                   style: TextStyle(
//                       color: priorityColor,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: categoryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   task.categoryLabel,
//                   style: TextStyle(
//                       color: categoryColor,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//---------------------09-1-2026--------7:47-----

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nurse_alert.dart';
import '../models/nurse_reminder.dart';
import '../providers/nurse_alerts_provider.dart';
import '../providers/nurse_reminders_provider.dart';
import '../widgets/blocking_alert_modal.dart';
import '../widgets/nurse_stats_card.dart';
import '../widgets/nurse_task_list.dart';
import '../widgets/shift_handover_card.dart';
import '../widgets/task_alerts_card.dart';
import '../widgets/ward_overview_panel.dart';

class NursesDashboardScreen extends ConsumerStatefulWidget {
  final VoidCallback? onNavigateToPatients;

  const NursesDashboardScreen({super.key, this.onNavigateToPatients});

  @override
  ConsumerState<NursesDashboardScreen> createState() => _NurseScreenState();
}

class _NurseScreenState extends ConsumerState<NursesDashboardScreen> {
  String _filterCategory = 'all';
  NurseAlert? _blockingAlert;

  @override
  void initState() {
    super.initState();
    _checkForBlockingAlerts();
  }

  void _checkForBlockingAlerts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final alerts = ref.read(nurseAlertsProvider);
      alerts.whenData((data) {
        final onTimeAlert = data.firstWhere(
          (a) => a.type == AlertType.onTime && !a.isRead && !a.triggered,
          orElse: () => NurseAlert(
            id: '',
            type: AlertType.pre,
            title: '',
            message: '',
            patient: '',
            room: '',
            time: '',
            category: AlertCategory.care,
          ),
        );
        if (onTimeAlert.id.isNotEmpty) {
          setState(() => _blockingAlert = onTimeAlert);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final alertsAsync = ref.watch(nurseAlertsProvider);
    final remindersAsync = ref.watch(nurseRemindersProvider);
    final unreadCount = ref.watch(unreadAlertsCountProvider);
    final criticalCount = ref.watch(criticalAlertsCountProvider);
    final pendingReminders = ref.watch(pendingRemindersProvider);
    final overdueReminders = ref.watch(overdueRemindersProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Row(
              children: [
                // Main Content
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      // Header
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nurse's Dashboard",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Welcome back, Nurse Emily Carter',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                  if (widget.onNavigateToPatients != null)
                                    FilledButton.icon(
                                      onPressed: widget.onNavigateToPatients,
                                      icon: const Icon(Icons.people),
                                      label: const Text('View All Patients'),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Stats Cards
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: StatsCard(
                                  title: 'Patients Assigned',
                                  subtitle: '+3 today',
                                  value: '18',
                                  icon: Icons.people,
                                  gradient: const [
                                    Color(0xFF3B82F6),
                                    Color(0xFF1D4ED8)
                                  ],
                                  onTap: widget.onNavigateToPatients,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: StatsCard(
                                  title: 'Medications Due',
                                  subtitle: 'Next in 15 min',
                                  value: '7',
                                  icon: Icons.medication,
                                  gradient: const [
                                    Color(0xFFEC4899),
                                    Color(0xFFBE185D)
                                  ],
                                  onTap: () => setState(
                                      () => _filterCategory = 'medication'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: StatsCard(
                                  title: 'Vitals Pending',
                                  subtitle: '2 urgent',
                                  value: '5',
                                  icon: Icons.monitor_heart,
                                  gradient: const [
                                    Color(0xFF06B6D4),
                                    Color(0xFF0891B2)
                                  ],
                                  onTap: () => setState(
                                      () => _filterCategory = 'vitals'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 16)),

                      // Shift Handover
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ShiftHandoverCard(),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 16)),

                      // Task Alerts Card
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TaskAlertsCard(
                            onAlertTap: (alert) {
                              if (alert.type == AlertType.onTime) {
                                setState(() => _blockingAlert = alert);
                              }
                            },
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 16)),

                      // Filter Buttons
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                'all',
                                'medication',
                                'vitals',
                                'care',
                                'documentation'
                              ]
                                  .map((cat) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: FilterChip(
                                          label: Text(cat[0].toUpperCase() +
                                              cat.substring(1)),
                                          selected: _filterCategory == cat,
                                          onSelected: (_) => setState(
                                              () => _filterCategory = cat),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 16)),

                      // Task List
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: NurseTaskList(filterCategory: _filterCategory),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    ],
                  ),
                ),

                // Ward Overview Panel (Desktop)
                if (MediaQuery.of(context).size.width > 1024)
                  SizedBox(
                    width: 320,
                    child: WardOverviewPanel(
                      criticalCount: criticalCount,
                      pendingReminders: pendingReminders.length,
                      overdueReminders: overdueReminders.length,
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Blocking Alert Modal
        if (_blockingAlert != null)
          BlockingAlertModal(
            alert: _blockingAlert!,
            onAcknowledge: () {
              ref
                  .read(nurseAlertsProvider.notifier)
                  .acknowledgeAlert(_blockingAlert!.id);
              setState(() => _blockingAlert = null);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Task acknowledged. Please complete it soon.')),
              );
            },
            onComplete: () {
              ref
                  .read(nurseAlertsProvider.notifier)
                  .dismissAlert(_blockingAlert!.id);
              setState(() => _blockingAlert = null);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Great job! Task completed successfully.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
      ],
    );
  }
}
