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

    if (quantity == 0) {
      // Show Add button when quantity is 0
      if (isCompact) {
        return GestureDetector(
          onTap: () => cubit.incrementItemQuantity(itemId),
          child: const Icon(
            Icons.add_circle,
            color: AppColors.primaryLight,
            size: 28,
          ),
        );
      } else {
        return ElevatedButton(
          onPressed: () => cubit.incrementItemQuantity(itemId),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: Colors.white,
            minimumSize: const Size(80, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Add'),
        );
      }
    } else {
      // Show increment/decrement controls when quantity > 0
      if (isCompact) {
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
      } else {
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
  }
}
