import 'package:flutter/material.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

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
              Text(
                "Today's offers",
                style: AppFonts.styleBold20(context),
              ),
              Text(
                'View all',
                style: AppFonts.styleMedium16(context).copyWith(
                  color: AppColors.primaryLight,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200, // Increased height to prevent overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 320, // Slightly wider
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.orangeLight,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD180),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Limited time',
                            style: AppFonts.styleMedium16(context).copyWith(
                              fontSize: 12,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded( // Use Expanded to handle flexible space
                          child: Text(
                            'Up to 40% off on\nBurgers',
                            style: AppFonts.styleBold20(context).copyWith(
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Order 2 get free fries on\nselected combos.',
                          style: AppFonts.styleRegular14(context).copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                            minimumSize: const Size(100, 36), // Compact button
                          ),
                          child: const Text('Order', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 20,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey, // Placeholder for image
                          // image: DecorationImage(image: AssetImage('...'))
                        ),
                        child: const Icon(Icons.fastfood, size: 40, color: Colors.white),
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
