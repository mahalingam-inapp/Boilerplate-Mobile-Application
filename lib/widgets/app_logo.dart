import 'package:flutter/material.dart';

/// InApp logo shown on all pages. Replace with your own logo asset path.
/// Original: https://inapp.com/wp-content/uploads/2022/03/InApp-Logo-RGB-768x302.png
class AppLogo extends StatelessWidget {
  /// Max height of the logo. Width scales to preserve aspect ratio (768:302).
  final double maxHeight;
  final EdgeInsetsGeometry? padding;

  const AppLogo({
    Key? key,
    this.maxHeight = 40,
    this.padding,
  }) : super(key: key);

  static const String _assetPath = 'assets/images/inapp_logo.png';
  static const double _aspectRatio = 768 / 302;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Image.asset(
        _assetPath,
        height: maxHeight,
        width: maxHeight * _aspectRatio,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported_outlined, size: maxHeight, color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}
