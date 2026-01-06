import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../cubits/category_cubit.dart';
import '../cubits/restaurant_menu_cubit.dart';
import '../cubits/restaurant_menu_state.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, categoryState) {
        if (categoryState is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoryState is CategoryError) {
          return Center(child: Text('Error: ${categoryState.message}'));
        }

        if (categoryState is CategoryLoaded) {
          final categories = categoryState.categories;

          return BlocBuilder<RestaurantMenuCubit, RestaurantMenuState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      localizations.categories,
                      style: AppFonts.styleBold20(context),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final categoryId = category.id;
                        final isSelected = state.selectedCategory == categoryId;

                        return GestureDetector(
                          onTap: () {
                            final cubit = context.read<RestaurantMenuCubit>();
                            if (isSelected) {
                              cubit.selectCategory(null);
                            } else {
                              cubit.selectCategory(categoryId);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1)
                                  : Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(25),
                              border: isSelected
                                  ? Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary)
                                  : Border.all(
                                      color: Theme.of(context).dividerColor),
                            ),
                            child: Row(
                              children: [
                                if (category.imageUrl != null &&
                                    category.imageUrl!.isNotEmpty)
                                  Image.network(
                                    category.imageUrl!,
                                    width: 20,
                                    height: 20,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.category, size: 20),
                                  )
                                else
                                  const Icon(Icons.category, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  category.name,
                                  style:
                                      AppFonts.styleMedium16(context).copyWith(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color,
                                  ),
                                ),
                              ],
                            ),
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

        return const SizedBox.shrink();
      },
    );
  }
}
