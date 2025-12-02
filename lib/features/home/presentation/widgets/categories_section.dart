import 'package:flutter/material.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.lunch_dining, 'name': 'Burgers'},
      {'icon': Icons.local_pizza, 'name': 'Pizza'},
      {'icon': Icons.local_drink, 'name': 'Drinks'},
      {'icon': Icons.icecream, 'name': 'Desserts'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: AppFonts.styleBold20(context),
              ),
              Text(
                'Browse all',
                style: AppFonts.styleMedium16(context).copyWith(
                  color: AppColors.primaryLight,
                ),
              ),
            ],
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
              return Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: index == 0 ? AppColors.orangeLight : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(25),
                  border: index == 0 ? null : Border.all(color: AppColors.dividerLight),
                ),
                child: Row(
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      color: index == 0 ? AppColors.primaryLight : AppColors.textSecondaryLight,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category['name'] as String,
                      style: AppFonts.styleMedium16(context).copyWith(
                        color: index == 0 ? AppColors.primaryLight : AppColors.textSecondaryLight,
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
