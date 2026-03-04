import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/auth_notifier.dart';
import 'screens/root_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/password_reset_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/item_list_screen.dart';
import 'screens/item_details_screen.dart';
import 'screens/search_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart';
import 'screens/create_form_screen.dart';
import 'screens/edit_form_screen.dart';
import 'screens/map_view_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/privacy_screen.dart';
import 'screens/not_found_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter(WidgetRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth/signin',
    refreshListenable: authRefreshListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final auth = ProviderScope.containerOf(context).read(authProvider);
      if (auth.loading) return null;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      if (isAuthRoute) return null;
      if (!auth.isAuthenticated) return '/auth/signin';
      if (state.matchedLocation == '/') return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth/signin',
        builder: (_, __) => const SignInScreen(),
      ),
      GoRoute(
        path: '/auth/signup',
        builder: (_, __) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/auth/reset-password',
        builder: (_, __) => const PasswordResetScreen(),
      ),
      GoRoute(
        path: '/auth/otp',
        builder: (_, __) => const OTPVerificationScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => RootScreen(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            pageBuilder: (_, __) => NoTransitionPage(child: const DashboardScreen()),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (_, __) => NoTransitionPage(child: const SearchScreen()),
          ),
          GoRoute(
            path: '/notifications',
            pageBuilder: (_, __) => NoTransitionPage(child: const NotificationsScreen()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (_, __) => NoTransitionPage(child: const ProfileScreen()),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (_, __) => NoTransitionPage(child: const SettingsScreen()),
          ),
          GoRoute(
            path: '/items',
            pageBuilder: (_, __) => NoTransitionPage(child: const ItemListScreen()),
          ),
          GoRoute(
            path: '/items/:id',
            builder: (_, state) => ItemDetailsScreen(id: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/profile/edit',
            builder: (_, __) => const EditProfileScreen(),
          ),
          GoRoute(
            path: '/create',
            builder: (_, __) => const CreateFormScreen(),
          ),
          GoRoute(
            path: '/edit/:id',
            builder: (_, state) => EditFormScreen(id: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/map',
            builder: (_, __) => const MapViewScreen(),
          ),
          GoRoute(
            path: '/terms',
            builder: (_, __) => const TermsScreen(),
          ),
          GoRoute(
            path: '/privacy',
            builder: (_, __) => const PrivacyScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/404',
        builder: (_, __) => const NotFoundScreen(),
      ),
    ],
    errorBuilder: (_, __) => const NotFoundScreen(),
  );
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return createAppRouter(ref);
});

class NoTransitionPage extends CustomTransitionPage<void> {
  NoTransitionPage({required Widget child})
      : super(
          child: child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return child;
          },
        );
}
