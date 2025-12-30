import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';
import '../theme/app_theme.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSection = ref.watch(currentSectionProvider);
    final isExpanded = ref.watch(sidebarExpandedProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isExpanded ? 240 : 72,
      color: AppTheme.secondary,
      child: Column(
        children: [
          // Logo
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.local_hospital, color: AppTheme.primary, size: 32),
                if (isExpanded) ...[
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'MediCare',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Navigation Items
          _buildNavItem(
            ref,
            icon: Icons.dashboard,
            label: 'Dashboard',
            section: DashboardSection.dashboard,
            isSelected: currentSection == DashboardSection.dashboard,
            isExpanded: isExpanded,
          ),
          _buildNavItem(
            ref,
            icon: Icons.people,
            label: 'Patients',
            section: DashboardSection.patients,
            isSelected: currentSection == DashboardSection.patients,
            isExpanded: isExpanded,
          ),
          _buildNavItem(
            ref,
            icon: Icons.calendar_today,
            label: 'Appointments',
            section: DashboardSection.appointments,
            isSelected: currentSection == DashboardSection.appointments,
            isExpanded: isExpanded,
          ),
          _buildNavItem(
            ref,
            icon: Icons.bar_chart,
            label: 'Analytics',
            section: DashboardSection.analytics,
            isSelected: currentSection == DashboardSection.analytics,
            isExpanded: isExpanded,
          ),
          const Spacer(),
          _buildNavItem(
            ref,
            icon: Icons.settings,
            label: 'Settings',
            section: DashboardSection.settings,
            isSelected: currentSection == DashboardSection.settings,
            isExpanded: isExpanded,
          ),
          const SizedBox(height: 16),
          // Toggle Button
          IconButton(
            onPressed: () {
              ref.read(sidebarExpandedProvider.notifier).state = !isExpanded;
            },
            icon: Icon(
              isExpanded ? Icons.chevron_left : Icons.chevron_right,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    WidgetRef ref, {
    required IconData icon,
    required String label,
    required DashboardSection section,
    required bool isSelected,
    required bool isExpanded,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(currentSectionProvider.notifier).state = section;
        },
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary.withOpacity(0.2) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? AppTheme.primary : Colors.white54,
                size: 22,
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? AppTheme.primary : Colors.white70,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
