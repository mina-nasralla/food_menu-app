import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/home/presentation/widgets/quantity_control_widget.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routing/route_constants.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import '../utils/sample_menu_items.dart';
import '../../data/models/menu_item_model.dart';

class CategoryItemsSection extends StatelessWidget {
  const CategoryItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Responsive Grid Logic
        final screenWidth = MediaQuery.of(context).size.width;
        final isTabletOrLarger = screenWidth >= 600; // Tablet breakpoint
        final crossAxisCount = (screenWidth / 180).floor().clamp(
          2,
          6,
        ); // Min 2, Max 6 items per row

        // Force grid view on tablets and larger screens
        final effectiveIsGridView = isTabletOrLarger ? true : state.isGridView;
        final localizations = AppLocalizations.of(context)!;

        // Filter items based on selected category
        final allItems = SampleMenuItems.getLocalizedItems(context);
        final filteredItems = state.selectedCategory == null
            ? allItems
            : allItems.where((item) => item.category == state.selectedCategory).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.selectedCategory == null 
                        ? localizations.categoryItems 
                        : _getCategoryName(context, state.selectedCategory!),
                    style: AppFonts.styleBold20(context),
                  ),
                  // Only show toggle button on mobile devices
                  if (!isTabletOrLarger)
                    IconButton(
                      onPressed: () {
                        context.read<HomeCubit>().toggleViewMode();
                      },
                      icon: Icon(
                        state.isGridView ? Icons.view_list : Icons.grid_view,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      tooltip: state.isGridView
                          ? localizations.switchToList
                          : localizations.switchToGrid,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (filteredItems.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Text(
                    'No items found in this category',
                    style: AppFonts.styleRegular16(context),
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: effectiveIsGridView ? crossAxisCount : 1,
                  childAspectRatio: effectiveIsGridView ? 0.75 : 2.5,
                  // Adjusted for better proportions on tablets
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return _buildItemCard(context, effectiveIsGridView, filteredItems[index]);
                },
              ),
          ],
        );
      },
    );
  }

  String _getCategoryName(BuildContext context, String categoryId) {
    final localizations = AppLocalizations.of(context)!;
    switch (categoryId) {
      case 'burgers': return localizations.burgers;
      case 'pizza': return localizations.pizza;
      case 'drinks': return localizations.drinks;
      case 'desserts': return localizations.desserts;
      default: return localizations.categoryItems;
    }
  }

  Widget _buildItemCard(BuildContext context, bool isGrid, MenuItem menuItem) {
    final localizations = AppLocalizations.of(context)!;
    
    if (isGrid) {
      return GestureDetector(
        onTap: () {
          context.push(RouteConstants.itemDetailsPath, extra: menuItem);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      menuItem.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      menuItem.name,
                      style: AppFonts.styleBold16(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      menuItem.description,
                      style: AppFonts.styleRegular12(
                        context,
                      ).copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${menuItem.basePrice.toStringAsFixed(2)}',
                          style: AppFonts.styleBold18(context),
                        ),
                        QuantityControl(itemId: menuItem.id, isCompact: true),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Order button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<HomeCubit>().addToCart(
                            id: menuItem.id,
                            name: menuItem.name,
                            description: menuItem.description,
                            basePrice: menuItem.basePrice,
                            imageUrl: menuItem.imageUrl,
                            originalItem: menuItem,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(localizations.addedToCart(1, menuItem.name)),
                              backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.successDark : AppColors.success,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                localizations.addToCart,
                                style: AppFonts.styleRegular14(context).copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      menuItem.imageUrl,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(menuItem.name, style: AppFonts.styleBold16(context)),
                    const SizedBox(height: 4),
                    Text(
                      menuItem.description,
                      style: AppFonts.styleRegular12(
                        context,
                      ).copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${menuItem.basePrice.toStringAsFixed(2)}',
                              style: AppFonts.styleBold18(context),
                            ),
                            QuantityControl(
                              itemId: menuItem.id,
                              isCompact: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        // Order button
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeCubit>().addToCart(
                              id: menuItem.id,
                              name: menuItem.name,
                              description: menuItem.description,
                              basePrice: menuItem.basePrice,
                              imageUrl: menuItem.imageUrl,
                              originalItem: menuItem,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(localizations.addedToCart(1, menuItem.name)),
                                backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.successDark : AppColors.success,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                localizations.addToCart,
                                style: AppFonts.styleRegular14(context).copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
