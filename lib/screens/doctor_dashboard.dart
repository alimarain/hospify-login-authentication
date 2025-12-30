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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/responsive_utils.dart';
import '../widgets/summary_cards.dart';
import '../widgets/doctor_specific_widgets.dart';
import '../widgets/dashboard_header.dart';
import '../providers/dashboard_providers.dart';

class DoctorDashboard extends ConsumerWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ FIX: No Scaffold, No Sidebar, No Row.
    // This widget simply returns the Scrollable Content.
    // The MainLayout will handle the Sidebar and Background.
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          DashboardHeader(
            title: "Doctor's Dashboard",
            subtitle: "Welcome back, Dr. Sarah Johnson",
            userProfileName: "Dr. Sarah",
            userRole: "Cardiologist",
            onViewAllPressed: () {},
          ),

          const SizedBox(height: 32),

          // Cards
          SummaryCards(data: ref.watch(doctorSummaryProvider)),

          const SizedBox(height: 32),

          // Ward Summary
          const WardSummaryWidget(),

          const SizedBox(height: 32),

          // Tasks & Appointments
          Responsive(
            mobile: const Column(
              children: [
                DoctorTasksWidget(),
                SizedBox(height: 32),
                AppointmentsWidget()
              ],
            ),
            desktop: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: DoctorTasksWidget()),
                SizedBox(width: 24),
                Expanded(flex: 2, child: AppointmentsWidget()),
              ],
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
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
