// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';
// import '../utils/responsive_utils.dart';

// class DashboardHeader extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String userProfileName;
//   final String userRole;
//   final VoidCallback? onViewAllPressed;
//   final VoidCallback? onLogout;

//   const DashboardHeader({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     this.userProfileName = "Admin User",
//     this.userRole = "Administrator",
//     this.onViewAllPressed,
//     this.onLogout,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = ResponsiveUtils.isDesktop(context);

//     return Column(
//       children: [
//         // --- Top Row: Search & Profile ---
//         Row(
//           children: [
//             // Search Bar
//             Expanded(
//               child: Container(
//                 height: 48,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: AppTheme.cardColor,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: AppColors.border),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.search, color: AppColors.textSecondary),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: TextField(
//                         style: TextStyle(color: AppColors.textPrimary),
//                         decoration: InputDecoration(
//                           hintText: "Search patients, diagnosis...",
//                           hintStyle: TextStyle(color: AppColors.textMuted),
//                           border: InputBorder.none,
//                           isDense: true,
//                           contentPadding: EdgeInsets.zero,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 24),
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.notifications_none,
//                   color: AppColors.textSecondary),
//             ),
//             const SizedBox(width: 16),
//             // Profile
//             PopupMenuButton(
//               offset: const Offset(0, 50),
//               color: AppTheme.cardColor,
//               child: Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 18,
//                     backgroundColor: Colors.purple,
//                     child: Icon(Icons.security, size: 20, color: Colors.white),
//                   ),
//                   if (isDesktop) ...[
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(userProfileName,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 13,
//                                 color: AppColors.textPrimary)),
//                         Text(userRole,
//                             style: const TextStyle(
//                                 fontSize: 11, color: AppColors.textSecondary)),
//                       ],
//                     )
//                   ]
//                 ],
//               ),
//               itemBuilder: (context) => [
//                 PopupMenuItem(
//                   onTap: onLogout,
//                   child: const Row(children: [
//                     Icon(Icons.logout, color: Colors.red),
//                     SizedBox(width: 8),
//                     Text("Sign Out",
//                         style: TextStyle(color: AppColors.textPrimary))
//                   ]),
//                 )
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 32),
//         // --- Bottom Row: Title ---
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: const TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.textPrimary)),
//                 Text(subtitle,
//                     style: const TextStyle(color: AppColors.textSecondary)),
//               ],
//             ),
//             if (onViewAllPressed != null && isDesktop)
//               OutlinedButton(
//                 onPressed: onViewAllPressed,
//                 style: OutlinedButton.styleFrom(
//                     side: const BorderSide(color: AppColors.border),
//                     padding: const EdgeInsets.all(16)),
//                 child: const Text("View All Patients",
//                     style: TextStyle(color: AppColors.textPrimary)),
//               )
//           ],
//         ),
//       ],
//     );
//   }
// }

//''''''''''''''''''''''''''''''''''''''''''''''''''''''
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive_utils.dart';

class DashboardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String userProfileName;
  final String userRole;
  final VoidCallback? onViewAllPressed;
  final VoidCallback? onLogout;

  const DashboardHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.userProfileName = "Admin User",
    this.userRole = "Administrator",
    this.onViewAllPressed,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Column(
      children: [
        // --- Top Row: Search & Profile ---
        Row(
          children: [
            // Search Bar
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: TextField(
                        style: TextStyle(color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText: "Search patients, diagnosis...",
                          hintStyle: TextStyle(color: AppColors.textMuted),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none,
                  color: AppColors.textSecondary),
            ),
            const SizedBox(width: 16),
            // Profile
            PopupMenuButton(
              offset: const Offset(0, 50),
              color: AppTheme.cardColor,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.security, size: 20, color: Colors.white),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userProfileName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: AppColors.textPrimary)),
                        Text(userRole,
                            style: const TextStyle(
                                fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    )
                  ]
                ],
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: onLogout,
                  child: const Row(children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text("Sign Out",
                        style: TextStyle(color: AppColors.textPrimary))
                  ]),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        // --- Bottom Row: Title ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary)),
                Text(subtitle,
                    style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            if (onViewAllPressed != null && isDesktop)
              OutlinedButton(
                onPressed: onViewAllPressed,
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.all(16)),
                child: const Text("View All Patients",
                    style: TextStyle(color: AppColors.textPrimary)),
              )
          ],
        ),
      ],
    );
  }
}
