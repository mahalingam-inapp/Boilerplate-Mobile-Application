import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/image_with_fallback.dart';

class _SearchItem {
  final String id;
  final String title;
  final String category;
  final String price;
  final String image;
  const _SearchItem({required this.id, required this.title, required this.category, required this.price, required this.image});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _queryController = TextEditingController();
  bool showFilters = false;
  String categoryFilter = 'All';
  String priceRange = 'All';
  String sortBy = 'relevance';

  static const _categories = ['All', 'Electronics', 'Furniture', 'Food & Beverage', 'Fashion'];
  static const _priceRanges = ['All', '\$0-\$50', '\$50-\$100', '\$100-\$300', '\$300+'];
  static const _searchResults = [
    _SearchItem(id: '1', title: 'Premium Wireless Headphones', category: 'Electronics', price: '\$299', image: 'https://images.unsplash.com/photo-1636353125878-38f866ee0343?w=400'),
    _SearchItem(id: '2', title: 'Modern Office Chair', category: 'Furniture', price: '\$449', image: 'https://images.unsplash.com/photo-1709346739762-e8ecacc96e0a?w=400'),
  ];

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  List<_SearchItem> get _filteredResults {
    final q = _queryController.text.trim().toLowerCase();
    if (q.isEmpty) return [];
    return _searchResults.where((e) => e.title.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredResults;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Search', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text("Find what you're looking for", style: TextStyle(color: AppColors.mutedForeground)),
          const SizedBox(height: 24),
          TextField(
            controller: _queryController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: 'Search items...',
              prefixIcon: Icon(Icons.search, size: 20, color: AppColors.mutedForeground),
              suffixIcon: Icon(Icons.close, size: 20, color: AppColors.mutedForeground),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${results.length} results', style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? AppColorsDark.mutedForeground : AppColors.mutedForeground)),
              AppButton(
                label: 'Filters',
                variant: AppButtonVariant.outline,
                size: AppButtonSize.sm,
                leading: const Icon(Icons.tune, size: 16),
                onPressed: () => setState(() => showFilters = !showFilters),
              ),
            ],
          ),
          if (showFilters) ...[
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Category', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((c) => GestureDetector(
                      onTap: () => setState(() => categoryFilter = c),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: categoryFilter == c ? AppColors.primary : AppColors.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(c, style: TextStyle(color: categoryFilter == c ? AppColors.primaryForeground : AppColors.accentForeground, fontSize: 14)),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('Price Range', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _priceRanges.map((r) => GestureDetector(
                      onTap: () => setState(() => priceRange = r),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: priceRange == r ? AppColors.primary : AppColors.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(r, style: TextStyle(color: priceRange == r ? AppColors.primaryForeground : AppColors.accentForeground, fontSize: 14)),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: sortBy,
                    decoration: const InputDecoration(),
                    items: const [
                      DropdownMenuItem(value: 'relevance', child: Text('Relevance')),
                      DropdownMenuItem(value: 'price-low', child: Text('Price: Low to High')),
                      DropdownMenuItem(value: 'price-high', child: Text('Price: High to Low')),
                      DropdownMenuItem(value: 'newest', child: Text('Newest')),
                    ],
                    onChanged: (v) => setState(() => sortBy = v ?? 'relevance'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: 'Clear Filters',
                      variant: AppButtonVariant.outline,
                      onPressed: () => setState(() {
                        categoryFilter = 'All';
                        priceRange = 'All';
                        sortBy = 'relevance';
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          if (_queryController.text.trim().isNotEmpty)
            results.isEmpty
                ? AppCard(
                    child: Column(
                      children: [
                        Icon(Icons.search, size: 48, color: AppColors.mutedForeground),
                        const SizedBox(height: 12),
                        const Text('No results found', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text('Try adjusting your search or filters', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                      ],
                    ),
                  )
                : Column(
                    children: results.map((item) => Padding(
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
                                  Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Text(item.price, style: const TextStyle(color: AppColors.primary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  )
          else
            SizedBox(
              width: double.infinity,
              child: AppCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search, size: 48, color: AppColors.mutedForeground),
                    const SizedBox(height: 12),
                    const Text('Start searching', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text('Enter a search term to find items', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
