import 'package:flutter/material.dart';
import 'package:food_menu_app/features/home/presentation/widgets/quantity_control_widget.dart';

import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';

class BestSellersSection extends StatelessWidget {
  const BestSellersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Best Sellers", style: AppFonts.styleBold20(context)),
              Text(
                'See all',
                style: AppFonts.styleMedium16(
                  context,
                ).copyWith(color: AppColors.primaryLight),
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
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 240,
                margin: const EdgeInsets.only(right: 16, bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
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
                          "assets/img.jpg",
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Classic Double Burger',
                              style: AppFonts.styleBold16(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Beef patty, cheddar, lettuce, tomato & house sauce.',
                              style: AppFonts.styleRegular12(
                                context,
                              ).copyWith(color: AppColors.textSecondaryLight),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$8.99',
                                  style: AppFonts.styleBold18(context),
                                ),
                                QuantityControl(
                                  itemId: 'bestseller_$index',
                                  isCompact: true,
                                )
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Order button
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Implement order functionality
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryLight,
                                foregroundColor: Colors.white,
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
                                    'Add to cart',
                                    style: AppFonts.styleRegular14(context),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
