import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hospify/utils/app_colors%20copy.dart';
import '../providers/auth_provider.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/dashboard_header.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userData = authState.userData;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHeader(
                title: 'Admin Dashboard',
                subtitle: 'Welcome back, ${userData?['first_name'] ?? 'Admin'}',
                color: AppColors.adminColor,
                icon: Icons.shield,
                onLogout: () => ref.read(authStateProvider.notifier).signOut(),
              ),
              const SizedBox(height: 32),

              // System Overview
              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: 'Total Staff',
                      value: '156',
                      icon: Icons.people,
                      color: AppColors.adminColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DashboardCard(
                      title: 'Departments',
                      value: '12',
                      icon: Icons.business,
                      color: Colors.cyan,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: 'Active Users',
                      value: '89',
                      icon: Icons.person_outline,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DashboardCard(
                      title: 'Pending',
                      value: '7',
                      icon: Icons.pending_actions,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Staff by Role
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Staff by Role',
                          style: TextStyle(
                            color: AppColors.foreground,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to staff management
                          },
                          child: const Text('Manage'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildStaffRoleItem(
                      'Nurses',
                      '68',
                      Icons.favorite,
                      AppColors.nurseColor,
                    ),
                    const SizedBox(height: 12),
                    _buildStaffRoleItem(
                      'Doctors',
                      '45',
                      Icons.medical_services,
                      AppColors.doctorColor,
                    ),
                    const SizedBox(height: 12),
                    _buildStaffRoleItem(
                      'Admins',
                      '12',
                      Icons.shield,
                      AppColors.adminColor,
                    ),
                    const SizedBox(height: 12),
                    _buildStaffRoleItem(
                      'Other Staff',
                      '31',
                      Icons.badge,
                      Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Admin Actions
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Admin Actions',
                      style: TextStyle(
                        color: AppColors.foreground,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      'User Management',
                      Icons.manage_accounts,
                      AppColors.adminColor,
                      () {},
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      'Add New Staff',
                      Icons.person_add,
                      Colors.green,
                      () {},
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      'Reset Passwords',
                      Icons.lock_reset,
                      Colors.orange,
                      () {},
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      'View Reports',
                      Icons.assessment,
                      Colors.blue,
                      () {},
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      'System Settings',
                      Icons.settings,
                      Colors.purple,
                      () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recent Activity
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Activity',
                          style: TextStyle(
                            color: AppColors.foreground,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildActivityItem(
                      'New user registered',
                      'Dr. Sarah Chen joined Cardiology',
                      '2 hours ago',
                      Icons.person_add,
                      Colors.green,
                    ),
                    _buildActivityItem(
                      'Password reset',
                      'Nurse John Doe password updated',
                      '5 hours ago',
                      Icons.lock_reset,
                      Colors.orange,
                    ),
                    _buildActivityItem(
                      'User deactivated',
                      'Dr. Mike Wilson account suspended',
                      '1 day ago',
                      Icons.person_off,
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaffRoleItem(
    String role,
    String count,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: const TextStyle(
                    color: AppColors.foreground,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$count members',
                  style: const TextStyle(
                    color: AppColors.mutedForeground,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.foreground,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mutedForeground,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.foreground,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.mutedForeground,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.mutedForeground,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
