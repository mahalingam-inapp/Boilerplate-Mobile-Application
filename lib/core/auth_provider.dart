import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  final String id;
  final String email;
  final String? phone;
  final String name;
  final String? avatar;

  User({
    required this.id,
    required this.email,
    this.phone,
    required this.name,
    this.avatar,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'phone': phone,
        'name': name,
        'avatar': avatar,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        name: json['name'] as String,
        avatar: json['avatar'] as String?,
      );
}

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _loading = true;

  User? get user => _user;
  bool get loading => _loading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _checkSession();
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUser = prefs.getString('user');
    final token = prefs.getString('token');
    final tokenExpiry = prefs.getString('tokenExpiry');

    if (storedUser != null && token != null && tokenExpiry != null) {
      final expiryDate = DateTime.tryParse(tokenExpiry);
      if (expiryDate != null && expiryDate.isAfter(DateTime.now())) {
        _user = User.fromJson(jsonDecode(storedUser) as Map<String, dynamic>);
      } else {
        await _clearStorage(prefs);
      }
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> _clearStorage(SharedPreferences prefs) async {
    await prefs.remove('user');
    await prefs.remove('token');
    await prefs.remove('tokenExpiry');
  }

  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = User(
      id: '1',
      email: email,
      name: email.split('@').first,
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=$email',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(_user!.toJson()));
    await prefs.setString('token', 'mock-jwt-token-${DateTime.now().millisecondsSinceEpoch}');
    await prefs.setString('tokenExpiry', DateTime.now().add(const Duration(hours: 1)).toIso8601String());
    notifyListeners();
  }

  Future<void> signInWithOTP(String phoneOrEmail, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = User(
      id: '1',
      email: phoneOrEmail.contains('@') ? phoneOrEmail : '',
      phone: phoneOrEmail.contains('@') ? null : phoneOrEmail,
      name: phoneOrEmail.contains('@') ? phoneOrEmail.split('@').first : 'User',
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=$phoneOrEmail',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(_user!.toJson()));
    await prefs.setString('token', 'mock-jwt-token-${DateTime.now().millisecondsSinceEpoch}');
    await prefs.setString('tokenExpiry', DateTime.now().add(const Duration(hours: 1)).toIso8601String());
    notifyListeners();
  }

  Future<void> signUp(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=$email',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(_user!.toJson()));
    await prefs.setString('token', 'mock-jwt-token-${DateTime.now().millisecondsSinceEpoch}');
    await prefs.setString('tokenExpiry', DateTime.now().add(const Duration(hours: 1)).toIso8601String());
    notifyListeners();
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await _clearStorage(prefs);
    _user = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    if (_user == null) return;
    _user = User(
      id: _user!.id,
      email: data['email'] as String? ?? _user!.email,
      phone: data['phone'] as String? ?? _user!.phone,
      name: data['name'] as String? ?? _user!.name,
      avatar: data['avatar'] as String? ?? _user!.avatar,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(_user!.toJson()));
    notifyListeners();
  }
}
