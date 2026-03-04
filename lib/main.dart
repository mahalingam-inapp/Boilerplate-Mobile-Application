import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'core/auth_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const BoilerplateApp());
}

class BoilerplateApp extends StatelessWidget {
  const BoilerplateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider();
    final router = createRouter(auth);
    return ChangeNotifierProvider<AuthProvider>.value(
      value: auth,
      child: MaterialApp.router(
        title: 'Boilerplate App',
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
