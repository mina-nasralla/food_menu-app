import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../cubits/restaurant_menu_cubit.dart';

class QuantityControl extends StatelessWidget {
  final String itemId;
  final bool isCompact;

  const QuantityControl({
    super.key,
    required this.itemId,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantMenuCubit>();
    final quantity = context.select<RestaurantMenuCubit, int>(
      (cubit) => cubit.getItemQuantity(itemId),
    );

    return isCompact ? _buildCompactControl(context, cubit, quantity) : _buildFullControl(context, cubit, quantity);
  }

  Widget _buildCompactControl(BuildContext context, RestaurantMenuCubit cubit, int quantity) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => cubit.decrementItemQuantity(itemId),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.remove_circle,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 24),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: AppFonts.styleRegular14(
                context,
              ).copyWith(color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () => cubit.incrementItemQuantity(itemId),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.add_circle, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullControl(BuildContext context, RestaurantMenuCubit cubit, int quantity) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => cubit.decrementItemQuantity(itemId),
            icon: const Icon(Icons.remove, color: Colors.white, size: 18),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 32),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: AppFonts.styleBold16(
                context,
              ).copyWith(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () => cubit.incrementItemQuantity(itemId),
            icon: const Icon(Icons.add, color: Colors.white, size: 18),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }
}
