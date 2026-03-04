import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/image_with_fallback.dart';

class _Item {
  final String id;
  final String title;
  final String category;
  final String price;
  final String image;
  final String status;
  const _Item({required this.id, required this.title, required this.category, required this.price, required this.image, required this.status});
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  bool gridView = true;
  String selectedCategory = 'All';

  static const _categories = ['All', 'Electronics', 'Furniture', 'Food & Beverage', 'Fashion'];
  static const _items = [
    _Item(id: '1', title: 'Premium Wireless Headphones', category: 'Electronics', price: '\$299', image: 'https://images.unsplash.com/photo-1636353125878-38f866ee0343?w=400', status: 'In Stock'),
    _Item(id: '2', title: 'Modern Office Chair', category: 'Furniture', price: '\$449', image: 'https://images.unsplash.com/photo-1709346739762-e8ecacc96e0a?w=400', status: 'In Stock'),
    _Item(id: '3', title: 'Artisan Coffee Blend', category: 'Food & Beverage', price: '\$24', image: 'https://images.unsplash.com/photo-1771422574972-3d8b237d6c12?w=400', status: 'In Stock'),
    _Item(id: '4', title: 'Designer Jacket', category: 'Fashion', price: '\$189', image: 'https://images.unsplash.com/photo-1763771522867-c26bf75f12bc?w=400', status: 'Low Stock'),
  ];

  List<_Item> get _filteredItems => selectedCategory == 'All' ? _items : _items.where((e) => e.category == selectedCategory).toList();

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Items', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  Text('${_filteredItems.length} items available', style: TextStyle(color: AppColors.mutedForeground)),
                ],
              ),
              AppButton(
                label: 'Add',
                size: AppButtonSize.sm,
                leading: const Icon(Icons.add, size: 16, color: Colors.white),
                onPressed: () => context.push('/create'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => selectedCategory = c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedCategory == c ? AppColors.primary : AppColors.accent,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    ),
                    child: Text(
                      c,
                      style: TextStyle(color: selectedCategory == c ? AppColors.primaryForeground : AppColors.accentForeground),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () => setState(() => gridView = true),
                icon: Icon(Icons.grid_view, color: gridView ? AppColors.primary : AppColors.accentForeground),
              ),
              IconButton(
                onPressed: () => setState(() => gridView = false),
                icon: Icon(Icons.list, color: !gridView ? AppColors.primary : AppColors.accentForeground),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (gridView)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredItems.length,
              itemBuilder: (_, i) {
                final item = _filteredItems[i];
                return AppCard(
                  onTap: () => context.push('/items/${item.id}'),
                  padding: EdgeInsets.zero,
                  clipBehavior: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageWithFallback(src: item.image, alt: item.title, height: 160, width: double.infinity),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.category, style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                            const SizedBox(height: 4),
                            Text(item.title, style: const TextStyle(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.price, style: const TextStyle(color: AppColors.primary)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: item.status == 'In Stock' ? AppColors.greenSuccessBg : AppColors.yellowWarningBg,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    item.status,
                                    style: TextStyle(fontSize: 12, color: item.status == 'In Stock' ? AppColors.greenSuccess : AppColors.yellowWarning),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          else
            ..._filteredItems.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                onTap: () => context.push('/items/${item.id}'),
                child: Row(
                  children: [
                    ImageWithFallback(src: item.image, alt: item.title, width: 80, height: 80, borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.category, style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                          Text(item.title, style: const TextStyle(fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(item.price, style: const TextStyle(color: AppColors.primary)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: item.status == 'In Stock' ? AppColors.greenSuccessBg : AppColors.yellowWarningBg,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(item.status, style: TextStyle(fontSize: 11, color: item.status == 'In Stock' ? AppColors.greenSuccess : AppColors.yellowWarning)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.mutedForeground),
                  ],
                ),
              ),
            )),
        ],
      ),
    );
  }
}
