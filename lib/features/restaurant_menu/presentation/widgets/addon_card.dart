import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/addon_model.dart';
import '../cubits/restaurant_menu_cubit.dart';
import 'quantity_control_widget.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

class AddonCard extends StatelessWidget {
  final AddOn addon;

  const AddonCard({
    super.key,
    required this.addon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: addon.imageUrl != null && addon.imageUrl!.isNotEmpty
                  ? Image.network(
                      addon.imageUrl!,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(theme),
                    )
                  : _buildPlaceholder(theme),
            ),

            Text(
              addon.name,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${addon.price.toStringAsFixed(2)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                QuantityControl(itemId: addon.id, isCompact: true),

              ],
            ),

            SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  context.read<RestaurantMenuCubit>().addAddonToCart(addon);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.addToCart,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      height: 70, // Reduced from 80
      width: double.infinity,
      color: theme.colorScheme.primaryContainer.withOpacity(0.2),
      child: Icon(
        Icons.add_shopping_cart,
        color: theme.colorScheme.primary,
        size: 30,
      ),
    );
  }
}
