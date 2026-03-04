import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String category = 'Electronics';
  String status = 'In Stock';
  bool loading = false;

  static const _categories = ['Electronics', 'Furniture', 'Food & Beverage', 'Fashion', 'Other'];
  static const _statuses = ['In Stock', 'Low Stock', 'Out of Stock'];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item created successfully!'), backgroundColor: AppColors.primary));
      context.go('/items');
    }
  }

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
                  Text('Create Item', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  Text('Add a new item', style: TextStyle(color: AppColors.mutedForeground)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                Icon(Icons.upload_file, size: 48, color: AppColors.primary),
                const SizedBox(height: 12),
                const Text('Upload Images'),
                Text('PNG, JPG up to 5MB', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title', hintText: 'Enter item title')),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => category = v ?? 'Electronics'),
          ),
          const SizedBox(height: 16),
          TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price', hintText: '\$0.00')),
          const SizedBox(height: 16),
          TextField(controller: _descriptionController, maxLines: 5, decoration: const InputDecoration(labelText: 'Description', hintText: 'Describe your item...')),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: _statuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) => setState(() => status = v ?? 'In Stock'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: AppButton(label: 'Cancel', variant: AppButtonVariant.outline, onPressed: () => context.pop())),
              const SizedBox(width: 12),
              Expanded(child: AppButton(label: loading ? 'Creating...' : 'Create Item', onPressed: loading ? null : _submit, isLoading: loading)),
            ],
          ),
        ],
      ),
    );
  }
}
