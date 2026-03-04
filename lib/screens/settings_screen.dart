import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text('Manage your preferences', style: TextStyle(color: AppColors.mutedForeground)),
          const SizedBox(height: 24),
          _section('Preferences', [
            _SettingsRow(icon: Icons.dark_mode, label: 'Dark Mode', isToggle: true, value: darkMode, onToggle: () => setState(() => darkMode = !darkMode)),
            _SettingsRow(icon: Icons.notifications, label: 'Push Notifications', isToggle: true, value: notifications, onToggle: () => setState(() => notifications = !notifications)),
            _SettingsRow(icon: Icons.language, label: 'Language', trailing: language, path: '/settings/language'),
          ]),
          const SizedBox(height: 24),
          _section('Security', [
            _SettingsRow(icon: Icons.lock, label: 'Change Password', path: '/auth/reset-password'),
          ]),
          const SizedBox(height: 24),
          _section('Support', [
            _SettingsRow(icon: Icons.help_outline, label: 'Help Center', path: '/help'),
            _SettingsRow(icon: Icons.info_outline, label: 'About', path: '/settings/about'),
          ]),
          const SizedBox(height: 24),
          _section('Legal', [
            _SettingsRow(icon: Icons.description, label: 'Terms & Conditions', path: '/terms'),
            _SettingsRow(icon: Icons.shield, label: 'Privacy Policy', path: '/privacy'),
          ]),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                Text('Version 1.0.0', style: TextStyle(color: AppColors.mutedForeground)),
                const SizedBox(height: 4),
                Text('© 2026 WhiteLabel App. All rights reserved.', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(title, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: items.asMap().entries.map((e) => Column(
              children: [
                if (e.key > 0) const Divider(height: 1),
                e.value,
              ],
            )).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isToggle;
  final bool value;
  final VoidCallback? onToggle;
  final String? trailing;
  final String? path;

  const _SettingsRow({
    required this.icon,
    required this.label,
    this.isToggle = false,
    this.value = false,
    this.onToggle,
    this.trailing,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: path != null ? () => context.push(path!) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
            if (trailing != null) Text(trailing!, style: TextStyle(color: AppColors.mutedForeground)),
            if (isToggle)
              Switch(
                value: value,
                onChanged: (_) => onToggle?.call(),
                activeTrackColor: AppColors.primary,
              )
            else if (path != null)
              Icon(Icons.chevron_right, color: AppColors.mutedForeground),
          ],
        ),
      ),
    );
  }
}
