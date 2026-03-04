import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_logo.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('About'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const AppLogo(maxHeight: 56),
            const SizedBox(height: 16),
            Text('Boilerplate App', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
            const SizedBox(height: 8),
            Text('Version 1.0.0', style: TextStyle(fontSize: 14, color: mutedColor)),
            const SizedBox(height: 24),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About this app', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 8),
                  Text('This is a boilerplate application demonstrating common screens and patterns. Replace this content with your own branding and description.', style: TextStyle(fontSize: 14, height: 1.5, color: mutedColor)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 8),
                  Text('support@example.com', style: TextStyle(fontSize: 14, color: theme.colorScheme.primary)),
                  Text('© 2026. All rights reserved.', style: TextStyle(fontSize: 12, color: mutedColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
