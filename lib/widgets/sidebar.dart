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
//----------------------------------------------------------------------latest-------------------------------------------//

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';
// import '../providers/auth_provider.dart';
// import '../models/auth_model.dart';
// import '../screens/auth_screen.dart'; // ✅ Import AuthScreen for redirection

// class SideBar extends ConsumerWidget {
//   const SideBar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedNavItemProvider);
//     final authState = ref.watch(authStateProvider);
//     final userRole = authState.userRole;

//     String getRoleLabel() {
//       switch (userRole) {
//         case UserRole.admin:
//           return "Administrator";
//         case UserRole.doctor:
//           return "Doctor";
//         case UserRole.nurse:
//           return "Nurse";
//         default:
//           return "Guest";
//       }
//     }

//     return Container(
//       width: 250,
//       color: AppColors.background,
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Text("Hospify",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // Role Badge
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             decoration: BoxDecoration(
//               color: const Color(0xFF2D2D3F),
//               borderRadius: BorderRadius.circular(8),
//               border:
//                   Border.all(color: AppColors.primaryAccent.withOpacity(0.5)),
//             ),
//             child: Center(
//               child: Text(
//                 getRoleLabel(),
//                 style: const TextStyle(
//                     color: AppColors.primaryAccent,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//           const SizedBox(height: 32),

//           Text("Medical Suite",
//               style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//           const SizedBox(height: 16),

//           _buildNavItem(context, ref, 0, "Dashboard", Icons.grid_view,
//               selectedIndex == 0),
//           _buildNavItem(
//             context,
//             ref,
//             1,
//             "Doctor Dashboard",
//             Icons.person_outline,
//             selectedIndex == 1,
//           ),
//           _buildNavItem(context, ref, 2, "Nurse Dashboard",
//               Icons.medical_services_outlined, selectedIndex == 2),
//           _buildNavItem(context, ref, 3, "Patients", Icons.people_outline,
//               selectedIndex == 3),
//           _buildNavItem(context, ref, 4, "My Appointments",
//               Icons.calendar_today_outlined, selectedIndex == 4),
//           _buildNavItem(context, ref, 5, "Prescriptions",
//               Icons.description_outlined, selectedIndex == 5),
//           _buildNavItem(context, ref, 6, "Settings", Icons.settings_outlined,
//               selectedIndex == 6),

//           const Spacer(),

//           // --- Sign Out Button ---
//           _buildNavItem(context, ref, 99, "Sign Out", Icons.logout, false,
//               color: AppColors.redAccent,
//               // ✅ ADDED: Sign Out Logic
//               onTap: () async {
//             // 1. Clear session
//             await ref.read(authStateProvider.notifier).signOut();

//             // 2. Navigate back to AuthScreen and remove history
//             if (context.mounted) {
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => const AuthScreen()),
//                 (route) => false,
//               );
//             }
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(BuildContext context, WidgetRef ref, int index,
//       String title, IconData icon, bool isSelected,
//       {String? badge, Color? color, VoidCallback? onTap}) {
//     final textColor = color ?? (isSelected ? Colors.white : Colors.grey);
//     final iconColor = color ?? (isSelected ? Colors.white : Colors.grey);
//     final bgColor = isSelected ? const Color(0xFF2D2D3F) : Colors.transparent;

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap ??
//             () => ref.read(selectedNavItemProvider.notifier).state = index,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 4),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: iconColor, size: 20),
//               const SizedBox(width: 12),
//               Expanded(
//                   child: Text(title,
//                       style: TextStyle(
//                           color: textColor,
//                           fontWeight:
//                               isSelected ? FontWeight.w600 : FontWeight.normal,
//                           fontSize: 14))),
//               if (badge != null)
//                 Text(badge,
//                     style: const TextStyle(color: Colors.grey, fontSize: 12))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//----------------------------------------------------------------------latest-------------------------------------------//

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/navigation_provider.dart';

// class Sidebar extends ConsumerWidget {
//   const Sidebar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentScreen = ref.watch(currentScreenProvider);

//     return Container(
//       width: 260,
//       color: Colors.white,
//       child: Column(
//         children: [
//           const SizedBox(height: 24),
//           // Logo
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(Icons.local_hospital,
//                       color: Colors.white, size: 24),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   'MediCare',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 32),
//           // Menu Items
//           _buildMenuItem(
//             context,
//             ref,
//             icon: Icons.dashboard,
//             label: 'Dashboard',
//             screen: AppScreen.dashboard,
//             isSelected: currentScreen == AppScreen.dashboard,
//           ),
//           _buildMenuItem(
//             context,
//             ref,
//             icon: Icons.medical_services,
//             label: 'Nurse Dashboard',
//             screen: AppScreen.nursesDashboard,
//             isSelected: currentScreen == AppScreen.nursesDashboard,
//           ),
//           _buildMenuItem(
//             context,
//             ref,
//             icon: Icons.person,
//             label: 'Doctor Dashboard',
//             screen: AppScreen.doctorsDashboard,
//             isSelected: currentScreen == AppScreen.doctorsDashboard,
//           ),
//           _buildMenuItem(
//             context,
//             ref,
//             icon: Icons.people,
//             label: 'Patients',
//             screen: AppScreen.patients,
//             isSelected: currentScreen == AppScreen.patients,
//           ),
//           const Spacer(),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.red),
//             title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
//             onTap: () {},
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem(
//     BuildContext context,
//     WidgetRef ref, {
//     required IconData icon,
//     required String label,
//     required AppScreen screen,
//     required bool isSelected,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       decoration: BoxDecoration(
//         color: isSelected
//             ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
//             : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           color: isSelected
//               ? Theme.of(context).colorScheme.primary
//               : Colors.grey.shade600,
//         ),
//         title: Text(
//           label,
//           style: TextStyle(
//             color: isSelected
//                 ? Theme.of(context).colorScheme.primary
//                 : Colors.grey.shade800,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//           ),
//         ),
//         onTap: () => ref.read(currentScreenProvider.notifier).state = screen,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../theme/app_theme.dart';
// import '../providers/dashboard_providers.dart';
// import '../providers/auth_provider.dart';
// import '../models/auth_model.dart';
// import '../screens/auth_screen.dart'; // For redirection

// class SideBar extends ConsumerWidget {
//   const SideBar({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedIndex = ref.watch(selectedNavItemProvider);
//     final authState = ref.watch(authStateProvider);
//     final userRole = authState.userRole;
//     final theme = Theme.of(context);

//     String getRoleLabel() {
//       switch (userRole) {
//         case UserRole.admin:
//           return "Administrator";
//         case UserRole.doctor:
//           return "Doctor";
//         case UserRole.nurse:
//           return "Nurse";
//         default:
//           return "Guest";
//       }
//     }

//     return Container(
//       width: 250,
//       color: theme.colorScheme.secondary, // Use theme background
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Hospify",
//             style: theme.textTheme.headlineSmall?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: theme.colorScheme.primary,
//             ),
//           ),
//           const SizedBox(height: 24),

//           // Role Badge
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             decoration: BoxDecoration(
//               color: theme.colorScheme.surface,
//               borderRadius: BorderRadius.circular(8),
//               border:
//                   Border.all(color: theme.colorScheme.primary.withOpacity(0.5)),
//             ),
//             child: Center(
//               child: Text(
//                 getRoleLabel(),
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: theme.colorScheme.primary,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 32),

//           Text(
//             "Medical Suite",
//             style: theme.textTheme.bodySmall
//                 ?.copyWith(color: theme.colorScheme.onSecondary),
//           ),
//           const SizedBox(height: 16),

//           // Nav items
//           _buildNavItem(
//               context, ref, 0, "Dashboard", Icons.grid_view, selectedIndex == 0,
//               theme: theme),
//           _buildNavItem(context, ref, 1, "Doctor Dashboard",
//               Icons.person_outline, selectedIndex == 1,
//               theme: theme),
//           _buildNavItem(context, ref, 2, "Nurse Dashboard",
//               Icons.medical_services_outlined, selectedIndex == 2,
//               theme: theme),
//           _buildNavItem(context, ref, 3, "Settings", Icons.settings_outlined,
//               selectedIndex == 3,
//               theme: theme),

//           const Spacer(),

//           // Sign Out
//           _buildNavItem(
//             context,
//             ref,
//             99,
//             "Sign Out",
//             Icons.logout,
//             false,
//             color: Colors.redAccent,
//             theme: theme,
//             onTap: () async {
//               await ref.read(authStateProvider.notifier).signOut();
//               if (context.mounted) {
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (_) => const AuthScreen()),
//                   (route) => false,
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(
//     BuildContext context,
//     WidgetRef ref,
//     int index,
//     String title,
//     IconData icon,
//     bool isSelected, {
//     Color? color,
//     VoidCallback? onTap,
//     required ThemeData theme,
//   }) {
//     final textColor = color ??
//         (isSelected
//             ? theme.colorScheme.onPrimary
//             : theme.textTheme.bodyMedium?.color);
//     final iconColor = color ??
//         (isSelected
//             ? theme.colorScheme.onPrimary
//             : theme.textTheme.bodyMedium?.color);
//     final bgColor = isSelected ? theme.colorScheme.primary : Colors.transparent;

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap ??
//             () => ref.read(selectedNavItemProvider.notifier).state = index,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 4),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: iconColor, size: 20),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: textColor,
//                     fontWeight:
//                         isSelected ? FontWeight.w600 : FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//---------------------------------------------04-1-2025-----------------------------//

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/auth_model.dart';
// import '../providers/auth_provider.dart';

// class MenuItem {
//   final IconData icon;
//   final String label;
//   final int? count;
//   final List<UserRole> allowedRoles;
//   final AppScreen? screen;

//   MenuItem({
//     required this.icon,
//     required this.label,
//     this.count,
//     required this.allowedRoles,
//     this.screen,
//   });
// }

// class Sidebar extends ConsumerWidget {
//   final bool isMobile;
//   final VoidCallback? onClose;

//   const Sidebar({
//     super.key,
//     this.isMobile = false,
//     this.onClose,
//   });

//   static final List<MenuItem> _menuItems = [
//     MenuItem(
//       icon: Icons.dashboard_outlined,
//       label: 'Admin Dashboard',
//       allowedRoles: [UserRole.admin],
//       screen: AppScreen.dashboard,
//     ),
//     MenuItem(
//       icon: Icons.medical_services_outlined,
//       label: 'Doctor Dashboard',
//       allowedRoles: [UserRole.doctor],
//       screen: AppScreen.doctorsDashboard,
//     ),
//     MenuItem(
//       icon: Icons.local_hospital_outlined,
//       label: 'Nurse Dashboard',
//       allowedRoles: [UserRole.nurse],
//       screen: AppScreen.nursesDashboard,
//     ),
//     MenuItem(
//       icon: Icons.people_outlined,
//       label: 'Patients',
//       allowedRoles: [UserRole.admin, UserRole.doctor, UserRole.nurse],
//       screen: AppScreen.patients,
//     ),
//     MenuItem(
//       icon: Icons.calendar_today_outlined,
//       label: 'Appointments',
//       allowedRoles: [UserRole.admin, UserRole.doctor],
//       screen: AppScreen.appointments,
//     ),
//     MenuItem(
//       icon: Icons.analytics_outlined,
//       label: 'Analytics',
//       allowedRoles: [UserRole.admin],
//       screen: AppScreen.analytics,
//     ),
//     MenuItem(
//       icon: Icons.settings_outlined,
//       label: 'Settings',
//       allowedRoles: [UserRole.admin, UserRole.doctor, UserRole.nurse],
//       screen: AppScreen.settings,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(appUserProvider);
//     final userRole = user?.role ?? UserRole.nurse;
//     final currentScreen = ref.watch(currentScreenProvider);

//     final accessibleItems = _menuItems
//         .where((item) => item.allowedRoles.contains(userRole))
//         .toList();

//     final restrictedItems = _menuItems
//         .where((item) => !item.allowedRoles.contains(userRole))
//         .toList();

//     return Container(
//       width: isMobile ? double.infinity : 280,
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         border: Border(
//           right: BorderSide(
//             color: Theme.of(context).dividerColor,
//             width: 1,
//           ),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.all(24),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Theme.of(context).colorScheme.primary,
//                         Theme.of(context).colorScheme.secondary,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(Icons.local_hospital, color: Colors.white),
//                 ),
//                 const SizedBox(width: 12),
//                 const Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'MediCare',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Hospital Management',
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (isMobile)
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: onClose,
//                   ),
//               ],
//             ),
//           ),

//           // Role Badge
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: _getRoleColor(userRole).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//               border:
//                   Border.all(color: _getRoleColor(userRole).withOpacity(0.3)),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: _getRoleColor(userRole).withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(_getRoleIcon(userRole),
//                       color: _getRoleColor(userRole)),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(user?.name ?? 'User',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 14)),
//                       const SizedBox(height: 2),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 2),
//                         decoration: BoxDecoration(
//                           color: _getRoleColor(userRole),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Text(
//                           _getRoleLabel(userRole),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Menu Items
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ...accessibleItems.map((item) {
//                     final isSelected = currentScreen == item.screen;
//                     return _buildMenuItem(
//                         context, ref, item, isSelected, false);
//                   }),
//                   if (restrictedItems.isNotEmpty) ...[
//                     const SizedBox(height: 24),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                       child: Row(
//                         children: [
//                           Icon(Icons.lock_outline,
//                               size: 14, color: Colors.grey[400]),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Restricted Access',
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[400],
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ...restrictedItems.map((item) =>
//                         _buildMenuItem(context, ref, item, false, true)),
//                   ],
//                 ],
//               ),
//             ),
//           ),

//           // Sign Out
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: InkWell(
//               onTap: () => ref.read(authStateProvider.notifier).signOut(),
//               borderRadius: BorderRadius.circular(12),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.red.withOpacity(0.3)),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.logout, color: Colors.red, size: 20),
//                     SizedBox(width: 8),
//                     Text(
//                       'Sign Out',
//                       style: TextStyle(
//                           color: Colors.red, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem(
//     BuildContext context,
//     WidgetRef ref,
//     MenuItem item,
//     bool isSelected,
//     bool isRestricted,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: InkWell(
//         onTap: isRestricted || item.screen == null
//             ? null
//             : () {
//                 ref.read(currentScreenProvider.notifier).state = item.screen!;
//                 if (isMobile) onClose?.call();
//               },
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
//                 : null,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 item.icon,
//                 size: 22,
//                 color: isRestricted
//                     ? Colors.grey[400]
//                     : isSelected
//                         ? Theme.of(context).colorScheme.primary
//                         : Colors.grey[600],
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   item.label,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                     color: isRestricted
//                         ? Colors.grey[400]
//                         : isSelected
//                             ? Theme.of(context).colorScheme.primary
//                             : Colors.grey[800],
//                   ),
//                 ),
//               ),
//               if (item.count != null && !isRestricted)
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? Theme.of(context).colorScheme.primary
//                         : Colors.grey[200],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     '${item.count}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? Colors.white : Colors.grey[600],
//                     ),
//                   ),
//                 ),
//               if (isRestricted)
//                 Icon(Icons.lock, size: 16, color: Colors.grey[400]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getRoleColor(UserRole role) {
//     switch (role) {
//       case UserRole.admin:
//         return Colors.purple;
//       case UserRole.doctor:
//         return Colors.blue;
//       case UserRole.nurse:
//         return Colors.teal;
//     }
//   }

//   IconData _getRoleIcon(UserRole role) {
//     switch (role) {
//       case UserRole.admin:
//         return Icons.admin_panel_settings;
//       case UserRole.doctor:
//         return Icons.medical_services;
//       case UserRole.nurse:
//         return Icons.local_hospital;
//     }
//   }

//   String _getRoleLabel(UserRole role) {
//     switch (role) {
//       case UserRole.admin:
//         return 'ADMINISTRATOR';
//       case UserRole.doctor:
//         return 'DOCTOR';
//       case UserRole.nurse:
//         return 'NURSE';
//     }
//   }
// }

//-----------------05-01-2026--------------------------------//

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/auth_model.dart';
// import '../providers/auth_provider.dart';

// class MenuItem {
//   final IconData icon;
//   final String label;
//   final int? count;
//   final List<UserRole> allowedRoles;
//   final AppScreen? screen;

//   MenuItem({
//     required this.icon,
//     required this.label,
//     this.count,
//     required this.allowedRoles,
//     this.screen,
//   });
// }

// class Sidebar extends ConsumerWidget {
//   final bool isMobile;
//   final VoidCallback? onClose;

//   const Sidebar({
//     super.key,
//     this.isMobile = false,
//     this.onClose,
//   });

//   /// ✅ ADMIN HAS ACCESS TO EVERYTHING
//   static final List<MenuItem> _menuItems = [
//     MenuItem(
//       icon: Icons.dashboard_outlined,
//       label: 'Admin Dashboard',
//       allowedRoles: [UserRole.admin],
//       screen: AppScreen.dashboard,
//     ),
//     MenuItem(
//       icon: Icons.medical_services_outlined,
//       label: 'Doctor Dashboard',
//       allowedRoles: [UserRole.admin, UserRole.doctor],
//       screen: AppScreen.doctorsDashboard,
//     ),
//     MenuItem(
//       icon: Icons.local_hospital_outlined,
//       label: 'Nurse Dashboard',
//       allowedRoles: [UserRole.admin, UserRole.nurse],
//       screen: AppScreen.nursesDashboard,
//     ),

//     /// -------- Patient Flow --------
//     MenuItem(
//       icon: Icons.people_outlined,
//       label: 'Patients',
//       allowedRoles: [UserRole.admin, UserRole.doctor, UserRole.nurse],
//       screen: AppScreen.patients,
//     ),
//     MenuItem(
//       icon: Icons.login_outlined,
//       label: 'Admissions',
//       allowedRoles: [UserRole.admin, UserRole.nurse],
//       screen: AppScreen.admissions,
//     ),
//     MenuItem(
//       icon: Icons.logout_outlined,
//       label: 'Discharges',
//       allowedRoles: [UserRole.admin, UserRole.nurse],
//       screen: AppScreen.discharges,
//     ),

//     /// -------- Scheduling --------
//     MenuItem(
//       icon: Icons.calendar_today_outlined,
//       label: 'Appointments',
//       allowedRoles: [UserRole.admin, UserRole.doctor],
//       screen: AppScreen.appointments,
//     ),

//     /// -------- Admin --------
//     MenuItem(
//       icon: Icons.analytics_outlined,
//       label: 'Analytics',
//       allowedRoles: [UserRole.admin],
//       screen: AppScreen.analytics,
//     ),
//     MenuItem(
//       icon: Icons.settings_outlined,
//       label: 'Settings',
//       allowedRoles: [UserRole.admin, UserRole.doctor, UserRole.nurse],
//       screen: AppScreen.settings,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(appUserProvider);
//     final userRole = user?.role ?? UserRole.nurse;
//     final currentScreen = ref.watch(currentScreenProvider);

//     final accessibleItems =
//         _menuItems.where((e) => e.allowedRoles.contains(userRole)).toList();

//     final restrictedItems =
//         _menuItems.where((e) => !e.allowedRoles.contains(userRole)).toList();

//     return Container(
//       width: isMobile ? double.infinity : 280,
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         border: Border(
//           right: BorderSide(
//             color: Theme.of(context).dividerColor,
//             width: 1,
//           ),
//         ),
//       ),
//       child: Column(
//         children: [
//           /// Header
//           _buildHeader(context),

//           /// Role Badge
//           _buildRoleBadge(user, userRole),

//           const SizedBox(height: 16),

//           /// Menu Items
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 children: [
//                   ...accessibleItems.map((item) {
//                     final isSelected = currentScreen == item.screen;
//                     return _buildMenuItem(
//                         context, ref, item, isSelected, false);
//                   }),
//                   if (restrictedItems.isNotEmpty) ...[
//                     const SizedBox(height: 24),
//                     _buildRestrictedLabel(),
//                     ...restrictedItems.map(
//                       (item) => _buildMenuItem(context, ref, item, false, true),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),

//           /// Sign Out
//           _buildLogout(ref),
//         ],
//       ),
//     );
//   }

//   // ---------------- UI Helpers ----------------

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Theme.of(context).colorScheme.primary,
//                   Theme.of(context).colorScheme.secondary,
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.local_hospital, color: Colors.white),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('MediCare',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 Text('Hospital Management',
//                     style: TextStyle(fontSize: 12, color: Colors.grey)),
//               ],
//             ),
//           ),
//           if (isMobile)
//             IconButton(icon: const Icon(Icons.close), onPressed: onClose),
//         ],
//       ),
//     );
//   }

//   Widget _buildRoleBadge(AppUser? user, UserRole role) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: _getRoleColor(role).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: _getRoleColor(role).withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Icon(_getRoleIcon(role), color: _getRoleColor(role)),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(user?.name ?? 'User',
//                     style: const TextStyle(fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 2),
//                 Text(_getRoleLabel(role),
//                     style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         color: _getRoleColor(role))),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRestrictedLabel() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: const [
//           Icon(Icons.lock_outline, size: 14, color: Colors.grey),
//           SizedBox(width: 8),
//           Text('Restricted Access',
//               style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogout(WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: InkWell(
//         onTap: () => ref.read(authStateProvider.notifier).signOut(),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.logout, color: Colors.red),
//             SizedBox(width: 8),
//             Text('Sign Out',
//                 style:
//                     TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem(BuildContext context, WidgetRef ref, MenuItem item,
//       bool isSelected, bool isRestricted) {
//     return InkWell(
//       onTap: isRestricted || item.screen == null
//           ? null
//           : () {
//               ref.read(currentScreenProvider.notifier).state = item.screen!;
//               if (isMobile) onClose?.call();
//             },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
//               : null,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(item.icon,
//                 color: isRestricted
//                     ? Colors.grey
//                     : isSelected
//                         ? Theme.of(context).colorScheme.primary
//                         : Colors.grey),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(item.label,
//                   style: TextStyle(
//                       fontWeight:
//                           isSelected ? FontWeight.w600 : FontWeight.w500)),
//             ),
//             if (isRestricted)
//               const Icon(Icons.lock, size: 16, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getRoleColor(UserRole role) {
//     switch (role) {
//       case UserRole.admin:
//         return Colors.purple;
//       case UserRole.doctor:
//         return Colors.blue;
//       case UserRole.nurse:
//         return Colors.teal;
//     }
//   }

//   IconData _getRoleIcon(UserRole role) {
//     switch (role) {
//       case UserRole.admin:
//         return Icons.admin_panel_settings;
//       case UserRole.doctor:
//         return Icons.medical_services;
//       case UserRole.nurse:
//         return Icons.local_hospital;
//     }
//   }

//   String _getRoleLabel(UserRole role) {
//     switch (role) {
//       case UserRole.admin:
//         return 'ADMINISTRATOR';
//       case UserRole.doctor:
//         return 'DOCTOR';
//       case UserRole.nurse:
//         return 'NURSE';
//     }
//   }
// }
//-----------------06-01-2026--------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_model.dart';
import '../providers/auth_provider.dart';
import '../providers/sidebar_state.dart';

class MenuItem {
  final IconData icon;
  final String label;
  final List<UserRole> allowedRoles;
  final AppScreen screen;

  const MenuItem({
    required this.icon,
    required this.label,
    required this.allowedRoles,
    required this.screen,
  });
}

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  static const double expandedWidth = 290;
  static const double collapsedWidth = 84;

  static final _menuItems = [
    // ───────────── DASHBOARDS ─────────────
    MenuItem(
      icon: Icons.dashboard_outlined,
      label: 'Admin Dashboard',
      allowedRoles: [UserRole.admin],
      screen: AppScreen.dashboard,
    ),
    MenuItem(
      icon: Icons.medical_services_outlined,
      label: 'Doctor Dashboard',
      allowedRoles: [UserRole.admin, UserRole.doctor],
      screen: AppScreen.doctorsDashboard,
    ),
    MenuItem(
      icon: Icons.local_hospital_outlined,
      label: 'Nurse Dashboard',
      allowedRoles: [UserRole.admin, UserRole.nurse],
      screen: AppScreen.nursesDashboard,
    ),

    // ───────────── GENERAL ─────────────
    MenuItem(
      icon: Icons.people_outline,
      label: 'Patients',
      allowedRoles: [UserRole.admin, UserRole.doctor, UserRole.nurse],
      screen: AppScreen.patients,
    ),
    MenuItem(
      icon: Icons.login_outlined,
      label: 'Admissions',
      allowedRoles: [UserRole.admin, UserRole.nurse],
      screen: AppScreen.admissions,
    ),
    MenuItem(
      icon: Icons.calendar_today_outlined,
      label: 'Appointments',
      allowedRoles: [UserRole.admin, UserRole.doctor],
      screen: AppScreen.appointments,
    ),

    // ───────────── ADMIN / NURSE FEATURES ─────────────

    // Admin only
    MenuItem(
      icon: Icons.calendar_month,
      label: 'Shift Scheduling',
      allowedRoles: [UserRole.admin],
      screen: AppScreen.shiftScheduling,
    ),

    // Admin + Nurse
    MenuItem(
      icon: Icons.notifications_active_outlined,
      label: 'Nurse Alerts',
      allowedRoles: [UserRole.admin, UserRole.nurse],
      screen: AppScreen.nurseAlerts,
    ),

    MenuItem(
      icon: Icons.alarm_outlined,
      label: 'Reminders',
      allowedRoles: [UserRole.admin, UserRole.nurse],
      screen: AppScreen.reminders,
    ),

    // ───────────── ADMIN ONLY ─────────────
    MenuItem(
      icon: Icons.analytics_outlined,
      label: 'Analytics',
      allowedRoles: [UserRole.admin],
      screen: AppScreen.analytics,
    ),

    // ───────────── SETTINGS ─────────────
    MenuItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      allowedRoles: [UserRole.admin, UserRole.doctor, UserRole.nurse],
      screen: AppScreen.settings,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);
    final role = user?.role ?? UserRole.nurse;
    final current = ref.watch(currentScreenProvider);
    final collapsed = ref.watch(sidebarCollapsedProvider);
    final hover = ref.watch(sidebarHoverProvider);

    // 🔥 Web breakpoint auto-collapse
    final width = MediaQuery.of(context).size.width;
    final autoCollapsed = width < 1100;

    final isCollapsed = autoCollapsed || collapsed;
    final showExpanded = !isCollapsed || hover;

    final visible =
        _menuItems.where((e) => e.allowedRoles.contains(role)).toList();

    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: MouseRegion(
        onEnter: (_) => ref.read(sidebarHoverProvider.notifier).state = true,
        onExit: (_) => ref.read(sidebarHoverProvider.notifier).state = false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          width: showExpanded ? expandedWidth : collapsedWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              right: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(.4),
              ),
            ),
          ),
          child: Column(
            children: [
              _header(context, ref, showExpanded),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: visible.map((item) {
                    return _menuTile(
                      context,
                      ref,
                      item,
                      current == item.screen,
                      showExpanded,
                    );
                  }).toList(),
                ),
              ),
              _logout(ref, showExpanded),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────── HEADER ─────────────────

  Widget _header(
    BuildContext context,
    WidgetRef ref,
    bool expanded,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        children: [
          const Icon(Icons.local_hospital, size: 30),
          if (expanded) ...[
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Hospify',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          IconButton(
            icon: Icon(expanded ? Icons.chevron_left : Icons.chevron_right),
            onPressed: () =>
                ref.read(sidebarCollapsedProvider.notifier).state = !expanded,
          ),
        ],
      ),
    );
  }

  // ───────────────── MENU TILE ─────────────────

  Widget _menuTile(
    BuildContext context,
    WidgetRef ref,
    MenuItem item,
    bool selected,
    bool expanded,
  ) {
    final primary = Theme.of(context).colorScheme.primary;

    return FocusableActionDetector(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      },
      actions: {
        ActivateIntent: CallbackAction(
          onInvoke: (_) =>
              ref.read(currentScreenProvider.notifier).state = item.screen,
        ),
      },
      child: Tooltip(
        message: expanded ? '' : item.label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: selected ? primary.withOpacity(.12) : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            hoverColor: primary.withOpacity(.08),
            onTap: () =>
                ref.read(currentScreenProvider.notifier).state = item.screen,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Icon(item.icon,
                      color: selected ? primary : Colors.grey.shade600),
                  if (expanded) ...[
                    const SizedBox(width: 14),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────── LOGOUT ─────────────────

  Widget _logout(WidgetRef ref, bool expanded) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => ref.read(authStateProvider.notifier).signOut(),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment:
                expanded ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: const [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Sign Out',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
