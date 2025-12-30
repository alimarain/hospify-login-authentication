import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import '../widgets/sidebar.dart';
import '../theme/app_theme.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background, // ✅ Matches dark theme

      drawer: isMobile ? const Drawer(child: SideBar()) : null,

      appBar: isMobile
          ? AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
          : null,

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: SideBar()),
          Expanded(
            child: child, // The dashboard content
          ),
        ],
      ),
    );
  }
}
