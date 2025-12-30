import 'package:flutter/material.dart';
import 'package:hospify/utils/responsive_utils.dart'; // Ensure correct path
import '../widgets/sidebar.dart'; // Ensure correct path
import '../theme/app_theme.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Scaffold(
      backgroundColor: AppTheme.background,

      // 1. Mobile Drawer (Sidebar hides here on small screens)
      drawer: isMobile ? const Drawer(child: SideBar()) : null,

      // 2. Mobile AppBar (To open drawer)
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

      // 3. Desktop Layout: Fixed Sidebar + Child Content
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The Sidebar (Only one instance!)
          if (!isMobile) const SizedBox(width: 250, child: SideBar()),

          // The Content (Doctor/Nurse Dashboard)
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
