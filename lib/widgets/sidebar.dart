// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/navigation_provider.dart';
// import '../theme/app_theme.dart';

// class Sidebar extends ConsumerWidget {
//   const Sidebar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentSection = ref.watch(currentSectionProvider);
//     final isExpanded = ref.watch(sidebarExpandedProvider);

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       width: isExpanded ? 240 : 72,
//       color: AppTheme.secondary,
//       child: Column(
//         children: [
//           // Logo
//           Container(
//             height: 64,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 Icon(Icons.local_hospital, color: AppTheme.primary, size: 32),
//                 if (isExpanded) ...[
//                   const SizedBox(width: 12),
//                   const Expanded(
//                     child: Text(
//                       'MediCare',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
//           // Navigation Items
//           _buildNavItem(
//             ref,
//             icon: Icons.dashboard,
//             label: 'Dashboard',
//             section: DashboardSection.dashboard,
//             isSelected: currentSection == DashboardSection.dashboard,
//             isExpanded: isExpanded,
//           ),
//           _buildNavItem(
//             ref,
//             icon: Icons.people,
//             label: 'Patients',
//             section: DashboardSection.patients,
//             isSelected: currentSection == DashboardSection.patients,
//             isExpanded: isExpanded,
//           ),
//           _buildNavItem(
//             ref,
//             icon: Icons.calendar_today,
//             label: 'Appointments',
//             section: DashboardSection.appointments,
//             isSelected: currentSection == DashboardSection.appointments,
//             isExpanded: isExpanded,
//           ),
//           _buildNavItem(
//             ref,
//             icon: Icons.bar_chart,
//             label: 'Analytics',
//             section: DashboardSection.analytics,
//             isSelected: currentSection == DashboardSection.analytics,
//             isExpanded: isExpanded,
//           ),
//           const Spacer(),
//           _buildNavItem(
//             ref,
//             icon: Icons.settings,
//             label: 'Settings',
//             section: DashboardSection.settings,
//             isSelected: currentSection == DashboardSection.settings,
//             isExpanded: isExpanded,
//           ),
//           const SizedBox(height: 16),
//           // Toggle Button
//           IconButton(
//             onPressed: () {
//               ref.read(sidebarExpandedProvider.notifier).state = !isExpanded;
//             },
//             icon: Icon(
//               isExpanded ? Icons.chevron_left : Icons.chevron_right,
//               color: Colors.white54,
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(
//     WidgetRef ref, {
//     required IconData icon,
//     required String label,
//     required DashboardSection section,
//     required bool isSelected,
//     required bool isExpanded,
//   }) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           ref.read(currentSectionProvider.notifier).state = section;
//         },
//         child: Container(
//           height: 48,
//           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: isSelected ? AppTheme.primary.withOpacity(0.2) : null,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ? AppTheme.primary : Colors.white54,
//                 size: 22,
//               ),
//               if (isExpanded) ...[
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     label,
//                     style: TextStyle(
//                       color: isSelected ? AppTheme.primary : Colors.white70,
//                       fontWeight:
//                           isSelected ? FontWeight.w600 : FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';

// class SideBar extends ConsumerWidget {
//   const SideBar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedNavItemProvider);

//     return Container(
//       color: AppColors.cardBackground,
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Logo
//           Row(
//             children: [
//               Icon(Icons.local_hospital,
//                   color: AppColors.primaryAccent, size: 32),
//               const SizedBox(width: 8),
//               Text("MediCare",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall
//                       ?.copyWith(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const SizedBox(height: 32),
//           // Administrator Button
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             decoration: BoxDecoration(
//                 color: AppColors.primaryAccent.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                     color: AppColors.primaryAccent.withOpacity(0.5))),
//             child: const Center(
//                 child: Text("Administrator",
//                     style: TextStyle(
//                         color: AppColors.primaryAccent,
//                         fontWeight: FontWeight.bold))),
//           ),
//           const SizedBox(height: 32),
//           Text("Medical Suite",
//               style: Theme.of(context)
//                   .textTheme
//                   .bodySmall
//                   ?.copyWith(color: AppColors.textSecondary)),
//           const SizedBox(height: 16),
//           // Navigation Menu
//           _buildNavItem(context, ref, 0, "Dashboard", Icons.dashboard,
//               selectedIndex == 0),
//           _buildNavItem(context, ref, 1, "Doctor Dashboard", Icons.person,
//               selectedIndex == 1,
//               badge: "12"),
//           _buildNavItem(context, ref, 2, "Nurse Dashboard",
//               Icons.medical_services, selectedIndex == 2),
//           _buildNavItem(context, ref, 3, "Patients", Icons.people_alt,
//               selectedIndex == 3),
//           // ... Add other menu items similarly
//           const Spacer(),
//           // Sign out
//           _buildNavItem(context, ref, 99, "Sign Out", Icons.logout, false,
//               color: AppColors.redAccent),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(BuildContext context, WidgetRef ref, int index,
//       String title, IconData icon, bool isSelected,
//       {String? badge, Color? color}) {
//     final textColor =
//         color ?? (isSelected ? Colors.white : AppColors.textSecondary);
//     final iconColor = color ??
//         (isSelected ? AppColors.primaryAccent : AppColors.textSecondary);

//     return InkWell(
//       onTap: () => ref.read(selectedNavItemProvider.notifier).state = index,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: isSelected
//             ? BoxDecoration(
//                 color: AppColors.background,
//                 borderRadius: BorderRadius.circular(8))
//             : null,
//         child: Row(
//           children: [
//             Icon(icon, color: iconColor),
//             const SizedBox(width: 12),
//             Text(title,
//                 style: TextStyle(
//                     color: textColor,
//                     fontWeight:
//                         isSelected ? FontWeight.bold : FontWeight.normal)),
//             if (badge != null) ...[
//               const Spacer(),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                     color: AppColors.background,
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Text(badge, style: const TextStyle(fontSize: 12)),
//               )
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';

// class SideBar extends ConsumerWidget {
//   const SideBar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedNavItemProvider);

//     return Container(
//       color: AppColors.cardBackground,
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Logo
//           Row(
//             children: [
//               const Icon(Icons.local_hospital,
//                   color: AppColors.primaryAccent, size: 32),
//               const SizedBox(width: 8),
//               Text("MediCare",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall
//                       ?.copyWith(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const SizedBox(height: 32),

//           // Administrator Button
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             decoration: BoxDecoration(
//                 color: AppColors.primaryAccent.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                     color: AppColors.primaryAccent.withOpacity(0.5))),
//             child: const Center(
//                 child: Text("Administrator",
//                     style: TextStyle(
//                         color: AppColors.primaryAccent,
//                         fontWeight: FontWeight.bold))),
//           ),
//           const SizedBox(height: 32),

//           // Section Title
//           Text("Medical Suite",
//               style: Theme.of(context)
//                   .textTheme
//                   .bodySmall
//                   ?.copyWith(color: AppColors.textSecondary)),
//           const SizedBox(height: 16),

//           // Navigation Menu
//           _buildNavItem(context, ref, 0, "Dashboard", Icons.dashboard,
//               selectedIndex == 0),
//           _buildNavItem(context, ref, 1, "Doctor Dashboard", Icons.person,
//               selectedIndex == 1,
//               badge: "12"),
//           _buildNavItem(context, ref, 2, "Nurse Dashboard",
//               Icons.medical_services, selectedIndex == 2),
//           _buildNavItem(context, ref, 3, "Patients", Icons.people_alt,
//               selectedIndex == 3),

//           const Spacer(),

//           // Sign out
//           _buildNavItem(context, ref, 99, "Sign Out", Icons.logout, false,
//               color: AppColors.redAccent),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(BuildContext context, WidgetRef ref, int index,
//       String title, IconData icon, bool isSelected,
//       {String? badge, Color? color}) {
//     final textColor =
//         color ?? (isSelected ? Colors.white : AppColors.textSecondary);
//     final iconColor = color ??
//         (isSelected ? AppColors.primaryAccent : AppColors.textSecondary);

//     return InkWell(
//       onTap: () => ref.read(selectedNavItemProvider.notifier).state = index,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: isSelected
//             ? BoxDecoration(
//                 color: AppColors.background,
//                 borderRadius: BorderRadius.circular(8))
//             : null,
//         child: Row(
//           children: [
//             Icon(icon, color: iconColor),
//             const SizedBox(width: 12),
//             Text(title,
//                 style: TextStyle(
//                     color: textColor,
//                     fontWeight:
//                         isSelected ? FontWeight.bold : FontWeight.normal)),
//             if (badge != null) ...[
//               const Spacer(),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                     color: AppColors.background,
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Text(badge, style: const TextStyle(fontSize: 12)),
//               )
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/dashboard_providers.dart';
import '../providers/auth_provider.dart';
import '../models/auth_model.dart';
import '../screens/auth_screen.dart'; // ✅ Import AuthScreen for redirection

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavItemProvider);
    final authState = ref.watch(authStateProvider);
    final userRole = authState.userRole;

    String getRoleLabel() {
      switch (userRole) {
        case UserRole.admin:
          return "Administrator";
        case UserRole.doctor:
          return "Doctor";
        case UserRole.nurse:
          return "Nurse";
        default:
          return "Guest";
      }
    }

    return Container(
      width: 250,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text("Hospify",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),

          // Role Badge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D3F),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: AppColors.primaryAccent.withOpacity(0.5)),
            ),
            child: Center(
              child: Text(
                getRoleLabel(),
                style: const TextStyle(
                    color: AppColors.primaryAccent,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 32),

          Text("Medical Suite",
              style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 16),

          _buildNavItem(context, ref, 0, "Dashboard", Icons.grid_view,
              selectedIndex == 0),
          _buildNavItem(
            context,
            ref,
            1,
            "Doctor Dashboard",
            Icons.person_outline,
            selectedIndex == 1,
          ),
          _buildNavItem(context, ref, 2, "Nurse Dashboard",
              Icons.medical_services_outlined, selectedIndex == 2),
          _buildNavItem(context, ref, 3, "Patients", Icons.people_outline,
              selectedIndex == 3),
          _buildNavItem(context, ref, 4, "My Appointments",
              Icons.calendar_today_outlined, selectedIndex == 4),
          _buildNavItem(context, ref, 5, "Prescriptions",
              Icons.description_outlined, selectedIndex == 5),
          _buildNavItem(context, ref, 6, "Settings", Icons.settings_outlined,
              selectedIndex == 6),

          const Spacer(),

          // --- Sign Out Button ---
          _buildNavItem(context, ref, 99, "Sign Out", Icons.logout, false,
              color: AppColors.redAccent,
              // ✅ ADDED: Sign Out Logic
              onTap: () async {
            // 1. Clear session
            await ref.read(authStateProvider.notifier).signOut();

            // 2. Navigate back to AuthScreen and remove history
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, WidgetRef ref, int index,
      String title, IconData icon, bool isSelected,
      {String? badge, Color? color, VoidCallback? onTap}) {
    final textColor = color ?? (isSelected ? Colors.white : Colors.grey);
    final iconColor = color ?? (isSelected ? Colors.white : Colors.grey);
    final bgColor = isSelected ? const Color(0xFF2D2D3F) : Colors.transparent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ??
            () => ref.read(selectedNavItemProvider.notifier).state = index,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(title,
                      style: TextStyle(
                          color: textColor,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14))),
              if (badge != null)
                Text(badge,
                    style: const TextStyle(color: Colors.grey, fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}
