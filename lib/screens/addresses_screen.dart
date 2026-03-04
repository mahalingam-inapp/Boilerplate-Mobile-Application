import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  static const _addresses = [
    _Address(id: '1', label: 'Home', line1: '123 Main Street', line2: 'Apt 4B', city: 'New York, NY 10001', isDefault: true),
    _Address(id: '2', label: 'Work', line1: '456 Business Ave', line2: 'Suite 200', city: 'New York, NY 10002', isDefault: false),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Addresses'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Your saved addresses', style: TextStyle(fontSize: 14, color: mutedColor)),
            const SizedBox(height: 16),
            ..._addresses.map((a) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(a.label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                        if (a.isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(999)),
                            child: Text('Default', style: TextStyle(fontSize: 12, color: theme.colorScheme.primary)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(a.line1, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface)),
                    if (a.line2.isNotEmpty) Text(a.line2, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface)),
                    Text(a.city, style: TextStyle(fontSize: 14, color: mutedColor)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton(onPressed: () {}, child: const Text('Edit')),
                        TextButton(onPressed: () {}, child: const Text('Remove')),
                      ],
                    ),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 16),
            AppButton(label: 'Add new address', variant: AppButtonVariant.outline, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _Address {
  final String id;
  final String label;
  final String line1;
  final String line2;
  final String city;
  final bool isDefault;
  const _Address({required this.id, required this.label, required this.line1, required this.line2, required this.city, required this.isDefault});
}
