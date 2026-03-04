import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class RootScreen extends StatelessWidget {
  final Widget child;

  const RootScreen({super.key, required this.child});

  static const _navItems = [
    (path: '/dashboard', label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home),
    (path: '/search', label: 'Search', icon: Icons.search, activeIcon: Icons.search),
    (path: '/notifications', label: 'Notifications', icon: Icons.notifications_outlined, activeIcon: Icons.notifications),
    (path: '/profile', label: 'Profile', icon: Icons.person_outline, activeIcon: Icons.person),
    (path: '/settings', label: 'Settings', icon: Icons.settings_outlined, activeIcon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isAuthRoute = location.startsWith('/auth');

    if (isAuthRoute) {
      return Material(
        color: AppColors.background,
        child: child,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: child,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navItems.map((item) {
                final isActive = location == item.path;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.go(item.path),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isActive ? item.activeIcon : item.icon,
                            size: 20,
                            color: isActive ? AppColors.primary : AppColors.mutedForeground,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: isActive ? AppColors.primary : AppColors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
