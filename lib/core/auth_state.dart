class User {
  final String id;
  final String email;
  final String phone;
  final String name;
  final String avatar;

  User({
    required this.id,
    required this.email,
    this.phone = '',
    required this.name,
    this.avatar = '',
  });
}

class AuthState {
  final User? user;
  final bool loading;

  const AuthState({this.user, this.loading = false});

  bool get isAuthenticated => user != null;
}


