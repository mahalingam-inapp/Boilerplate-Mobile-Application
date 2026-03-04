import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, Color(0xFFF5F5F5)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('404', style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                const Text('Page Not Found', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Text(
                  "The page you're looking for doesn't exist or has been moved.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mutedForeground),
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: 'Back to Home',
                  leading: const Icon(Icons.home, size: 20, color: Colors.white),
                  onPressed: () => context.go('/dashboard'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
