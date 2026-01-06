import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/cubits/menu_items_cubit.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/widgets/quantity_control_widget.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routing/route_constants.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../../data/models/menu_item_model.dart';
import '../cubits/restaurant_menu_cubit.dart';
import '../cubits/restaurant_menu_state.dart';

class CategoryItemsSection extends StatelessWidget {
  const CategoryItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantMenuCubit, RestaurantMenuState>(
      listenWhen: (previous, current) =>
          previous.selectedCategory != current.selectedCategory,
      listener: (context, state) {
        context.read<MenuItemsCubit>().fetchItems(
          categoryId: state.selectedCategory,
        );
      },
      child: BlocBuilder<RestaurantMenuCubit, RestaurantMenuState>(
        builder: (context, menuState) {
          return BlocBuilder<MenuItemsCubit, MenuItemsState>(
            builder: (context, state) {
              // Responsive Grid Logic
              final screenWidth = MediaQuery.of(context).size.width;
              final isTabletOrLarger = screenWidth >= 600;
              final crossAxisCount = (screenWidth / 180).floor().clamp(2, 6);

              final effectiveIsGridView = isTabletOrLarger
                  ? true
                  : menuState.isGridView;
              final localizations = AppLocalizations.of(context)!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          menuState.selectedCategory == null
                              ? localizations.categoryItems
                              : (state is MenuItemsLoaded &&
                                    state.items.isNotEmpty)
                              ? (state.items.first.categoryName ??
                                    localizations.categoryItems)
                              : localizations.categoryItems,
                          style: AppFonts.styleBold20(context),
                        ),
                        if (!isTabletOrLarger)
                          IconButton(
                            onPressed: () {
                              context
                                  .read<RestaurantMenuCubit>()
                                  .toggleViewMode();
                            },
                            icon: Icon(
                              menuState.isGridView
                                  ? Icons.view_list
                                  : Icons.grid_view,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            tooltip: menuState.isGridView
                                ? localizations.switchToList
                                : localizations.switchToGrid,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (state is MenuItemsLoading)
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state is MenuItemsError)
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(child: Text('Error: ${state.message}')),
                    )
                  else if (state is MenuItemsLoaded)
                    () {
                      // Filter items by search term
                      final filteredItems = menuState.menuSearchTerm.isEmpty
                          ? state.items
                          : state.items.where((item) {
                              final searchLower = menuState.menuSearchTerm
                                  .toLowerCase();
                              return item.name.toLowerCase().contains(
                                    searchLower,
                                  ) ||
                                  (item.description.toLowerCase().contains(
                                        searchLower,
                                      ));
                            }).toList();

                      return filteredItems.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Center(
                                child: Text(
                                  'No items found',
                                  style: AppFonts.styleRegular16(context),
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    effectiveIsGridView ? crossAxisCount : 1,
                                mainAxisExtent: effectiveIsGridView
                                    ? (screenWidth / crossAxisCount) * 1.60
                                    : null,
                                childAspectRatio: effectiveIsGridView ? 1 : 2.5,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                return _buildItemCard(
                                  context,
                                  effectiveIsGridView,
                                  filteredItems[index],
                                );
                              },
                            );
                    }()
                  else
                    const SizedBox.shrink(),
                ],
              );
            },
          );
        },
      ),
    );
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
              Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 135,
                    color: Theme.of(context).cardColor,
                    child:
                        menuItem.imageUrl != null &&
                            menuItem.imageUrl!.isNotEmpty
                        ? Image.network(
                            menuItem.imageUrl!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[800],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 40,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                          )
                        : Container(
                            color: Colors.grey[800],
                            child: const Center(
                              child: Icon(
                                Icons.fastfood,
                                size: 40,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    const SizedBox(height: 2),
                    Text(
                      menuItem.description,
                      style: AppFonts.styleRegular12(context).copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (menuItem.discount > 0)
                          Text(
                            '\$${menuItem.price.toStringAsFixed(2)}',
                            style: AppFonts.styleRegular12(context).copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                        Text(
                          '\$${menuItem.finalPrice.toStringAsFixed(2)}',
                          style: AppFonts.styleBold18(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    QuantityControl(itemId: menuItem.id, isCompact: true),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<RestaurantMenuCubit>().addToCart(
                            id: menuItem.id,
                            name: menuItem.name,
                            description: menuItem.description,
                            basePrice: menuItem.finalPrice,
                            imageUrl: menuItem.imageUrl ?? '',
                            originalItem: menuItem,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                localizations.addedToCart(1, menuItem.name),
                              ),
                              backgroundColor:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.successDark
                                  : AppColors.success,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
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
                            const Icon(Icons.add, size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                localizations.addToCart,
                                style: AppFonts.styleRegular14(context)
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
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
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:
                      menuItem.imageUrl != null && menuItem.imageUrl!.isNotEmpty
                      ? Image.network(
                          menuItem.imageUrl!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(Icons.fastfood, size: 40),
                              ),
                        )
                      : const Center(child: Icon(Icons.fastfood, size: 40)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        style: AppFonts.styleRegular12(context).copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          height: 1.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (menuItem.discount > 0)
                                Text(
                                  '\$${menuItem.price.toStringAsFixed(2)}',
                                  style: AppFonts.styleRegular12(context).copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              Text(
                                '\$${menuItem.finalPrice.toStringAsFixed(2)}',
                                style: AppFonts.styleBold16(context),
                              ),
                            ],
                          ),
                          QuantityControl(itemId: menuItem.id, isCompact: true),

                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<RestaurantMenuCubit>().addToCart(
                              id: menuItem.id,
                              name: menuItem.name,
                              description: menuItem.description,
                              basePrice: menuItem.finalPrice,
                              imageUrl: menuItem.imageUrl ?? '',
                              originalItem: menuItem,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  localizations.addedToCart(1, menuItem.name),
                                ),
                                backgroundColor:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.successDark
                                    : AppColors.success,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            localizations.order,
                            style: AppFonts.styleRegular14(context).copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
