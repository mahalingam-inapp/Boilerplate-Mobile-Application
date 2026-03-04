import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.card,
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Search locations...',
                  prefixIcon: Icon(Icons.search, size: 20, color: AppColors.mutedForeground),
                ),
              ),
              const SizedBox(height: 12),
              AppButton(
                variant: AppButtonVariant.outline,
                label: 'Use My Location',
                leading: const Icon(Icons.navigation, size: 16),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: AppColors.accent,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_outlined, size: 64, color: AppColors.mutedForeground),
                const SizedBox(height: 16),
                const Text('Map view', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Maps require the google_maps_flutter package. Add it to your project to display a map here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColors.mutedForeground),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.card,
          child: AppCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.location_on, size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected location', style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text('Enable google_maps_flutter to show addresses', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: AppButton(label: 'Get Directions', size: AppButtonSize.sm)),
                          const SizedBox(width: 8),
                          Expanded(child: AppButton(label: 'Call', variant: AppButtonVariant.outline, size: AppButtonSize.sm)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
