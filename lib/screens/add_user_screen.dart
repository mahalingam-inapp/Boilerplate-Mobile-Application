import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mutedColor = isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Add User'),
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Invite a new user to your team.', style: TextStyle(fontSize: 14, color: mutedColor)),
            const SizedBox(height: 24),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppInput(
                    controller: _nameController,
                    label: 'Full name',
                    placeholder: 'e.g. Jane Smith',
                    prefixIcon: const Icon(Icons.person_outline, size: 20, color: AppColors.mutedForeground),
                  ),
                  const SizedBox(height: 16),
                  AppInput(
                    controller: _emailController,
                    label: 'Email',
                    placeholder: 'jane@example.com',
                    prefixIcon: const Icon(Icons.mail_outline, size: 20, color: AppColors.mutedForeground),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  AppInput(
                    controller: _roleController,
                    label: 'Role',
                    placeholder: 'e.g. Editor, Viewer',
                    prefixIcon: const Icon(Icons.badge_outlined, size: 20, color: AppColors.mutedForeground),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(label: 'Send invitation', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }
}
