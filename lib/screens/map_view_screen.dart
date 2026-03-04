import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class _Location {
  final int id;
  final String name;
  final LatLng position;
  final String address;
  const _Location({required this.id, required this.name, required this.position, required this.address});
}

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  final _searchController = TextEditingController();
  static const _locations = [
    _Location(id: 1, name: 'Store Location 1', position: LatLng(37.7749, -122.4194), address: '123 Market St, San Francisco'),
    _Location(id: 2, name: 'Store Location 2', position: LatLng(37.7849, -122.4094), address: '456 Mission St, San Francisco'),
    _Location(id: 3, name: 'Store Location 3', position: LatLng(37.7649, -122.4294), address: '789 Howard St, San Francisco'),
  ];

  late GoogleMapController _mapController;
  _Location _selected = _locations[0];
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers = {
      for (final loc in _locations)
        Marker(
          markerId: MarkerId(loc.id.toString()),
          position: loc.position,
          onTap: () => setState(() => _selected = loc),
        ),
    };
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Location> get _filteredLocations {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return _locations;
    return _locations.where((l) => l.name.toLowerCase().contains(q) || l.address.toLowerCase().contains(q)).toList();
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
                onPressed: () {
                  _mapController.animateCamera(CameraUpdate.newLatLng(_selected.position));
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: _selected.position, zoom: 13),
            onMapCreated: (c) {
              _mapController = c;
            },
            markers: _markers,
            onTap: (_) {},
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
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.location_on, size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_selected.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text(_selected.address, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
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
