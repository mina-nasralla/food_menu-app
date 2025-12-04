import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/home/presentation/widgets/quantity_control_widget.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routing/route_constants.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../cubits/home_cubit.dart';
import '../utils/sample_menu_items.dart';

class BestSellersSection extends StatelessWidget {
  const BestSellersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final menuItems = SampleMenuItems.getLocalizedItems(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(localizations.bestSellers, style: AppFonts.styleBold20(context)),
              Text(
                localizations.seeAll,
                style: AppFonts.styleMedium16(
                  context,
                ).copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 350, // Increased height to accommodate order controls
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final menuItem = menuItems[index];

              return GestureDetector(
                  onTap: () {
                    context.push(
                      RouteConstants.itemDetailsPath,
                      extra: menuItem,
                    );
                  },
                  child: Container(
                    width: 240,
                    margin: const EdgeInsets.only(right: 16, bottom: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
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
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              menuItem.imageUrl,
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0),
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
                                  ).copyWith(
                                      color: Theme.of(context).textTheme.bodyMedium?.color),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      '\$${menuItem.basePrice.toStringAsFixed(
                                          2)}',
                                      style: AppFonts.styleBold18(context),
                                    ),
                                    QuantityControl(
                                      itemId: menuItem.id,
                                      isCompact: true,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),

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
                          ),
                        ),
                      ],
                    ),
                  ));
              },
          ),
        ),
      ],
    );
  }
}
