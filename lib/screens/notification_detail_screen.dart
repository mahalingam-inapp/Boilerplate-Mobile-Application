import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String id;
  final String title;
  final String message;
  final String time;
  final String type;

  const NotificationDetailScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
  }) : super(key: key);

  static IconData _icon(String type) {
    switch (type) {
      case 'order': return Icons.local_shipping;
      case 'favorite': return Icons.favorite;
      case 'message': return Icons.message;
      case 'system': return Icons.settings;
      default: return Icons.notifications;
    }
  }

  static Color _iconColor(String type) {
    switch (type) {
      case 'order': return AppColors.chart1;
      case 'favorite': return Colors.pink;
      case 'message': return AppColors.chart4;
      case 'system': return AppColors.chart5;
      default: return AppColors.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Notification'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _iconColor(type).withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_icon(type), size: 24, color: _iconColor(type)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                            const SizedBox(height: 4),
                            Text(time, style: TextStyle(fontSize: 14, color: mutedColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(message, style: TextStyle(fontSize: 16, height: 1.5, color: theme.colorScheme.onSurface)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Back to Notifications',
              variant: AppButtonVariant.outline,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
