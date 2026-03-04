import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool clipBehavior;

  const AppCard({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    this.clipBehavior = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg * 1.5),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: clipBehavior
            ? ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusLg * 1.5),
                child: child,
              )
            : child,
      ),
    );
  }
}
