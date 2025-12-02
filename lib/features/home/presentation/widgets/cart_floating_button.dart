import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routing/route_constants.dart';
import '../../../../core/utilities/app_colors.dart';

/// Floating Action Button for navigating to cart
class CartFloatingButton extends StatelessWidget {
  const CartFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.push(RouteConstants.cartPath);
      },
      backgroundColor: AppColors.primaryLight,
      child: const Icon(
        Icons.shopping_cart,
        color: AppColors.white,
      ),
    );
  }
}
