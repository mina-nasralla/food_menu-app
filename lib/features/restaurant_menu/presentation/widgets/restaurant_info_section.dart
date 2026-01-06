import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utilities/app_fonts.dart';
import '../cubits/restaurant_profile_cubit.dart';

class RestaurantInfoSection extends StatelessWidget {
  const RestaurantInfoSection({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(launchUri)) {
      throw Exception('Could not launch $launchUri');
    }
  }

  Future<void> _openMap(double? lat, double? long, String address) async {
    final googleMapsUrl = lat != null && long != null
        ? Uri.parse('google.navigation:q=$lat,$long&mode=d')
        : Uri.parse(
            'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
          );

    final appleMapsUrl = lat != null && long != null
        ? Uri.parse('https://maps.apple.com/?q=$lat,$long')
        : Uri.parse(
            'https://maps.apple.com/?q=${Uri.encodeComponent(address)}',
          );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<RestaurantProfileCubit, RestaurantProfileState>(
      builder: (context, state) {
        if (state is RestaurantProfileLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is RestaurantProfileError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text('${localizations.error}: ${state.message}'),
            ),
          );
        }

        if (state is RestaurantProfileLoaded) {
          final profile = state.profile;

          return Column(
            children: [
              // Banner Image - Premium Parallax-like feel
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (profile.coverUrl.isNotEmpty)
                      Image.network(
                        profile.coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/img.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    else
                      Image.asset('assets/img.jpg', fit: BoxFit.cover),
                    // Gradient Overlays for depth
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Info Card - Glassmorphism Style
              Transform.translate(
                offset: const Offset(0, -40),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E1E1E).withOpacity(0.9)
                        : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Header: Logo and Basic Info
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Premium Logo Frame
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          theme.primaryColor,
                                          theme.primaryColor.withOpacity(0.3),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: theme.cardColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: profile.logoUrl.isNotEmpty
                                            ? Image.network(
                                                profile.logoUrl,
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    'assets/logo.png',
                                                    fit: BoxFit.contain,
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                'assets/logo.png',
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          profile.name,
                                          style: AppFonts.styleBold16(context)
                                              .copyWith(
                                            fontSize: 22,
                                            height: 1.1,
                                            letterSpacing: -0.5,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Info rows - Compact
                              _buildInfoRow(
                                context,
                                icon: Icons.location_on_rounded,
                                value: profile.location,
                                isDark: isDark,
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                context,
                                icon: Icons.access_time_rounded,
                                value: localizations.deliveryTimeValue,
                                isDark: isDark,
                              ),

                              const SizedBox(height: 20),

                              // Action Buttons - Compact
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildActionButton(
                                      context,
                                      icon: Icons.call_rounded,
                                      label: localizations.call,
                                      primaryColor: const Color(0xFF27AE60),
                                      onTap: () =>
                                          _makePhoneCall(profile.phone),
                                      isDark: isDark,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildActionButton(
                                      context,
                                      icon: Icons.map_rounded,
                                      label: localizations.directions,
                                      primaryColor: const Color(0xFF2F80ED),
                                      onTap: () => _openMap(
                                        profile.latitude,
                                        profile.longitude,
                                        profile.location,
                                      ),
                                      isDark: isDark,
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
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String value,
    required bool isDark,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: theme.primaryColor, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyLarge?.color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color primaryColor,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
