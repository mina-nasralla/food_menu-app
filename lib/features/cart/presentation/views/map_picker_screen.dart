import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:food_menu_app/core/utilities/app_fonts.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

/// Map picker screen for selecting delivery location using OpenStreetMap
class MapPickerScreen extends StatefulWidget {
  final String? initialAddress;

  const MapPickerScreen({
    super.key,
    this.initialAddress,
  });

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  final MapController _mapController = MapController();
  LatLng _currentPosition = LatLng(30.0444, 31.2357); // Default: Cairo
  String _selectedAddress = '';
  bool _isLoading = false;
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('Location permissions are denied');
          setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError('Location permissions are permanently denied');
        setState(() => _isLoading = false);
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final newPosition = LatLng(position.latitude, position.longitude);
      
      setState(() {
        _currentPosition = newPosition;
        _isLoading = false;
      });

      // Move map to current location
      _mapController.move(newPosition, 15.0);

      // Get address for current location
      await _getAddressFromLatLng(newPosition);
    } catch (e) {
      _showError('Error getting location: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        
        // Build address string, handling null values
        List<String> addressParts = [];
        if (place.street != null && place.street!.isNotEmpty) {
          addressParts.add(place.street!);
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          addressParts.add(place.subLocality!);
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        }
        if (place.country != null && place.country!.isNotEmpty) {
          addressParts.add(place.country!);
        }
        
        // If no address parts, use coordinates
        String address = addressParts.isNotEmpty 
            ? addressParts.join(', ')
            : 'Lat: ${position.latitude.toStringAsFixed(6)}, Lng: ${position.longitude.toStringAsFixed(6)}';
        
        setState(() {
          _selectedAddress = address;
          _markers.clear();
          _markers.add(
            Marker(
              point: position,
              width: 40,
              height: 40,
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
            ),
          );
        });
      }
    } catch (e) {
      // If geocoding fails (common on web), use coordinates as address
      print('Geocoding error: $e');
      setState(() {
        _selectedAddress = 'Lat: ${position.latitude.toStringAsFixed(6)}, Lng: ${position.longitude.toStringAsFixed(6)}';
        _markers.clear();
        _markers.add(
          Marker(
            point: position,
            width: 40,
            height: 40,
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        );
      });
    }
  }

  void _onMapTapped(TapPosition tapPosition, LatLng position) {
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng(position);
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _confirmLocation() {
    if (_selectedAddress.isNotEmpty) {
      Navigator.pop(context, _selectedAddress);
    } else {
      _showError('Please select a location on the map');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.address),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // OpenStreetMap using flutter_map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 15.0,
              onTap: _onMapTapped,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.food_menu_app',
                maxZoom: 19,
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),

          // Loading Indicator
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Current Location Button
          Positioned(
            right: 16,
            bottom: 200,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: theme.colorScheme.surface,
              child: Icon(
                Icons.my_location,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          // Address Display and Confirm Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Location',
                      style: AppFonts.styleBold16(context),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedAddress.isEmpty
                                  ? 'Tap on the map to select a location'
                                  : _selectedAddress,
                              style: AppFonts.styleRegular14(context).copyWith(
                                color: _selectedAddress.isEmpty
                                    ? theme.textTheme.bodyMedium?.color?.withOpacity(0.5)
                                    : theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _selectedAddress.isNotEmpty ? _confirmLocation : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Confirm Location',
                          style: AppFonts.styleBold16(context).copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
