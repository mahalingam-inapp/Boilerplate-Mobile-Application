import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class OrderDetailScreen extends StatelessWidget {
  final String id;

  const OrderDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: Text('Order #$id'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status', style: TextStyle(fontSize: 14, color: mutedColor)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.greenSuccess.withOpacity(0.15), borderRadius: BorderRadius.circular(999)),
                        child: const Text('Delivered', style: TextStyle(fontSize: 12, color: AppColors.greenSuccess, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _DetailRow(label: 'Order ID', value: id),
                  _DetailRow(label: 'Date', value: 'Mar 2, 2026'),
                  _DetailRow(label: 'Total', value: '\$149.99'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 12),
                  Text('Wireless Headphones × 1', style: TextStyle(fontSize: 14, color: mutedColor)),
                  Text('\$149.99', style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(label: 'Track order', variant: AppButtonVariant.outline, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final mutedColor = Theme.of(context).brightness == Brightness.dark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: mutedColor)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }
}
