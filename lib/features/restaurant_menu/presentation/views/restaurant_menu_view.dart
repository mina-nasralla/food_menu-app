import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/widgets/cart_floating_button.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/widgets/restaurant_info_section.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/widgets/restaurant_menu_app_bar.dart';

import '../cubits/restaurant_menu_cubit.dart';
import '../cubits/restaurant_menu_state.dart';
import '../widgets/best_sellers_section.dart';
import '../widgets/categories_section.dart';
import '../widgets/category_items_section.dart';
import '../widgets/offers_section.dart';
import '../widgets/search_bar_widget.dart';

/// RestaurantMenuView page view
class RestaurantMenuView extends StatelessWidget {
  const RestaurantMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RestaurantMenuViewBody();
  }
}

class _RestaurantMenuViewBody extends StatelessWidget {
  const _RestaurantMenuViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow banner to go behind AppBar
      appBar: const RestaurantMenuAppBar(),
      body: BlocBuilder<RestaurantMenuCubit, RestaurantMenuState>(
        builder: (context, state) {
          return const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RestaurantInfoSection(), // Banner and Details
                SizedBox(height: 16),
                SearchBarWidget(),
                SizedBox(height: 24),
                OffersSection(),
                SizedBox(height: 24),
                BestSellersSection(),
                SizedBox(height: 24),
                CategoriesSection(),
                SizedBox(height: 24),
                CategoryItemsSection(),
                SizedBox(height: 80), // Space for FAB
              ],
            ),
          );
        },
      ),
      floatingActionButton: const CartFloatingButton(),
    );
  }
}
