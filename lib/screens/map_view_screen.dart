import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/app_button.dart';

class _MapLocation {
  final LatLng point;
  final String name;
  final String id;
  const _MapLocation({required this.point, required this.name, required this.id});
}

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

/// Purpose: Find nearby locations (e.g. offices, sites) and get directions.
class _MapViewScreenState extends State<MapViewScreen> {
  final _searchController = TextEditingController();
  final _mapController = MapController();
  LatLng? _currentLocation;
  bool _locationLoading = false;
  String? _locationError;
  static const _defaultCenter = LatLng(20.0, 0.0);
  static const _defaultZoom = 2.0;

  /// Sample nearby locations (offices/sites) for demo. In a real app, load from API.
  static const _nearbyLocations = [
    _MapLocation(point: LatLng(19.99, 0.01), name: 'Main office', id: '1'),
    _MapLocation(point: LatLng(20.02, -0.02), name: 'Warehouse', id: '2'),
    _MapLocation(point: LatLng(19.97, 0.03), name: 'Site A', id: '3'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _useMyLocation() async {
    setState(() {
      _locationLoading = true;
      _locationError = null;
    });
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationError = 'Location services are disabled.';
          _locationLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_locationError!)),
          );
        }
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationError = 'Location permission permanently denied.';
          _locationLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_locationError!)),
          );
        }
        return;
      }
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationError = 'Location permission denied.';
          _locationLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_locationError!)),
          );
        }
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      final latLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentLocation = latLng;
        _locationLoading = false;
        _locationError = null;
      });
      _mapController.move(latLng, 15.0);
    } catch (e) {
      setState(() {
        _locationError = 'Could not get location: $e';
        _locationLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_locationError!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: theme.cardTheme.color ?? theme.colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nearby locations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                'Find offices or sites near you and get directions.',
                style: TextStyle(fontSize: 14, color: isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search address or place name...',
                  prefixIcon: Icon(Icons.search, size: 20, color: isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground),
                ),
              ),
              const SizedBox(height: 12),
              AppButton(
                variant: AppButtonVariant.outline,
                label: _locationLoading ? 'Getting location...' : 'Use My Location',
                leading: _locationLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.my_location, size: 16),
                onPressed: _locationLoading ? null : _useMyLocation,
              ),
            ],
          ),
        ),
        Expanded(
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentLocation ?? _defaultCenter,
              zoom: _currentLocation != null ? 15.0 : _defaultZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.boilerplate_app_flutter',
              ),
              MarkerLayer(
                markers: [
                  if (_currentLocation != null)
                    Marker(
                      point: _currentLocation!,
                      width: 44,
                      height: 44,
                      child: Icon(Icons.my_location, size: 44, color: primary),
                    ),
                  ..._nearbyLocations.map((loc) => Marker(
                        point: loc.point,
                        width: 36,
                        height: 36,
                        child: Icon(Icons.place, size: 36, color: theme.colorScheme.secondary),
                      )),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: theme.cardTheme.color ?? theme.colorScheme.surface,
          child: AppCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.location_on, size: 20, color: primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentLocation != null ? 'Your location' : 'Nearby sites',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _currentLocation != null
                            ? '${_currentLocation!.latitude.toStringAsFixed(5)}, ${_currentLocation!.longitude.toStringAsFixed(5)}'
                            : 'Blue pin = you. Other pins = offices/sites. Tap "Use My Location" to center on you.',
                        style: TextStyle(fontSize: 14, color: isDark ? AppColorsDark.mutedForeground : AppColors.mutedForeground),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              label: 'Get Directions',
                              size: AppButtonSize.sm,
                              onPressed: () {
                                // In a real app: launch maps app with selected location
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppButton(
                              label: 'Call',
                              variant: AppButtonVariant.outline,
                              size: AppButtonSize.sm,
                              onPressed: () {},
                            ),
                          ),
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
