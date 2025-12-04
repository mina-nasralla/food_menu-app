import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routing/route_constants.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';

/// Floating Action Button for navigating to cart with badge showing total price
class CartFloatingButton extends StatelessWidget {
  const CartFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect text direction
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final totalPrice = state.totalCartPrice;
        final hasItems = state.cartItems.isNotEmpty;

        return Badge(
          isLabelVisible: hasItems,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              '\$${totalPrice.toStringAsFixed(2)}',
              style: AppFonts.styleRegular12(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.successDark : AppColors.success,
          // Position badge on top-right for RTL (Arabic), top-left for LTR (English)
          offset: isRTL ? const Offset(8, -8) : const Offset(-8, -8),
          alignment: isRTL ? Alignment.topRight : Alignment.topLeft,
          child: FloatingActionButton(
            onPressed: () {
              context.push(RouteConstants.cartPath);
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      },
    );
  }
}

