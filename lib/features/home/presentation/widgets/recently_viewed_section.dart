import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import 'restaurant_card.dart';
import 'section_header.dart';

class RecentlyViewedSection extends StatelessWidget {
  const RecentlyViewedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.recentlyViewed.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            SectionHeader(
              title: 'Recently Viewed',
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.recentlyViewed.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(restaurant: state.recentlyViewed[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
