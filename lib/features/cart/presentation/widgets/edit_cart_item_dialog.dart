import 'package:flutter/material.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/cart_item_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

import '../../../../core/utilities/app_fonts.dart';
/// Dialog for editing cart item details
class EditCartItemDialog extends StatefulWidget {
  final CartItem cartItem;

  const EditCartItemDialog({
    super.key,
    required this.cartItem,
  });

  @override
  State<EditCartItemDialog> createState() => _EditCartItemDialogState();
}

class _EditCartItemDialogState extends State<EditCartItemDialog> {
  late int _quantity;
  late Map<String, int> _addOnQuantities; // Maps add-on ID to quantity

  @override
  void initState() {
    super.initState();
    _quantity = widget.cartItem.quantity;
    
    // Initialize add-on quantities from current cart item
    _addOnQuantities = {};
    for (var addOn in widget.cartItem.selectedAddOns) {
      _addOnQuantities[addOn.id] = addOn.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableAddOns = widget.cartItem.originalItem.availableAddOns;
    final l10n = AppLocalizations.of(context)!;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Theme.of(context).cardColor,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.editOrder,
                      style: AppFonts.styleBold18(context).copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item info
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: widget.cartItem.imageUrl.isNotEmpty
                              ? Image.network(
                                  widget.cartItem.imageUrl,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                                      child: Icon(
                                        Icons.fastfood,
                                        color: Theme.of(context).colorScheme.primary,
                                        size: 30,
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                                  child: Icon(
                                    Icons.fastfood,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 30,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.cartItem.name,
                                style: AppFonts.styleBold16(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${widget.cartItem.basePrice.toStringAsFixed(2)}',
                                style: AppFonts.styleRegular14(context).copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 16),

                    // Quantity selector
                    Text(
                      l10n.quantityLabel,
                      style: AppFonts.styleBold16(context),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: _quantity > 1
                                ? () {
                                    setState(() {
                                      _quantity--;
                                      // Adjust add-on quantities if needed
                                      _addOnQuantities.forEach((key, value) {
                                        if (value > _quantity) {
                                          _addOnQuantities[key] = _quantity;
                                        }
                                      });
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.remove),
                            color: _quantity > 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _quantity.toString(),
                              style: AppFonts.styleBold18(context),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            icon: const Icon(Icons.add),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 16),

                    // Add-ons section
                    if (availableAddOns.isNotEmpty) ...[
                      Text(
                        l10n.addOns,
                        style: AppFonts.styleBold16(context),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.selectAddonsHint,
                        style: AppFonts.styleRegular12(context).copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...availableAddOns.map((addOn) => _buildAddOnItem(addOn)),
                    ],
                  ],
                ),
              ),
            ),

            // Footer with total and save button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${l10n.total}:',
                        style: AppFonts.styleBold16(context),
                      ),
                      Text(
                        '\$${_calculateTotal().toStringAsFixed(2)}',
                        style: AppFonts.styleBold18(context).copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.saveChanges,
                        style: AppFonts.styleBold16(context).copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddOnItem(AddOn addOn) {
    final currentQuantity = _addOnQuantities[addOn.id] ?? 0;
    final isSelected = currentQuantity > 0;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.05) : Theme.of(context).cardColor,
      ),
      child: Column(
        children: [
          // Add-on header
          InkWell(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _addOnQuantities[addOn.id] = 0;
                } else {
                  _addOnQuantities[addOn.id] = _quantity;
                }
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Checkbox
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
                      border: Border.all(
                        color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: isSelected
                        ? Icon(Icons.check, size: 16, color: Theme.of(context).colorScheme.onPrimary)
                        : null,
                  ),
                  const SizedBox(width: 12),

                  // Add-on info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addOn.name,
                          style: AppFonts.styleRegular14(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (addOn.description.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            addOn.description,
                            style: AppFonts.styleRegular12(context).copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Price
                  Text(
                    '+\$${addOn.price.toStringAsFixed(2)}',
                    style: AppFonts.styleRegular14(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Quantity selector (shown when selected)
          if (isSelected) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    l10n.applyTo,
                    style: AppFonts.styleRegular14(context).copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: currentQuantity > 1
                              ? () {
                                  setState(() {
                                    _addOnQuantities[addOn.id] = currentQuantity - 1;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.remove, size: 18),
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                          color: currentQuantity > 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '$currentQuantity ${l10n.ofPreposition} $_quantity',
                            style: AppFonts.styleRegular14(context).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: currentQuantity < _quantity
                              ? () {
                                  setState(() {
                                    _addOnQuantities[addOn.id] = currentQuantity + 1;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.add, size: 18),
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                          color: currentQuantity < _quantity ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  double _calculateTotal() {
    double total = widget.cartItem.basePrice * _quantity;
    
    _addOnQuantities.forEach((addOnId, quantity) {
      if (quantity > 0) {
        final addOn = widget.cartItem.originalItem.availableAddOns
            .firstWhere((a) => a.id == addOnId);
        total += addOn.price * quantity;
      }
    });
    
    return total;
  }

  void _saveChanges() {
    // Build updated add-ons list
    final updatedAddOns = <AddOn>[];
    _addOnQuantities.forEach((addOnId, quantity) {
      if (quantity > 0) {
        final originalAddOn = widget.cartItem.originalItem.availableAddOns
            .firstWhere((a) => a.id == addOnId);
        updatedAddOns.add(originalAddOn.copyWith(quantity: quantity));
      }
    });

    // Return updated cart item
    final updatedCartItem = widget.cartItem.copyWith(
      quantity: _quantity,
      selectedAddOns: updatedAddOns,
    );

    Navigator.pop(context, updatedCartItem);
  }
}
