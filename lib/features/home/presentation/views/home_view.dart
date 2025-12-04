import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/home/presentation/widgets/cart_floating_button.dart';
import 'package:food_menu_app/features/home/presentation/widgets/home_app_bar.dart';

import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import '../widgets/best_sellers_section.dart';
import '../widgets/categories_section.dart';
import '../widgets/category_items_section.dart';
import '../widgets/offers_section.dart';
import '../widgets/search_bar_widget.dart';

/// Home page view
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeViewBody();
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
