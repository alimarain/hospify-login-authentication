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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_utils.dart'; // Ensure correct import
import '../providers/auth_provider.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/sidebar.dart'; // ✅ Import Sidebar

class NurseDashboard extends ConsumerWidget {
  const NurseDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userData = authState.userData;
    final isMobile = ResponsiveUtils.isMobile(context);

    return Scaffold(
      backgroundColor: AppTheme.background,

      // 1. Mobile Sidebar
      drawer: isMobile ? const Drawer(child: SideBar()) : null,

      // 2. Mobile AppBar
      appBar: isMobile
          ? AppBar(
              backgroundColor: AppTheme.background,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
          : null,

      // 3. Main Body with Sidebar
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar (Desktop/Tablet)
          if (!isMobile) const SizedBox(width: 250, child: SideBar()),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardHeader(
                    title: 'Nurse Dashboard',
                    subtitle:
                        'Welcome back, ${userData?['first_name'] ?? 'Nurse'}',
                    userProfileName: userData?['first_name'] ?? 'Nurse User',
                    userRole: "Nurse",
                    onLogout: () =>
                        ref.read(authStateProvider.notifier).signOut(),
                  ),

                  const SizedBox(height: 32),

                  // Quick Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          title: 'Patients Today',
                          value: '24',
                          icon: Icons.people_outline,
                          color: AppColors.nurseColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DashboardCard(
                          title: 'Pending Tasks',
                          value: '8',
                          icon: Icons.task_alt,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          title: 'Medications',
                          value: '15',
                          icon: Icons.medication,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DashboardCard(
                          title: 'Rounds',
                          value: '3',
                          icon: Icons.access_time,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  // ... (Add Recent Patients / Quick Actions widgets below as needed) ...
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
