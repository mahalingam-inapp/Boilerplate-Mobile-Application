import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';

class EditFormScreen extends StatefulWidget {
  final String id;

  const EditFormScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EditFormScreen> createState() => _EditFormScreenState();
}

class _EditFormScreenState extends State<EditFormScreen> {
  final _titleController = TextEditingController(text: 'Premium Wireless Headphones');
  final _priceController = TextEditingController(text: '\$299');
  final _descriptionController = TextEditingController(text: 'Experience premium audio quality with our state-of-the-art wireless headphones.');
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item updated successfully!'), backgroundColor: AppColors.primary));
      context.go('/items/${widget.id}');
    }
  }

  void _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: AppColors.destructive))),
        ],
      ),
    );
    if (confirm == true && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item deleted successfully'), backgroundColor: AppColors.primary));
        context.go('/items');
      }
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Edit Item', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                      Text('Update item details', style: TextStyle(color: AppColors.mutedForeground)),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline, color: AppColors.destructive),
              ),
            ],
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
              Expanded(child: AppButton(label: loading ? 'Saving...' : 'Save Changes', onPressed: loading ? null : _submit, isLoading: loading)),
            ],
          ),
        ],
      ),
    );
  }
}
