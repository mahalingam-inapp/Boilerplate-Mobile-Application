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
    Key? key,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.isLoading = false,
    this.leading,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    EdgeInsets sizePadding;
    double fontSize;
    switch (size) {
      case AppButtonSize.sm:
        sizePadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
        fontSize = 14.0;
        break;
      case AppButtonSize.md:
        sizePadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
        fontSize = 16.0;
        break;
      case AppButtonSize.lg:
        sizePadding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
        fontSize = 18.0;
        break;
    }

    Color bg;
    Color fg;
    BorderSide? side;
    switch (variant) {
      case AppButtonVariant.primary:
        bg = disabled ? AppColors.primary.withOpacity(0.5) : AppColors.primary;
        fg = AppColors.primaryForeground;
        side = null;
        break;
      case AppButtonVariant.secondary:
        bg = disabled ? AppColors.secondary.withOpacity(0.5) : AppColors.secondary;
        fg = AppColors.secondaryForeground;
        side = null;
        break;
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = AppColors.foreground;
        side = const BorderSide(color: AppColors.border, width: 2);
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = AppColors.foreground;
        side = null;
        break;
    }

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
