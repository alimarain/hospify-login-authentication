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
import 'package:intl/intl.dart';
import '../models/app_notification.dart';
import '../providers/notifications_provider.dart';
import '../utils/responsive_utils.dart';
import '../models/auth_model.dart';
import '../providers/auth_provider.dart';

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

    _badgeColorAnimation = ColorTween(
      begin: Colors.redAccent,
      end: Colors.red.shade700,
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
    final theme = Theme.of(context);

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
                width: 320,
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
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Notifications",
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    if (unreadCount > 0)
                                      TextButton.icon(
                                        onPressed: () {
                                          ref
                                              .read(notificationsProvider
                                                  .notifier)
                                              .markAllAsRead();
                                        },
                                        icon: const Icon(Icons.done_all,
                                            size: 16),
                                        label: const Text("Mark all"),
                                      ),
                                  ],
                                ),
                              ),
                              const Divider(height: 1),
                              // Notifications List
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 300),
                                child: notifications.isEmpty
                                    ? _emptyNotifications(theme)
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: notifications.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(height: 1),
                                        itemBuilder: (context, index) {
                                          final n = notifications[index];
                                          return InkWell(
                                            onTap: () {
                                              ref
                                                  .read(notificationsProvider
                                                      .notifier)
                                                  .markAsRead(n.id);
                                            },
                                            child: _dropdownNotificationTile(
                                                theme, n),
                                          );
                                        },
                                      ),
                              ),
                              const Divider(height: 1),
                              // Footer
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(notificationsProvider.notifier)
                                      .clearAll();
                                  entry.remove();
                                },
                                child: const Text("Clear all notifications"),
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
    final isMobile = ResponsiveUtils.isMobile(context);

    Widget searchBar() {
      return Expanded(
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
          decoration: InputDecoration(
            hintText: "Search patients by name, diagnosis, bed, or ward...",
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
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
          scale: _isProfileHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
                radius: 18,
                child: Text(userName[0],
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(userRole,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                ],
              ),
            ],
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
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 28),
              onPressed: () => _showNotificationsOverlay(context),
            ),
            if (unread > 0)
              Positioned(
                right: 0,
                top: 0,
                child: AnimatedBuilder(
                  animation: _badgeAnimationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isNotificationsHovered
                          ? 1.3
                          : _badgeScaleAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: _badgeColorAnimation.value,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unread.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          searchBar(),
          const SizedBox(width: 16),
          notifications(),
          const SizedBox(width: 12),
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
        vsync: this, duration: const Duration(milliseconds: 180));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero)
        .animate(_fade);
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
  if (difference.inSeconds < 60) return "${difference.inSeconds}s ago";
  if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
  if (difference.inHours < 24) return "${difference.inHours}h ago";
  if (difference.inDays < 7) return "${difference.inDays}d ago";
  return DateFormat.yMMMd().add_jm().format(timestamp);
}

Widget _dropdownNotificationTile(ThemeData theme, AppNotification n) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iconForType(n),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                n.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(n.body,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7))),
              const SizedBox(height: 4),
              Text(_formatTime(n.timestamp),
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.4))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _iconForType(AppNotification n) {
  final colorMap = {
    NotificationType.admission: Colors.green,
    NotificationType.discharge: Colors.blue,
    NotificationType.medication: Colors.purple,
    NotificationType.appointment: Colors.orange,
    NotificationType.alert: Colors.red,
    NotificationType.task: Colors.indigo,
    NotificationType.system: Colors.grey,
  };
  final iconMap = {
    NotificationType.admission: Icons.person_add,
    NotificationType.discharge: Icons.exit_to_app,
    NotificationType.medication: Icons.medication,
    NotificationType.appointment: Icons.calendar_today,
    NotificationType.alert: Icons.warning_amber,
    NotificationType.task: Icons.task_alt,
    NotificationType.system: Icons.settings,
  };
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: colorMap[n.type]!.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8)),
    child: Icon(iconMap[n.type], color: colorMap[n.type], size: 18),
  );
}

Widget _emptyNotifications(ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Icon(Icons.notifications_off_outlined,
            size: 48, color: theme.colorScheme.onSurface.withOpacity(0.3)),
        const SizedBox(height: 8),
        Text("You're all caught up!",
            style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5))),
      ],
    ),
  );
}
