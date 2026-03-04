import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  static const _orders = [
    _Order(id: '12345', date: 'Mar 2, 2026', total: '\$149.99', status: 'Delivered', items: 'Wireless Headphones'),
    _Order(id: '12344', date: 'Feb 28, 2026', total: '\$89.50', status: 'Delivered', items: 'Office Chair'),
    _Order(id: '12343', date: 'Feb 25, 2026', total: '\$234.00', status: 'Shipped', items: '2 items'),
    _Order(id: '12342', date: 'Feb 20, 2026', total: '\$45.00', status: 'Delivered', items: 'Desk Lamp'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Order History'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Your recent orders', style: TextStyle(fontSize: 14, color: mutedColor)),
            const SizedBox(height: 16),
            ..._orders.map((o) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                onTap: () => context.push('/orders/${o.id}'),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
                      child: Icon(Icons.receipt_long, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order #${o.id}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                          const SizedBox(height: 4),
                          Text(o.items, style: TextStyle(fontSize: 14, color: mutedColor)),
                          Text(o.date, style: TextStyle(fontSize: 12, color: mutedColor)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(o.total, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.greenSuccess.withOpacity(0.15), borderRadius: BorderRadius.circular(999)),
                          child: Text(o.status, style: const TextStyle(fontSize: 12, color: AppColors.greenSuccess)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _Order {
  final String id;
  final String date;
  final String total;
  final String status;
  final String items;
  const _Order({required this.id, required this.date, required this.total, required this.status, required this.items});
}
