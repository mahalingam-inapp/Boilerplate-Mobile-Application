import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

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
                  Text('Privacy Policy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
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
                _section('1. Information We Collect', 'We collect information that you provide directly to us, including: name and contact information, account credentials, profile information, transaction and payment information, communications with us.'),
                _section('2. How We Use Your Information', 'We use the information we collect to: provide, maintain, and improve our services; process transactions; send you technical notices and support messages; respond to your comments and questions; monitor and analyze trends and usage.'),
                _section('3. Information Sharing', 'We do not share your personal information with third parties except as described in this policy. We may share information with service providers who perform services on our behalf, with your consent, or as required by law.'),
                _section('4. Data Security', 'We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.'),
                _section('5. Your Rights', 'You have the right to: access and receive a copy of your personal data; correct inaccurate or incomplete data; request deletion of your data; object to or restrict processing; withdraw consent at any time.'),
                _section('6. Cookies and Tracking', 'We use cookies and similar tracking technologies to track activity on our app and hold certain information.'),
                _section('7. Children\'s Privacy', 'Our app is not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13.'),
                _section('8. Changes to This Policy', 'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.'),
                _section('9. Contact Us', 'If you have any questions about this Privacy Policy, please contact us at privacy@example.com'),
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
