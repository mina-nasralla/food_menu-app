import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import 'restaurant_card.dart';
import 'section_header.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.recommended.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            SectionHeader(
              title: 'Recommended for you',
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.recommended.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(restaurant: state.recommended[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
