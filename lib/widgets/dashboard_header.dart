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

// //''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/app_notification.dart';
import '../providers/notifications_provider.dart';
import '../utils/responsive_utils.dart';
import '../models/auth_model.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart'; // Ensure this import points to your AppTheme file

final searchQueryProvider = StateProvider<String>((ref) => "");

class DashboardHeader extends ConsumerStatefulWidget {
  const DashboardHeader({super.key});

  @override
  ConsumerState<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends ConsumerState<DashboardHeader>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchController;
  bool _isNotificationsHovered = false;
  bool _isProfileHovered = false;

  late final AnimationController _badgeAnimationController;
  late final Animation<double> _badgeScaleAnimation;
  late final Animation<Color?> _badgeColorAnimation;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _badgeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _badgeScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
          parent: _badgeAnimationController, curve: Curves.easeInOut),
    );

    // Pulse between Critical Red and a slightly lighter red
    _badgeColorAnimation = ColorTween(
      begin: AppTheme.statusCritical,
      end: const Color(0xFFFF5A5F),
    ).animate(
      CurvedAnimation(
          parent: _badgeAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _badgeAnimationController.dispose();
    super.dispose();
  }

  void _showNotificationsOverlay(BuildContext context) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => entry.remove(),
          child: Stack(
            children: [
              Positioned(
                top: 70,
                right: 20,
                width: 360, // Slightly wider for better readability
                child: Material(
                  color: Colors.transparent,
                  child: _AnimatedDropdown(
                    child: Consumer(
                      builder: (context, ref, _) {
                        final notifications = ref.watch(notificationsProvider);
                        final unreadCount =
                            ref.watch(unreadNotificationsCountProvider);

                        return Container(
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.dividerColor),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 16, 20, 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Notifications",
                                      style: GoogleFonts.inter(
                                        color: AppTheme.textPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    if (unreadCount > 0)
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(notificationsProvider
                                                  .notifier)
                                              .markAllAsRead();
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: AppTheme.primaryBlue,
                                          padding: EdgeInsets.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text("Mark all read",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                  ],
                                ),
                              ),
                              const Divider(
                                  height: 1, color: AppTheme.dividerColor),
                              // Notifications List
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 350),
                                child: notifications.isEmpty
                                    ? _emptyNotifications()
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: notifications.length,
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (_, __) =>
                                            const Divider(
                                                height: 1,
                                                indent: 20,
                                                endIndent: 20,
                                                color: AppTheme.dividerColor),
                                        itemBuilder: (context, index) {
                                          final n = notifications[index];
                                          return InkWell(
                                            onTap: () {
                                              ref
                                                  .read(notificationsProvider
                                                      .notifier)
                                                  .markAsRead(n.id);
                                            },
                                            child: _dropdownNotificationTile(n),
                                          );
                                        },
                                      ),
                              ),
                              const Divider(
                                  height: 1, color: AppTheme.dividerColor),
                              // Footer
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                child: TextButton(
                                  onPressed: () {
                                    ref
                                        .read(notificationsProvider.notifier)
                                        .clearAll();
                                    entry.remove();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppTheme.textSecondary,
                                  ),
                                  child: const Text("Clear all notifications",
                                      style: TextStyle(fontSize: 13)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    // ignore: unused_local_variable
    final isMobile = ResponsiveUtils.isMobile(context);

    Widget searchBar() {
      return Expanded(
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: "Search patients, diagnosis, or ward...",
            hintStyle:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            prefixIcon: const Icon(Icons.search,
                color: AppTheme.textSecondary, size: 20),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear,
                        color: AppTheme.textSecondary, size: 18),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                  )
                : null,
            filled: true,
            fillColor: AppTheme.surface, // Clean white search bar
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      );
    }

    Widget profileInfo() {
      final userName = authState.userData?['name'] ?? "User";
      final userRole = authState.userRole?.name.capitalize() ?? "Administrator";

      return MouseRegion(
        onEnter: (_) => setState(() => _isProfileHovered = true),
        onExit: (_) => setState(() => _isProfileHovered = false),
        child: AnimatedScale(
          scale: _isProfileHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppTheme.dividerColor),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primaryBlue,
                  radius: 16,
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : "U",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                            fontSize: 13)),
                    Text(userRole,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 11)),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_down,
                    size: 16, color: AppTheme.textSecondary)
              ],
            ),
          ),
        ),
      );
    }

    Widget notifications() {
      final unread = ref.watch(unreadNotificationsCountProvider);

      return MouseRegion(
        onEnter: (_) => setState(() => _isNotificationsHovered = true),
        onExit: (_) => setState(() => _isNotificationsHovered = false),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppTheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.dividerColor)),
              child: IconButton(
                icon: const Icon(Icons.notifications_none_rounded, size: 22),
                color: _isNotificationsHovered
                    ? AppTheme.primaryBlue
                    : AppTheme.textSecondary,
                onPressed: () => _showNotificationsOverlay(context),
              ),
            ),
            if (unread > 0)
              Positioned(
                right: 2,
                top: 2,
                child: AnimatedBuilder(
                  animation: _badgeAnimationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isNotificationsHovered
                          ? 1.1
                          : _badgeScaleAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: _badgeColorAnimation.value,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)),
                        constraints:
                            const BoxConstraints(minWidth: 18, minHeight: 18),
                        child: Center(
                          child: Text(
                            unread > 9 ? "9+" : unread.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.transparent,
      child: Row(
        children: [
          searchBar(),
          const SizedBox(width: 20),
          notifications(),
          const SizedBox(width: 16),
          profileInfo(),
        ],
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() =>
      isEmpty ? "" : "${this[0].toUpperCase()}${substring(1)}";
}

/// Animated dropdown helper
class _AnimatedDropdown extends StatefulWidget {
  final Widget child;
  const _AnimatedDropdown({required this.child});

  @override
  State<_AnimatedDropdown> createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<_AnimatedDropdown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

String _formatTime(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);
  if (difference.inSeconds < 60) return "Just now";
  if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
  if (difference.inHours < 24) return "${difference.inHours}h ago";
  if (difference.inDays < 7) return "${difference.inDays}d ago";
  return DateFormat.MMMd().format(timestamp);
}

Widget _dropdownNotificationTile(AppNotification n) {
  return Container(
    color:
        n.isRead ? Colors.transparent : AppTheme.primaryBlue.withOpacity(0.03),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iconForType(n),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    n.title,
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w700,
                    ),
                  ),
                  Text(_formatTime(n.timestamp),
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.textSecondary)),
                ],
              ),
              const SizedBox(height: 4),
              Text(n.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: AppTheme.textSecondary)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _iconForType(AppNotification n) {
  // Mapping notification types to AppTheme colors
  final colorMap = {
    NotificationType.admission: AppTheme.statusStable, // Green
    NotificationType.discharge: AppTheme.textSecondary, // Grey
    NotificationType.medication: AppTheme.statsPinkStart, // Pink
    NotificationType.appointment: AppTheme.statsBlueStart, // Blue
    NotificationType.alert: AppTheme.statusCritical, // Red
    NotificationType.task: AppTheme.statusWarning, // Orange
    NotificationType.system: AppTheme.textSecondary,
  };

  final iconMap = {
    NotificationType.admission: Icons.person_add_rounded,
    NotificationType.discharge: Icons.logout_rounded,
    NotificationType.medication: Icons.medication_rounded,
    NotificationType.appointment: Icons.calendar_today_rounded,
    NotificationType.alert: Icons.warning_amber_rounded,
    NotificationType.task: Icons.check_circle_outline_rounded,
    NotificationType.system: Icons.settings_rounded,
  };

  final color = colorMap[n.type] ?? AppTheme.primaryBlue;

  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      shape: BoxShape.circle,
    ),
    child: Icon(iconMap[n.type], color: color, size: 20),
  );
}

Widget _emptyNotifications() {
  return Padding(
    padding: const EdgeInsets.all(40),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration:
              BoxDecoration(color: AppTheme.background, shape: BoxShape.circle),
          child: Icon(Icons.notifications_off_outlined,
              size: 32, color: AppTheme.textSecondary.withOpacity(0.5)),
        ),
        const SizedBox(height: 16),
        const Text("No notifications",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary)),
        const SizedBox(height: 4),
        const Text("You're all caught up!",
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
      ],
    ),
  );
}
