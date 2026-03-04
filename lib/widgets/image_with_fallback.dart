import 'package:flutter/material.dart';

class ImageWithFallback extends StatelessWidget {
  final String src;
  final String? alt;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ImageWithFallback({
    Key? key,
    required this.src,
    this.alt,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        src,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: const Color(0xFFF5F5F5),
          alignment: Alignment.center,
          child: Icon(Icons.broken_image_outlined, size: 40, color: Colors.grey.shade400),
        ),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFF5F5F5),
            alignment: Alignment.center,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      ),
    );
  }
}
