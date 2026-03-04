import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class _Faq {
  final String id;
  final String question;
  final String answer;
  const _Faq({required this.id, required this.question, required this.answer});
}

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String? expandedId;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool loading = false;

  static const _faqs = [
    _Faq(id: '1', question: 'How do I create an account?', answer: "You can create an account by clicking the \"Sign Up\" button on the home screen and filling in your details. You can use either email or phone number to register."),
    _Faq(id: '2', question: 'How do I reset my password?', answer: "Click on \"Forgot Password\" on the sign-in screen, enter your email address, and we'll send you a reset link."),
    _Faq(id: '3', question: 'How do I track my order?', answer: 'Go to your Profile > Order History to see all your orders. Click on any order to view detailed tracking information.'),
    _Faq(id: '4', question: 'What payment methods do you accept?', answer: 'We accept all major credit cards, debit cards, and digital wallets. Payment processing is secure and encrypted.'),
    _Faq(id: '5', question: 'How can I contact customer support?', answer: 'You can reach us through the contact form below, send an email to support@example.com, or call our hotline at +1 (555) 123-4567.'),
    _Faq(id: '6', question: "What is your refund policy?", answer: "We offer a 30-day money-back guarantee on all products. If you're not satisfied, contact our support team for a full refund."),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        loading = false;
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Message sent! We'll get back to you soon."), backgroundColor: AppColors.primary),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Help & Support', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text("We're here to help you", style: TextStyle(color: AppColors.mutedForeground)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: AppCard(child: Column(children: [Icon(Icons.phone, size: 24, color: AppColors.primary), const SizedBox(height: 8), Text('Call Us', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground))])),
              const SizedBox(width: 12),
              Expanded(child: AppCard(child: Column(children: [Icon(Icons.mail, size: 24, color: AppColors.primary), const SizedBox(height: 8), Text('Email', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground))])),
              const SizedBox(width: 12),
              Expanded(child: AppCard(child: Column(children: [Icon(Icons.chat_bubble_outline, size: 24, color: AppColors.primary), const SizedBox(height: 8), Text('Chat', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground))])),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Frequently Asked Questions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          ..._faqs.map((faq) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => setState(() => expandedId = expandedId == faq.id ? null : faq.id),
                    child: Row(
                      children: [
                        Expanded(child: Text(faq.question, style: const TextStyle(fontWeight: FontWeight.w500))),
                        Icon(expandedId == faq.id ? Icons.expand_less : Icons.expand_more, color: AppColors.mutedForeground),
                      ],
                    ),
                  ),
                  if (expandedId == faq.id) ...[
                    const SizedBox(height: 12),
                    Text(faq.answer, style: TextStyle(color: AppColors.mutedForeground, height: 1.5)),
                  ],
                ],
              ),
            ),
          )),
          const SizedBox(height: 24),
          const Text('Contact Support', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              children: [
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
                const SizedBox(height: 16),
                TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 16),
                TextField(controller: _subjectController, decoration: const InputDecoration(labelText: 'Subject')),
                const SizedBox(height: 16),
                TextField(controller: _messageController, maxLines: 5, decoration: const InputDecoration(labelText: 'Message', hintText: 'Describe your issue...')),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: loading ? 'Sending...' : 'Send Message',
                    onPressed: loading ? null : _submit,
                    isLoading: loading,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
