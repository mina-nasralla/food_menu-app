import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/config/routing/route_constants.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/cubits/restaurant_menu_cubit.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/cubits/restaurant_menu_state.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'addon_card.dart';

class AddonsSection extends StatelessWidget {
  const AddonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<RestaurantMenuCubit, RestaurantMenuState>(
      builder: (context, state) {
        if (state.isLoadingAddons) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.addons.isEmpty) {
          return const SizedBox.shrink();
        }

        // Filter addons by search term
        final filteredAddons = state.menuSearchTerm.isEmpty
            ? state.addons
            : state.addons.where((addon) {
                return addon.name.toLowerCase().contains(state.menuSearchTerm.toLowerCase());
              }).toList();

        // Hide section if search is active but no matches
        if (state.menuSearchTerm.isNotEmpty && filteredAddons.isEmpty) {
          return const SizedBox.shrink();
        }

        final displayedAddons = filteredAddons.take(5).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.recommendedAddons,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(RouteConstants.allAddonsName);
                    },
                    child: Text(
                      l10n.seeAll,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180, // Increased height to prevent overflow
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: displayedAddons.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: SizedBox(
                      width: 160,
                      child: AddonCard(addon: displayedAddons[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
