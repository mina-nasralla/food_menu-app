import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/cubits/restaurant_menu_cubit.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/cubits/restaurant_menu_state.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/widgets/addon_card.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

class AllAddonsView extends StatelessWidget {
  const AllAddonsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.recommendedAddons,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: BlocBuilder<RestaurantMenuCubit, RestaurantMenuState>(
        builder: (context, state) {
          if (state.isLoadingAddons) {
            return const Center(child: CircularProgressIndicator());
          }

          final filteredAddons = state.addons.where((addon) {
            return addon.name.toLowerCase().contains(
              state.addonSearchTerm.toLowerCase(),
            );
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  onChanged: (value) {
                    context.read<RestaurantMenuCubit>().setAddonSearchTerm(
                      value,
                    );
                  },
                  decoration: InputDecoration(
                    hintText: l10n.searchPlaceholder,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: theme.cardColor,
                  ),
                ),
              ),
              Expanded(
                child: filteredAddons.isEmpty
                    ? Center(
                        child: Text(
                          l10n.noAddonsFound,
                          style: theme.textTheme.bodyLarge,
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  1.2, // Even more compact
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: filteredAddons.length,
                        itemBuilder: (context, index) {
                          final addon = filteredAddons[index];
                          return AddonCard(addon: addon);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
