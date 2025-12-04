import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/utilities/app_colors.dart';
import 'package:food_menu_app/core/utilities/app_fonts.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routing/route_constants.dart';
import '../../../home/presentation/cubits/home_cubit.dart';
import '../../../home/presentation/cubits/home_state.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/cart_summary_widget.dart';

/// Cart page view
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text(l10n.cart), centerTitle: false),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return _buildEmptyCart(context);
          }

          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    return CartItemWidget(
                      item: item,
                      onAddOnChanged: (addOn, isAdding) {
                        if (isAdding) {
                          context.read<HomeCubit>().updateCartItemAddOn(
                            item.id,
                            addOn,
                          );
                        } else {
                          context.read<HomeCubit>().removeAddOnFromCartItem(
                            item.id,
                            addOn,
                          );
                        }
                      },
                      onQuantityChanged: (newQuantity) {
                        context.read<HomeCubit>().updateCartItemQuantity(
                          item.id,
                          newQuantity,
                        );
                      },
                      onEdit: (updatedItem) {
                        context.read<HomeCubit>().updateCartItem(
                          itemId: updatedItem.id,
                          selectedAddOns: updatedItem.selectedAddOns,
                          spiceLevel: updatedItem.spiceLevel,
                          specialInstructions: updatedItem.specialInstructions,
                        );
                        context.read<HomeCubit>().updateCartItemQuantity(
                          updatedItem.id,
                          updatedItem.quantity,
                        );
                      },
                      onRemove: () {
                        context.read<HomeCubit>().removeFromCart(item.id);
                      },
                    );
                  },
                ),
              ),

              // Cart Summary
              CartSummaryWidget(
                subtotal: state.totalCartPrice,
                onCheckout: () {
                  context.push(RouteConstants.checkoutPath);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.cartEmpty,
            style: AppFonts.styleBold20(
              context,
            ).copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.addItemsToStart,
            style: AppFonts.styleRegular14(
              context,
            ).copyWith(color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: Text(l10n.continueShopping),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
