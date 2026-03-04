import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class _NavItem {
  final String path;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  const _NavItem({required this.path, required this.label, required this.icon, required this.activeIcon});
}

class RootScreen extends StatelessWidget {
  final Widget child;

  const RootScreen({Key? key, required this.child}) : super(key: key);

  static const _navItems = [
    _NavItem(path: '/dashboard', label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home),
    _NavItem(path: '/search', label: 'Search', icon: Icons.search, activeIcon: Icons.search),
    _NavItem(path: '/notifications', label: 'Notifications', icon: Icons.notifications_outlined, activeIcon: Icons.notifications),
    _NavItem(path: '/profile', label: 'Profile', icon: Icons.person_outline, activeIcon: Icons.person),
    _NavItem(path: '/settings', label: 'Settings', icon: Icons.settings_outlined, activeIcon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isAuthRoute = location.startsWith('/auth');
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (isAuthRoute) {
      return Material(
        color: colorScheme.surface,
        child: child,
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: child,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color ?? colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outline)),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isActive ? item.activeIcon : item.icon,
                            size: 20,
                            color: isActive ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.7),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: isActive ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.7),
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
