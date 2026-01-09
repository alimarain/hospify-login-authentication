import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final user = ref.watch(appUserProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Clean, minimal header
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Card
                    _buildProfileCard(context, user),
                    const SizedBox(height: 16),

                    // Appearance Section
                    _buildSection(
                      context,
                      'Appearance',
                      Icons.palette_outlined,
                      const Color(0xFF8B5CF6),
                      [
                        _buildSwitchTile(
                          context,
                          'Dark Mode',
                          'Switch to dark theme',
                          Icons.dark_mode_outlined,
                          const Color(0xFF8B5CF6),
                          settings.darkMode,
                          () => ref
                              .read(settingsProvider.notifier)
                              .toggleDarkMode(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Notifications Section
                    _buildSection(
                      context,
                      'Notifications',
                      Icons.notifications_outlined,
                      const Color(0xFFF59E0B),
                      [
                        _buildSwitchTile(
                          context,
                          'Push Notifications',
                          'Receive push notifications',
                          Icons.notifications_active_outlined,
                          const Color(0xFFF59E0B),
                          settings.notifications,
                          () => ref
                              .read(settingsProvider.notifier)
                              .toggleNotifications(),
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          context,
                          'Email Alerts',
                          'Receive important updates via email',
                          Icons.email_outlined,
                          const Color(0xFFF59E0B),
                          settings.emailAlerts,
                          () => ref
                              .read(settingsProvider.notifier)
                              .toggleEmailAlerts(),
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          context,
                          'SMS Alerts',
                          'Receive urgent alerts via SMS',
                          Icons.sms_outlined,
                          const Color(0xFFF59E0B),
                          settings.smsAlerts,
                          () => ref
                              .read(settingsProvider.notifier)
                              .toggleSmsAlerts(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Regional Section
                    _buildSection(
                      context,
                      'Regional',
                      Icons.language_outlined,
                      const Color(0xFF10B981),
                      [
                        _buildDropdownTile(
                          context,
                          'Language',
                          'Select your preferred language',
                          Icons.translate_outlined,
                          const Color(0xFF10B981),
                          settings.language,
                          ['English', 'Spanish', 'French', 'German'],
                          (value) => ref
                              .read(settingsProvider.notifier)
                              .setLanguage(value),
                        ),
                        _buildDivider(),
                        _buildDropdownTile(
                          context,
                          'Date Format',
                          'Choose date display format',
                          Icons.calendar_today_outlined,
                          const Color(0xFF10B981),
                          settings.dateFormat,
                          ['MM/DD/YYYY', 'DD/MM/YYYY', 'YYYY-MM-DD'],
                          (value) => ref
                              .read(settingsProvider.notifier)
                              .setDateFormat(value),
                        ),
                        _buildDivider(),
                        _buildDropdownTile(
                          context,
                          'Time Format',
                          'Choose time display format',
                          Icons.access_time_outlined,
                          const Color(0xFF10B981),
                          settings.timeFormat,
                          ['12h', '24h'],
                          (value) => ref
                              .read(settingsProvider.notifier)
                              .setTimeFormat(value),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Security Section
                    _buildSection(
                      context,
                      'Security',
                      Icons.security_outlined,
                      const Color(0xFF14B8A6),
                      [
                        _buildActionTile(
                          context,
                          'Change Password',
                          'Update your password',
                          Icons.lock_outline,
                          const Color(0xFF14B8A6),
                          () => _showChangePasswordDialog(context),
                        ),
                        _buildDivider(),
                        _buildActionTile(
                          context,
                          'Two-Factor Authentication',
                          'Add an extra layer of security',
                          Icons.verified_user_outlined,
                          const Color(0xFF14B8A6),
                          () => _showComingSoon(
                              context, 'Two-Factor Authentication'),
                        ),
                        _buildDivider(),
                        _buildActionTile(
                          context,
                          'Active Sessions',
                          'Manage your active sessions',
                          Icons.devices_outlined,
                          const Color(0xFF14B8A6),
                          () => _showComingSoon(context, 'Active Sessions'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // About Section
                    _buildSection(
                      context,
                      'About',
                      Icons.info_outline,
                      const Color(0xFF6366F1),
                      [
                        _buildInfoTile(
                          context,
                          'Version',
                          '1.0.0',
                          Icons.info_outline,
                          const Color(0xFF6366F1),
                        ),
                        _buildDivider(),
                        _buildActionTile(
                          context,
                          'Terms of Service',
                          'Read our terms',
                          Icons.description_outlined,
                          const Color(0xFF6366F1),
                          () => _showComingSoon(context, 'Terms of Service'),
                        ),
                        _buildDivider(),
                        _buildActionTile(
                          context,
                          'Privacy Policy',
                          'Read our privacy policy',
                          Icons.privacy_tip_outlined,
                          const Color(0xFF6366F1),
                          () => _showComingSoon(context, 'Privacy Policy'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Danger Zone Section
                    _buildSection(
                      context,
                      'Danger Zone',
                      Icons.warning_outlined,
                      const Color(0xFFEF4444),
                      [
                        _buildDangerTile(
                          context,
                          'Sign Out',
                          'Sign out from all devices',
                          Icons.logout,
                          () async {
                            final confirmed = await _showConfirmDialog(
                              context,
                              'Sign Out',
                              'Are you sure you want to sign out from all devices?',
                            );
                            if (confirmed == true) {
                              final authNotifier =
                                  ref.read(authStateProvider.notifier);
                              await authNotifier.signOut();
                            }
                          },
                        ),
                        _buildDivider(),
                        _buildDangerTile(
                          context,
                          'Delete Account',
                          'Permanently delete your account',
                          Icons.delete_forever,
                          () => _showDeleteAccountDialog(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    Color accentColor,
    List<Widget> children,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 18, color: accentColor),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, dynamic user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                user?.name?.substring(0, 1).toUpperCase() ?? 'A',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? 'admin@hospital.com',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? 'admin@hospital.com',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _showComingSoon(context, 'Edit Profile'),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5).withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: Color(0xFF4F46E5),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color accentColor,
    bool value,
    VoidCallback onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: (_) => onChanged(),
              activeColor: accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color accentColor,
    String currentValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: currentValue,
              underline: const SizedBox(),
              isDense: true,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color accentColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: accentColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFFD1D5DB),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  const Icon(Icons.logout, size: 20, color: Color(0xFFEF4444)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFFEF4444),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 54,
      thickness: 1,
      color: Color(0xFFF3F4F6),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF4F46E5),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<bool?> _showConfirmDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFF59E0B),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          bool obscureCurrent = true;
          bool obscureNew = true;
          bool obscureConfirm = true;

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.lock_reset,
                    color: Color(0xFF14B8A6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Change Password'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: currentPasswordController,
                    obscureText: obscureCurrent,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureCurrent
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => obscureCurrent = !obscureCurrent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newPasswordController,
                    obscureText: obscureNew,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureNew ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => obscureNew = !obscureNew),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: obscureConfirm,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => obscureConfirm = !obscureConfirm),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password updated successfully!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14B8A6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Update'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.delete_forever,
                color: Color(0xFFEF4444),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Delete Account'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure you want to delete your account?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              'This action cannot be undone. All your data will be permanently deleted.',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFEF4444).withOpacity(0.2),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This will permanently delete your account',
                      style: TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}
