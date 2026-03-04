import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_button.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _emailController = TextEditingController();
  bool loading = false;
  bool sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    setState(() => loading = true);
    try {
      await context.read<AuthProvider>().resetPassword(_emailController.text.trim());
      if (mounted) {
        setState(() {
          loading = false;
          sent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reset link sent to your email'), backgroundColor: AppColors.primary),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send reset link'), backgroundColor: AppColors.destructive),
        );
      }
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
                      label: const Text('Back to Sign In', style: TextStyle(color: AppColors.mutedForeground)),
                    ),
                    const SizedBox(height: 24),
                    const Center(child: Text('Reset Password', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        sent ? 'Check your email' : 'Enter your email to reset password',
                        style: const TextStyle(color: AppColors.mutedForeground),
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
                      child: sent
                          ? Column(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.mail_outline, size: 32, color: AppColors.primary),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "We've sent a password reset link to ${_emailController.text}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: AppColors.mutedForeground),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: AppButton(
                                    label: 'Back to Sign In',
                                    onPressed: () => context.go('/auth/signin'),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: 'Email address',
                                    prefixIcon: Icon(Icons.mail_outline, size: 20, color: AppColors.mutedForeground),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: AppButton(
                                    label: loading ? 'Sending...' : 'Send Reset Link',
                                    onPressed: loading ? null : _handleSubmit,
                                    isLoading: loading,
                                  ),
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
