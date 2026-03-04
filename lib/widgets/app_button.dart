import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AppButtonVariant { primary, secondary, outline, ghost }
enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  final String label;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? leading;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.isLoading = false,
    this.leading,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    final sizePadding = switch (size) {
      AppButtonSize.sm => const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      AppButtonSize.md => const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      AppButtonSize.lg => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    };
    final fontSize = switch (size) {
      AppButtonSize.sm => 14.0,
      AppButtonSize.md => 16.0,
      AppButtonSize.lg => 18.0,
    };

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        else ...[
          if (leading != null) ...[leading!, const SizedBox(width: 8)],
          Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500)),
        ],
      ],
    );

    final (bg, fg, side) = switch (variant) {
      AppButtonVariant.primary => (
          disabled ? AppColors.primary.withValues(alpha: 0.5) : AppColors.primary,
          AppColors.primaryForeground,
          null as BorderSide?,
        ),
      AppButtonVariant.secondary => (
          disabled ? AppColors.secondary.withValues(alpha: 0.5) : AppColors.secondary,
          AppColors.secondaryForeground,
          null as BorderSide?,
        ),
      AppButtonVariant.outline => (
          Colors.transparent,
          AppColors.foreground,
          BorderSide(color: AppColors.border, width: 2),
        ),
      AppButtonVariant.ghost => (
          Colors.transparent,
          AppColors.foreground,
          null as BorderSide?,
        ),
    };

    return SizedBox(
      width: width,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: InkWell(
          onTap: disabled ? null : onPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Container(
            padding: sizePadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: side != null ? Border.all(color: side.color, width: side.width) : null,
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: fg, fontSize: fontSize, fontWeight: FontWeight.w500),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
