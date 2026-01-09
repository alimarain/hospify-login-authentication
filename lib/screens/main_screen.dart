// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/navigation_provider.dart';
// import '../widgets/sidebar.dart';
// import 'dashboard_screen.dart';
// import 'patients_screen.dart';
// import 'appointments_screen.dart';
// import 'analytics_screen.dart';
// import 'settings_screen.dart';

// class MainScreen extends ConsumerWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentSection = ref.watch(currentSectionProvider);

//     return Scaffold(
//       body: Row(
//         children: [
//           const Sidebar(),
//           Expanded(
//             child: _buildContent(currentSection),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent(DashboardSection section) {
//     switch (section) {
//       case DashboardSection.dashboard:
//         return const DashboardScreen();
//       case DashboardSection.patients:
//         return const PatientsScreen();
//       case DashboardSection.appointments:
//         return const AppointmentsScreen();
//       case DashboardSection.analytics:
//         return const AnalyticsScreen();
//       case DashboardSection.settings:
//         return const SettingsScreen();
//     }
//   }
// }
// //---------------------------------------------------------------04-1-2024--------------------//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/navigation_provider.dart';
// import '../widgets/sidebar.dart';
// import 'dashboard_screen.dart';
// import 'doctor_dashboard.dart';
// import 'nurse_dashboard_screen.dart';
// import 'patients_screen.dart';

// class MainScreen extends ConsumerWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentScreen = ref.watch(currentScreenProvider);
//     final isWide = MediaQuery.of(context).size.width > 800;

//     return Scaffold(
//       drawer: isWide ? null : const Drawer(child: Sidebar()),
//       body: Row(
//         children: [
//           if (isWide) const Sidebar(),
//           Expanded(
//             child: Column(
//               children: [
//                 // Header
//                 Container(
//                   height: 64,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border:
//                         Border(bottom: BorderSide(color: Colors.grey.shade200)),
//                   ),
//                   child: Row(
//                     children: [
//                       if (!isWide)
//                         Builder(
//                           builder: (context) => IconButton(
//                             icon: const Icon(Icons.menu),
//                             onPressed: () => Scaffold.of(context).openDrawer(),
//                           ),
//                         ),
//                       const Text(
//                         'Hospital Management',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         icon: const Icon(Icons.notifications_outlined),
//                         onPressed: () {},
//                       ),
//                       const SizedBox(width: 8),
//                       const CircleAvatar(
//                         radius: 18,
//                         child: Text('A'),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Content
//                 Expanded(
//                   child: _buildContent(currentScreen),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContent(AppScreen screen) {
//     switch (screen) {
//       case AppScreen.dashboard:
//         return const DashboardScreen();
//       case AppScreen.nursesDashboard:
//         return const NursesDashboardScreen();
//       case AppScreen.doctorsDashboard:
//         return const DoctorsDashboardScreen();
//       case AppScreen.patients:
//         return const PatientsScreen();
//     }
//   }
// }
//---------------------------------04-1-2025-----------------------------//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/sidebar.dart';
import '../widgets/main_layout.dart';

import 'auth_screen.dart';
import 'dashboard_screen.dart';
import 'doctor_dashboard.dart';
import 'nurse_dashboard_screen.dart';
import 'patients_screen.dart';
import 'appointments_screen.dart';
import 'admissions_screen.dart';
import 'discharges_screen.dart';
import 'notifications_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';

// ✅ NEW SCREENS
import 'shift_scheduling_screen.dart';
import 'handover_screen.dart';
import 'nurse_alerts_screen.dart';
import 'reminders_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final currentScreen = ref.watch(currentScreenProvider);

    final screenWidth = MediaQuery.of(context).size.width;

    // 🌐 Web breakpoints
    final isDesktop = screenWidth >= 1100;
    final isTablet = screenWidth >= 768 && screenWidth < 1100;
    final isMobile = screenWidth < 768;

    // 🔐 Not logged in → Auth
    if (authState.user == null || authState.userRole == null) {
      return const AuthScreen();
    }

    return Scaffold(
      body: Row(
        children: [
          // ✅ Sidebar visible on Desktop & Tablet
          if (!isMobile) const Sidebar(),

          // ✅ Main content
          Expanded(
            child: MainLayout(
              child: _resolveScreenForRole(
                currentScreen,
                authState.userRole!,
              ),
            ),
          ),
        ],
      ),

      // 📱 Mobile drawer
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
    );
  }

  // =========================================================
  // 🔒 ROLE-BASED SCREEN RESOLUTION
  // =========================================================
  Widget _resolveScreenForRole(AppScreen screen, UserRole role) {
    final Map<UserRole, Map<AppScreen, Widget>> roleScreens = {
      // ================= ADMIN =================
      UserRole.admin: {
        AppScreen.dashboard: const DashboardScreen(),
        AppScreen.doctorsDashboard: const DoctorsDashboardScreen(),
        AppScreen.nursesDashboard: const NursesDashboardScreen(),
        AppScreen.patients: const PatientsScreen(),
        AppScreen.appointments: const AppointmentsScreen(),
        AppScreen.admissions: const AdmissionsScreen(),
        AppScreen.discharges: const DischargesScreen(),
        AppScreen.notifications: const NotificationsScreen(),
        AppScreen.analytics: const AnalyticsScreen(),
        AppScreen.settings: const SettingsScreen(),

        // ✅ ADMIN FEATURES
        AppScreen.shiftScheduling: const ShiftSchedulingScreen(),
        // AppScreen.handover: const HandoverScreen(),
        // AppScreen.nurseAlerts: const NurseAlertsScreen(),
        AppScreen.reminders: const RemindersScreen(),
      },

      // ================= DOCTOR =================
      UserRole.doctor: {
        AppScreen.dashboard: const DoctorsDashboardScreen(),
        AppScreen.doctorsDashboard: const DoctorsDashboardScreen(),
        AppScreen.patients: const PatientsScreen(),
        AppScreen.appointments: const AppointmentsScreen(),
        AppScreen.notifications: const NotificationsScreen(),
        AppScreen.settings: const SettingsScreen(),
        // ❌ Doctor has no access to shift, handover, alerts, reminders
      },

      // ================= NURSE =================
      UserRole.nurse: {
        AppScreen.dashboard: const NursesDashboardScreen(),
        AppScreen.nursesDashboard: const NursesDashboardScreen(),
        AppScreen.patients: const PatientsScreen(),
        AppScreen.admissions: const AdmissionsScreen(),
        AppScreen.discharges: const DischargesScreen(),
        AppScreen.notifications: const NotificationsScreen(),
        AppScreen.settings: const SettingsScreen(),

        // ✅ NURSE FEATURES
        // AppScreen.handover: const HandoverScreen(),
        // AppScreen.nurseAlerts: const NurseAlertsScreen(),
        AppScreen.reminders: const RemindersScreen(),
      },
    };

    // ✅ Safe fallback
    return roleScreens[role]?[screen] ??
        switch (role) {
          UserRole.admin => const DashboardScreen(),
          UserRole.doctor => const DoctorsDashboardScreen(),
          UserRole.nurse => const NursesDashboardScreen(),
        };
  }
}
