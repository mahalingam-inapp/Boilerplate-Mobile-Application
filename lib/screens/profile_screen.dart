import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/auth_notifier.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/image_with_fallback.dart';

class _StatItem {
  final String label;
  final String value;
  const _StatItem(this.label, this.value);
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String path;
  const _MenuItem({required this.icon, required this.label, required this.path});
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const _stats = [
    _StatItem('Orders', '24'),
    _StatItem('Wishlist', '12'),
    _StatItem('Reviews', '8'),
  ];
  static const _menuItems = [
    _MenuItem(icon: Icons.edit, label: 'Edit Profile', path: '/profile/edit'),
    _MenuItem(icon: Icons.settings, label: 'Settings', path: '/settings'),
    _MenuItem(icon: Icons.location_on, label: 'Addresses', path: '/profile/addresses'),
    _MenuItem(icon: Icons.calendar_today, label: 'Order History', path: '/profile/orders'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ImageWithFallback(
                      src: user?.avatar ?? '',
                      alt: user?.name ?? 'User',
                      width: 96,
                      height: 96,
                      borderRadius: BorderRadius.circular(48),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.edit, size: 16, color: AppColors.primaryForeground),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(user?.name ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                if (user?.email != null && (user!.email).isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.mail_outline, size: 16, color: AppColors.mutedForeground),
                    const SizedBox(width: 8),
                    Text(user.email, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                  ]),
                ],
                if (user?.phone != null && (user!.phone).isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.phone_outlined, size: 16, color: AppColors.mutedForeground),
                    const SizedBox(width: 8),
                    Text(user.phone, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                  ]),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: _stats.map((s) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AppCard(
                  child: Column(
                    children: [
                      Text(s.value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text(s.label, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                    ],
                  ),
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: 24),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: _menuItems.map((item) => InkWell(
                onTap: () => context.push(item.path),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                        child: Icon(item.icon, size: 20, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(item.label)),
                      Icon(Icons.chevron_right, color: AppColors.mutedForeground),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Sign Out',
            variant: AppButtonVariant.outline,
            width: double.infinity,
            onPressed: () {
              ref.read(authProvider.notifier).signOut();
              context.go('/auth/signin');
            },
          ),
        ],
      ),
    );
  }
}
