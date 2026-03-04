import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';
import '../widgets/image_with_fallback.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String id;

  const ItemDetailsScreen({Key? key, required this.id}) : super(key: key);

  static final _items = <String, Map<String, dynamic>>{
    '1': {
      'title': 'Premium Wireless Headphones',
      'category': 'Electronics',
      'price': '\$299',
      'rating': 4.8,
      'reviews': 234,
      'image': 'https://images.unsplash.com/photo-1636353125878-38f866ee0343?w=800',
      'description': 'Experience premium audio quality with our state-of-the-art wireless headphones. Featuring active noise cancellation, 30-hour battery life, and premium comfort padding.',
      'features': ['Active Noise Cancellation', '30-hour battery life', 'Premium comfort padding', 'Bluetooth 5.0', 'Foldable design'],
      'status': 'In Stock',
    },
    '2': {
      'title': 'Modern Office Chair',
      'category': 'Furniture',
      'price': '\$449',
      'rating': 4.6,
      'reviews': 128,
      'image': 'https://images.unsplash.com/photo-1709346739762-e8ecacc96e0a?w=800',
      'description': 'Ergonomic office chair designed for all-day comfort. Features adjustable lumbar support, breathable mesh back, and premium hydraulic adjustment.',
      'features': ['Ergonomic design', 'Adjustable lumbar support', 'Breathable mesh', 'Premium hydraulics', '360° swivel'],
      'status': 'In Stock',
    },
    '3': {
      'title': 'Artisan Coffee Blend',
      'category': 'Food & Beverage',
      'price': '\$24',
      'rating': 4.9,
      'reviews': 456,
      'image': 'https://images.unsplash.com/photo-1771422574972-3d8b237d6c12?w=800',
      'description': 'Carefully crafted artisan coffee blend sourced from sustainable farms. Rich, smooth flavor with notes of chocolate and caramel.',
      'features': ['Single-origin beans', 'Sustainably sourced', 'Medium roast', 'Rich flavor profile', 'Freshly roasted'],
      'status': 'In Stock',
    },
    '4': {
      'title': 'Designer Jacket',
      'category': 'Fashion',
      'price': '\$189',
      'rating': 4.7,
      'reviews': 89,
      'image': 'https://images.unsplash.com/photo-1763771522867-c26bf75f12bc?w=800',
      'description': 'Stylish designer jacket perfect for any season. Premium materials and modern cut for a sophisticated look.',
      'features': ['Premium materials', 'Modern cut', 'Multiple pockets', 'Water-resistant', 'Machine washable'],
      'status': 'Low Stock',
    },
  };

  @override
  Widget build(BuildContext context) {
    final item = _items[id];
    if (item == null) {
      return const Scaffold(body: Center(child: Text('Item not found')));
    }

    final status = item['status'] as String;
    final features = item['features'] as List<String>;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                ImageWithFallback(
                  src: item['image'] as String,
                  alt: item['title'] as String,
                  height: 320,
                  width: double.infinity,
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 24,
                  child: Material(
                    color: AppColors.card.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  right: 24,
                  child: Row(
                    children: [
                      _CircleButton(icon: Icons.share),
                      const SizedBox(width: 8),
                      _CircleButton(icon: Icons.favorite_border),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['category'] as String, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                            const SizedBox(height: 4),
                            Text(item['title'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: status == 'In Stock' ? AppColors.greenSuccessBg : AppColors.yellowWarningBg,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(status, style: TextStyle(fontSize: 14, color: status == 'In Stock' ? AppColors.greenSuccess : AppColors.yellowWarning)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 20, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${item['rating']}'),
                      const SizedBox(width: 12),
                      Text('(${item['reviews']} reviews)', style: TextStyle(color: AppColors.mutedForeground)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(item['price'] as String, style: const TextStyle(fontSize: 28, color: AppColors.primary)),
                  const SizedBox(height: 24),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Description', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Text(item['description'] as String, style: TextStyle(color: AppColors.mutedForeground, height: 1.5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Features', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 12),
                        ...features.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 8),
                              Text(f, style: TextStyle(color: AppColors.mutedForeground)),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Wishlist',
                  variant: AppButtonVariant.outline,
                  size: AppButtonSize.lg,
                  leading: const Icon(Icons.favorite_border, size: 20),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to wishlist'), backgroundColor: AppColors.primary)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: AppButton(
                  size: AppButtonSize.lg,
                  label: 'Add to Cart',
                  leading: const Icon(Icons.shopping_cart_outlined, size: 20, color: Colors.white),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart'), backgroundColor: AppColors.primary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;

  const _CircleButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card.withOpacity(0.9),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}
