import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';
import '../widgets/sidebar.dart';
import 'dashboard_screen.dart';
import 'patients_screen.dart';
import 'appointments_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSection = ref.watch(currentSectionProvider);

    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: _buildContent(currentSection),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(DashboardSection section) {
    switch (section) {
      case DashboardSection.dashboard:
        return const DashboardScreen();
      case DashboardSection.patients:
        return const PatientsScreen();
      case DashboardSection.appointments:
        return const AppointmentsScreen();
      case DashboardSection.analytics:
        return const AnalyticsScreen();
      case DashboardSection.settings:
        return const SettingsScreen();
    }
  }
}
