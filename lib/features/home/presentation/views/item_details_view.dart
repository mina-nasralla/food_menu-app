import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/addon_model.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/menu_item_model.dart';
import '../cubits/home_cubit.dart';
import '../widgets/item_details/item_quantity_selector.dart';
import '../widgets/item_details/item_spice_level_selector.dart';
import '../widgets/item_details/item_addons_section.dart';
import '../widgets/item_details/item_special_instructions.dart';
import '../widgets/item_details/item_bottom_cart_button.dart';

/// Item details page
class ItemDetailsView extends StatefulWidget {
  final MenuItem menuItem;
  final CartItem? cartItemToEdit; // Optional: for editing existing cart items

  const ItemDetailsView({
    super.key,
    required this.menuItem,
    this.cartItemToEdit,
  });

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  late SpiceLevel _selectedSpiceLevel;
  late final Set<String> _selectedAddOnIds;
  late final Map<String, int> _addOnQuantities; // Track quantity for each add-on
  late final TextEditingController _instructionsController;
  late int _quantity;

  bool get _isEditMode => widget.cartItemToEdit != null;

  @override
  void initState() {
    super.initState();
    
    // Initialize with cart item data if editing, otherwise use defaults
    if (_isEditMode) {
      final cartItem = widget.cartItemToEdit!;
      _quantity = cartItem.quantity;
      _selectedSpiceLevel = cartItem.spiceLevel ?? SpiceLevel.none;
      _selectedAddOnIds = cartItem.selectedAddOns.map((a) => a.id).toSet();
      _addOnQuantities = Map.fromEntries(
        cartItem.selectedAddOns.map((a) => MapEntry(a.id, a.quantity)),
      );
      _instructionsController = TextEditingController(
        text: cartItem.specialInstructions ?? '',
      );
    } else {
      _quantity = 1;
      _selectedSpiceLevel = SpiceLevel.none;
      _selectedAddOnIds = {};
      _addOnQuantities = {};
      _instructionsController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  List<AddOn> get _selectedAddOns {
    return widget.menuItem.availableAddOns
        .where((addon) => _selectedAddOnIds.contains(addon.id))
        .map((addon) {
          final quantity = _addOnQuantities[addon.id] ?? _quantity;
          return addon.copyWith(quantity: quantity);
        })
        .toList();
  }

  double get _totalPrice {
    final baseTotal = widget.menuItem.basePrice * _quantity;
    final addOnsTotal = _selectedAddOns.fold(0.0, (sum, addon) => sum + (addon.price * addon.quantity));
    return baseTotal + addOnsTotal;
  }

  /// Get add-on quantity for a specific add-on
  int _getAddOnQuantity(String addonId) {
    return _addOnQuantities[addonId] ?? _quantity;
  }

  /// Update add-on quantity
  void _updateAddOnQuantity(String addonId, int quantity) {
    setState(() {
      _addOnQuantities[addonId] = quantity;
    });
  }

  /// Handle add-on toggle
  void _handleAddOnToggle(String addonId, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedAddOnIds.add(addonId);
        _addOnQuantities[addonId] = _quantity;
      } else {
        _selectedAddOnIds.remove(addonId);
        _addOnQuantities.remove(addonId);
      }
    });
  }

  /// Handle add to cart or update cart
  void _handleAddToCart() {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<HomeCubit>();
    
    if (_isEditMode) {
      // Update existing cart item
      cubit.updateCartItem(
        itemId: widget.cartItemToEdit!.id,
        selectedAddOns: _selectedAddOns,
        spiceLevel: widget.menuItem.hasSpiceLevelOption ? _selectedSpiceLevel : null,
        specialInstructions: _instructionsController.text.isEmpty
            ? null
            : _instructionsController.text,
      );
      
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Cart item updated!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // Add new item to cart
      cubit.addToCart(
        id: widget.menuItem.id,
        name: widget.menuItem.name,
        description: widget.menuItem.description,
        basePrice: widget.menuItem.basePrice,
        imageUrl: widget.menuItem.imageUrl,
        originalItem: widget.menuItem,
        selectedAddOns: _selectedAddOns,
        spiceLevel: widget.menuItem.hasSpiceLevelOption ? _selectedSpiceLevel : null,
        specialInstructions: _instructionsController.text.isEmpty
            ? null
            : _instructionsController.text,
      );

      // Update quantity for this item
      cubit.incrementItemQuantity(widget.menuItem.id);
      for (int i = 1; i < _quantity; i++) {
        cubit.incrementItemQuantity(widget.menuItem.id);
      }

      Navigator.of(context).pop();
      
      final itemText = _quantity > 1 ? l10n.items : l10n.item;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.addedToCart(_quantity, itemText)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: theme.appBarTheme.backgroundColor,
            foregroundColor: theme.appBarTheme.foregroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.menuItem.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.menuItem.name,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.menuItem.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${widget.menuItem.basePrice.toStringAsFixed(2)}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.menuItem.preparationTime} ${l10n.preparationTime}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Divider(height: 1, color: theme.dividerColor),

                // Quantity Selector (only show if not editing)
                if (!_isEditMode)
                  ItemQuantitySelector(
                    quantity: _quantity,
                    onIncrement: () => setState(() => _quantity++),
                    onDecrement: () => setState(() => _quantity--),
                  ),

                if (!_isEditMode) Divider(height: 1, color: theme.dividerColor),

                // Spice Level Section
                if (widget.menuItem.hasSpiceLevelOption) ...[
                  ItemSpiceLevelSelector(
                    selectedLevel: _selectedSpiceLevel,
                    onLevelChanged: (level) => setState(() => _selectedSpiceLevel = level),
                  ),
                  Divider(height: 1, color: theme.dividerColor),
                ],

                // Add-ons Section
                if (widget.menuItem.availableAddOns.isNotEmpty) ...[
                  ItemAddonsSection(
                    availableAddOns: widget.menuItem.availableAddOns,
                    selectedAddOnIds: _selectedAddOnIds,
                    mainQuantity: _quantity,
                    getAddOnQuantity: _getAddOnQuantity,
                    onAddOnToggle: _handleAddOnToggle,
                    onAddOnQuantityChange: _updateAddOnQuantity,
                  ),
                  Divider(height: 1, color: theme.dividerColor),
                ],

                // Special Instructions
                ItemSpecialInstructions(
                  controller: _instructionsController,
                ),

                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          ),
        ],
      ),

      // Bottom Add to Cart Button
      bottomNavigationBar: ItemBottomCartButton(
        quantity: _quantity,
        totalPrice: _totalPrice,
        onAddToCart: _handleAddToCart,
      ),
    );
  }
}
