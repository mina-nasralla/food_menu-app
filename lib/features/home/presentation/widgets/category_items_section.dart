import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/home/presentation/widgets/quantity_control_widget.dart';

import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';

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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category Items", style: AppFonts.styleBold20(context)),
                  // Only show toggle button on mobile devices
                  if (!isTabletOrLarger)
                    IconButton(
                      onPressed: () {
                        context.read<HomeCubit>().toggleViewMode();
                      },
                      icon: Icon(
                        state.isGridView ? Icons.view_list : Icons.grid_view,
                        color: AppColors.primaryLight,
                      ),
                      tooltip: state.isGridView
                          ? 'Switch to List View'
                          : 'Switch to Grid View',
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildItemCard(context, effectiveIsGridView, index);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildItemCard(BuildContext context, bool isGrid, int index) {
    if (isGrid) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
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
                    "assets/img.jpg",
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
                              'Add to cart',
                              style: AppFonts.styleRegular14(context),
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
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
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
                      "assets/img.jpg",
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Classic Double Burger',
                      style: AppFonts.styleBold16(context),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        SizedBox(height: 8),

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
                  ],
                ),
              ),
            ),
            ]));
    }
  }
}
