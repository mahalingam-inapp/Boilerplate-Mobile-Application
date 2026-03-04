import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_state.dart';

/// Notifier for router refresh when auth state changes (go_router 12).
final ChangeNotifier authRefreshListenable = ChangeNotifier();

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(loading: false));

  /// Default profile avatar asset. Used when user has no custom avatar.
  static const String defaultAvatarAsset = 'assets/images/profile_avatar.png';

  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final parts = email.split('@');
    state = AuthState(
      user: User(
        id: '1',
        email: email,
        name: parts.isNotEmpty ? parts[0] : email,
        avatar: defaultAvatarAsset,
      ),
    );
    authRefreshListenable.notifyListeners();
  }

  Future<void> signInWithOTP(String phoneOrEmail, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    final isEmail = phoneOrEmail.contains('@');
    final name = isEmail ? phoneOrEmail.split('@')[0] : 'User';
    state = AuthState(
      user: User(
        id: '1',
        email: isEmail ? phoneOrEmail : '',
        phone: isEmail ? '' : phoneOrEmail,
        name: name,
        avatar: defaultAvatarAsset,
      ),
    );
    authRefreshListenable.notifyListeners();
  }

  Future<void> signUp(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 1));
    state = AuthState(
      user: User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        avatar: defaultAvatarAsset,
      ),
    );
    authRefreshListenable.notifyListeners();
  }

  void signOut() {
    state = const AuthState();
    authRefreshListenable.notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  void updateProfile(Map<String, dynamic> data) {
    final u = state.user;
    if (u == null) return;
    state = AuthState(
      user: User(
        id: u.id,
        email: data['email'] as String? ?? u.email,
        phone: data['phone'] as String? ?? u.phone,
        name: data['name'] as String? ?? u.name,
        avatar: data['avatar'] as String? ?? u.avatar,
      ),
    );
    authRefreshListenable.notifyListeners();
  }
}
