import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateProvider<bool>((ref) => false);

/// Expose ThemeMode for MaterialApp. Dark when darkModeProvider is true.
final themeModeProvider = Provider<ThemeMode>((ref) {
  final isDark = ref.watch(darkModeProvider);
  return isDark ? ThemeMode.dark : ThemeMode.light;
});
