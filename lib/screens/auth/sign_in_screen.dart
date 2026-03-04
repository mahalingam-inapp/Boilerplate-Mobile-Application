import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/auth_notifier.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_button.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool isEmailMode = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneOrEmailController = TextEditingController();
  final _otpController = TextEditingController();
  bool loading = false;
  bool otpSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneOrEmailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSignIn() async {
    setState(() => loading = true);
    try {
      await ref.read(authProvider.notifier).signIn(
            _emailController.text.trim(),
            _passwordController.text,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome back!'), backgroundColor: AppColors.primary),
        );
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials'), backgroundColor: AppColors.destructive),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _handleSendOTP() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        loading = false;
        otpSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent successfully'), backgroundColor: AppColors.primary),
      );
    }
  }

  Future<void> _handleOTPSignIn() async {
    setState(() => loading = true);
    try {
      await ref.read(authProvider.notifier).signInWithOTP(
            _phoneOrEmailController.text.trim(),
            _otpController.text,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome back!'), backgroundColor: AppColors.primary),
        );
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP'), backgroundColor: AppColors.destructive),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
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
                  children: [
                    const Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Text('Sign in to continue', style: TextStyle(color: AppColors.mutedForeground)),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => isEmailMode = true),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isEmailMode ? AppColors.primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                    ),
                                    child: Text('Email', textAlign: TextAlign.center,
                                        style: TextStyle(color: isEmailMode ? AppColors.primaryForeground : AppColors.mutedForeground)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => isEmailMode = false),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: !isEmailMode ? AppColors.primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                    ),
                                    child: Text('OTP', textAlign: TextAlign.center,
                                        style: TextStyle(color: !isEmailMode ? AppColors.primaryForeground : AppColors.mutedForeground)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          if (isEmailMode) ...[
                            TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email address',
                                prefixIcon: Icon(Icons.mail_outline, size: 20, color: AppColors.mutedForeground),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline, size: 20, color: AppColors.mutedForeground),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => context.push('/auth/reset-password'),
                                child: const Text('Forgot password?', style: TextStyle(color: AppColors.primary)),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                label: loading ? 'Signing in...' : 'Sign In',
                                onPressed: loading ? null : _handleEmailSignIn,
                                isLoading: loading,
                              ),
                            ),
                          ] else ...[
                            if (!otpSent) ...[
                              TextField(
                                controller: _phoneOrEmailController,
                                decoration: const InputDecoration(
                                  hintText: 'Phone or Email',
                                  prefixIcon: Icon(Icons.smartphone, size: 20, color: AppColors.mutedForeground),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                  label: loading ? 'Sending...' : 'Send OTP',
                                  onPressed: loading ? null : _handleSendOTP,
                                  isLoading: loading,
                                ),
                              ),
                            ] else ...[
                              Text('Enter the OTP sent to ${_phoneOrEmailController.text}', style: const TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                decoration: const InputDecoration(hintText: 'Enter OTP'),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                  label: loading ? 'Verifying...' : 'Verify OTP',
                                  onPressed: loading ? null : _handleOTPSignIn,
                                  isLoading: loading,
                                ),
                              ),
                              TextButton(
                                onPressed: () => setState(() => otpSent = false),
                                child: const Text('Resend OTP', style: TextStyle(color: AppColors.primary)),
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: TextStyle(color: AppColors.mutedForeground)),
                        TextButton(
                          onPressed: () => context.push('/auth/signup'),
                          child: const Text('Sign up', style: TextStyle(color: AppColors.primary)),
                        ),
                      ],
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
