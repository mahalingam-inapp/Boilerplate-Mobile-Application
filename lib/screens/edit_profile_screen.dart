import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/image_with_fallback.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _bioController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => loading = true);
    try {
      await context.read<AuthProvider>().updateProfile({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text.isEmpty ? null : _phoneController.text,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully'), backgroundColor: AppColors.primary));
        context.go('/profile');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to update profile'), backgroundColor: AppColors.destructive));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Edit Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  Text('Update your information', style: TextStyle(color: AppColors.mutedForeground)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ImageWithFallback(
                      src: user?.avatar ?? '',
                      alt: user?.name ?? 'User',
                      width: 96,
                      height: 96,
                      borderRadius: BorderRadius.circular(48),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, size: 20, color: AppColors.primaryForeground),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Click to change profile picture', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name')),
          const SizedBox(height: 16),
          TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 16),
          TextField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone')),
          const SizedBox(height: 16),
          TextField(controller: _bioController, maxLines: 4, decoration: const InputDecoration(labelText: 'Bio', hintText: 'Tell us about yourself...')),
          const SizedBox(height: 16),
          TextField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location', hintText: 'City, Country')),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Cancel',
                  variant: AppButtonVariant.outline,
                  onPressed: () => context.pop(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  label: loading ? 'Saving...' : 'Save Changes',
                  onPressed: loading ? null : _submit,
                  isLoading: loading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
