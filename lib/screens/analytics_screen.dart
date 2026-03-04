import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Analytics'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Overview and insights', style: TextStyle(fontSize: 14, color: mutedColor)),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('This week', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 12),
                  _StatRow(label: 'Views', value: '12,450', change: '+8.2%'),
                  _StatRow(label: 'Conversions', value: '342', change: '+12.1%'),
                  _StatRow(label: 'Revenue', value: '\$8,290', change: '+5.4%'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top content', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 12),
                  Text('Wireless Headphones — 2,340 views', style: TextStyle(fontSize: 14, color: mutedColor)),
                  Text('Office Chair — 1,890 views', style: TextStyle(fontSize: 14, color: mutedColor)),
                  Text('Desk Lamp — 1,200 views', style: TextStyle(fontSize: 14, color: mutedColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final String change;

  const _StatRow({required this.label, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedColor = Theme.of(context).brightness == Brightness.dark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: mutedColor)),
          Row(
            children: [
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
              const SizedBox(width: 8),
              Text(change, style: const TextStyle(fontSize: 12, color: AppColors.greenSuccess)),
            ],
          ),
        ],
      ),
    );
  }
}
