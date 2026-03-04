import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Terms & Conditions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  Text('Last updated: March 3, 2026', style: TextStyle(color: AppColors.mutedForeground)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section('1. Introduction', 'Welcome to our whitelabel mobile application. By accessing or using our app, you agree to be bound by these Terms and Conditions. Please read them carefully.'),
                _section('2. Use License', 'Permission is granted to temporarily access and use the app for personal, non-commercial purposes. This is the grant of a license, not a transfer of title, and under this license you may not: modify or copy the materials; use the materials for any commercial purpose; attempt to decompile or reverse engineer any software; remove any copyright or proprietary notations.'),
                _section('3. User Accounts', 'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.'),
                _section('4. Content', 'Users are solely responsible for any content they submit, post, or display. We reserve the right to remove any content that violates these terms or is otherwise objectionable.'),
                _section('5. Disclaimer', "The materials on our app are provided on an 'as is' basis. We make no warranties, expressed or implied."),
                _section('6. Limitations', 'In no event shall we or our suppliers be liable for any damages arising out of the use or inability to use our app.'),
                _section('7. Modifications', 'We may revise these terms at any time without notice. By using this app, you are agreeing to be bound by the then-current version.'),
                _section('8. Contact Information', 'If you have any questions about these Terms, please contact us at legal@example.com'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Text(body, style: TextStyle(color: AppColors.mutedForeground, height: 1.5)),
        ],
      ),
    );
  }
}
