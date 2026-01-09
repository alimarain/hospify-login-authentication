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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage your account and preferences',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),

            // Profile Section
            _buildSection(
              context,
              'Profile',
              Icons.person_outline,
              [
                _buildProfileCard(context, user),
              ],
            ),
            const SizedBox(height: 24),

            // Appearance
            _buildSection(
              context,
              'Appearance',
              Icons.palette_outlined,
              [
                _buildSwitchTile(
                  context,
                  'Dark Mode',
                  'Switch to dark theme',
                  Icons.dark_mode_outlined,
                  settings.darkMode,
                  () => ref.read(settingsProvider.notifier).toggleDarkMode(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Notifications
            _buildSection(
              context,
              'Notifications',
              Icons.notifications_outlined,
              [
                _buildSwitchTile(
                  context,
                  'Push Notifications',
                  'Receive push notifications',
                  Icons.notifications_active_outlined,
                  settings.notifications,
                  () =>
                      ref.read(settingsProvider.notifier).toggleNotifications(),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  context,
                  'Email Alerts',
                  'Receive important updates via email',
                  Icons.email_outlined,
                  settings.emailAlerts,
                  () => ref.read(settingsProvider.notifier).toggleEmailAlerts(),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  context,
                  'SMS Alerts',
                  'Receive urgent alerts via SMS',
                  Icons.sms_outlined,
                  settings.smsAlerts,
                  () => ref.read(settingsProvider.notifier).toggleSmsAlerts(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Regional
            _buildSection(
              context,
              'Regional',
              Icons.language_outlined,
              [
                _buildDropdownTile(
                  context,
                  'Language',
                  'Select your preferred language',
                  Icons.translate_outlined,
                  settings.language,
                  ['English', 'Spanish', 'French', 'German'],
                  (value) =>
                      ref.read(settingsProvider.notifier).setLanguage(value),
                ),
                _buildDivider(),
                _buildDropdownTile(
                  context,
                  'Date Format',
                  'Choose date display format',
                  Icons.calendar_today_outlined,
                  settings.dateFormat,
                  ['MM/DD/YYYY', 'DD/MM/YYYY', 'YYYY-MM-DD'],
                  (value) =>
                      ref.read(settingsProvider.notifier).setDateFormat(value),
                ),
                _buildDivider(),
                _buildDropdownTile(
                  context,
                  'Time Format',
                  'Choose time display format',
                  Icons.access_time_outlined,
                  settings.timeFormat,
                  ['12h', '24h'],
                  (value) =>
                      ref.read(settingsProvider.notifier).setTimeFormat(value),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Security
            _buildSection(
              context,
              'Security',
              Icons.security_outlined,
              [
                _buildActionTile(
                  context,
                  'Change Password',
                  'Update your password',
                  Icons.lock_outline,
                  () => _showChangePasswordDialog(context),
                ),
                _buildDivider(),
                _buildActionTile(
                  context,
                  'Two-Factor Authentication',
                  'Add an extra layer of security',
                  Icons.verified_user_outlined,
                  () {},
                ),
                _buildDivider(),
                _buildActionTile(
                  context,
                  'Active Sessions',
                  'Manage your active sessions',
                  Icons.devices_outlined,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // About
            _buildSection(
              context,
              'About',
              Icons.info_outline,
              [
                _buildInfoTile(
                  context,
                  'Version',
                  '1.0.0',
                  Icons.info_outline,
                ),
                _buildDivider(),
                _buildActionTile(
                  context,
                  'Terms of Service',
                  'Read our terms',
                  Icons.description_outlined,
                  () {},
                ),
                _buildDivider(),
                _buildActionTile(
                  context,
                  'Privacy Policy',
                  'Read our privacy policy',
                  Icons.privacy_tip_outlined,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Danger Zone
            _buildSection(
              context,
              'Danger Zone',
              Icons.warning_outlined,
              [
                _buildDangerTile(
                  context,
                  'Sign Out',
                  'Sign out from all devices',
                  Icons.logout,
                  () async {
                    final authNotifier = ref.read(authStateProvider.notifier);
                    await authNotifier
                        .signOut(); // calls your AuthNotifier.signOut()
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
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context, dynamic user) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                user?.name?.substring(0, 1) ?? 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? 'User Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? 'user@hospital.com',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Edit Profile'),
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
    bool value,
    VoidCallback onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) => onChanged(),
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
    String currentValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: currentValue,
            underline: const SizedBox(),
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
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: Colors.grey[600]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
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
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[600],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: Colors.red),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 66);
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
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
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
