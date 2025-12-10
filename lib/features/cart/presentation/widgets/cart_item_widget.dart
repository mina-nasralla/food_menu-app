import 'package:flutter/material.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/cart_item_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

import '../../../../core/utilities/app_fonts.dart';
import 'edit_cart_item_dialog.dart';

/// Widget for displaying a single cart item with expandable details
class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final Function(AddOn addOn, bool isAdding) onAddOnChanged;
  final Function(int newQuantity) onQuantityChanged;
  final Function(CartItem updatedItem) onEdit;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key, 
    required this.item,
    required this.onAddOnChanged,
    required this.onQuantityChanged,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int _quantity;
  late List<AddOn> _selectedAddOns;

  @override
  void initState() {
    super.initState();
    _quantity = widget.item.quantity;
    _selectedAddOns = List.from(widget.item.selectedAddOns);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalAddOnsPrice = widget.item.selectedAddOns.fold<double>(
      0, 
      (sum, addOn) => sum + (addOn.price * addOn.quantity)
    );
    final totalPrice = (widget.item.basePrice + totalAddOnsPrice) * widget.item.quantity;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item header with image, name, and price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.item.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                
                // Item Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.name,
                              style: AppFonts.styleBold16(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: _showEditDialog,
                            icon: const Icon(Icons.edit_outlined, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            onPressed: widget.onRemove,
                            icon: const Icon(Icons.delete_outline, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ],
                      ),
                      Text(
                        widget.item.description,
                        style: AppFonts.styleRegular12(context).copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${widget.item.pricePerItem.toStringAsFixed(2)} ${l10n.each}',
                        style: AppFonts.styleRegular14(context).copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Add-ons section
            if (_selectedAddOns.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 8),
              Text(
                l10n.addOns,
                style: AppFonts.styleRegular14(context).copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 8),
              ..._selectedAddOns.map((addOn) => _buildAddOnItem(addOn)),
            ],
            
            // Quantity and total price
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _quantity > 1 ? () {
                          setState(() {
                            _quantity--;
                            widget.onQuantityChanged(_quantity);
                          });
                        } : null,
                        icon: const Icon(Icons.remove, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        color: _quantity > 1 ? Theme.of(context).textTheme.bodyLarge?.color : Theme.of(context).disabledColor,
                      ),
                      SizedBox(
                        width: 30,
                        child: Text(
                          _quantity.toString(),
                          textAlign: TextAlign.center,
                          style: AppFonts.styleRegular14(context),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                            widget.onQuantityChanged(_quantity);
                          });
                        },
                        icon: const Icon(Icons.add, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                
                // Total price
                Text(
                  '${l10n.total}: \$${totalPrice.toStringAsFixed(2)}',
                  style: AppFonts.styleBold16(context).copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnItem(AddOn addOn) {
    final totalAddonPrice = addOn.price * addOn.quantity;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              addOn.name,
              style: AppFonts.styleRegular12(context).copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          if (addOn.quantity > 1)
            Text(
              'x${addOn.quantity} ',
              style: AppFonts.styleRegular12(context).copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          Text(
            '+\$${totalAddonPrice.toStringAsFixed(2)}',
            style: AppFonts.styleRegular12(context).copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog() async {
    final updatedItem = await showDialog<CartItem>(
      context: context,
      builder: (context) => EditCartItemDialog(cartItem: widget.item),
    );

    if (updatedItem != null) {
      widget.onEdit(updatedItem);
    }
  }
}
