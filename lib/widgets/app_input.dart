import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class AppInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final String? error;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;

  const AppInput({
    super.key,
    this.label,
    this.placeholder,
    this.error,
    this.obscureText = false,
    this.keyboardType,
    this.maxLength,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.foreground,
              ),
            ),
          ),
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: placeholder,
            errorText: error,
            prefixIcon: prefixIcon,
            contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              borderSide: const BorderSide(color: AppColors.destructive),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              error!,
              style: const TextStyle(fontSize: 12, color: AppColors.destructive),
            ),
          ),
      ],
    );
  }
}
