import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_button.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool loading = false;

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) return;
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _onKeyDown(int index, RawKeyEvent e) {
    if (e is RawKeyDownEvent && e.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  Future<void> _handleSubmit() async {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter complete OTP'), backgroundColor: AppColors.destructive),
      );
      return;
    }
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verified successfully'), backgroundColor: AppColors.primary),
      );
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, Color(0xFFF5F5F5)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back, size: 20, color: AppColors.mutedForeground),
                      label: const Text('Back', style: TextStyle(color: AppColors.mutedForeground)),
                    ),
                    const SizedBox(height: 24),
                    const Center(child: Text('Enter OTP', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        "We've sent a code to your phone/email",
                        style: TextStyle(color: AppColors.mutedForeground),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: SizedBox(
                                  width: 48,
                                  child: RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    onKey: (e) => _onKeyDown(i, e),
                                    child: TextField(
                                      controller: _controllers[i],
                                      focusNode: _focusNodes[i],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      onChanged: (v) => _onChanged(i, v),
                                      decoration: InputDecoration(
                                        counterText: '',
                                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                          borderSide: const BorderSide(color: AppColors.border, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                          borderSide: const BorderSide(color: AppColors.ring, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              label: loading ? 'Verifying...' : 'Verify OTP',
                              onPressed: loading ? null : _handleSubmit,
                              isLoading: loading,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('OTP sent again'), backgroundColor: AppColors.primary),
                              );
                            },
                            child: const Text('Resend OTP', style: TextStyle(color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
