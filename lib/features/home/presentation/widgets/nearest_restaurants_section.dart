import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import 'nearest_restaurant_card.dart';
import 'section_header.dart';

class NearestRestaurantsSection extends StatelessWidget {
  const NearestRestaurantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.nearest.isEmpty) return const SizedBox.shrink();

        // Calculate card width based on screen size to determine aspect ratio or crossAxis count
        // Assume minimal width for 2 columns on mobile (e.g. 360px -> 180px each)
        // Adjust childAspectRatio to fit the new card height
        // Card height estimate: Image (140) + Padding(12) + Title(~24) + Spacing(8) + Row(~20) + Spacing(12) + Row(~24) + Padding(12) ~= 250-280
        
        return Column(
          children: [
             SectionHeader(
              title: 'Near you',
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                // If width is greater than 600, use GridView (Tablet/Desktop)
                // Otherwise use ListView (Mobile)
                if (constraints.maxWidth > 600) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400, // Adjusted for wider card
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2.2, // Much wider aspect ratio for horizontal card
                    ),
                    itemCount: state.nearest.length,
                    itemBuilder: (context, index) {
                      return NearestRestaurantCard(
                        restaurant: state.nearest[index],
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.nearest.length,
                    itemBuilder: (context, index) {
                      return NearestRestaurantCard(
                        restaurant: state.nearest[index],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
