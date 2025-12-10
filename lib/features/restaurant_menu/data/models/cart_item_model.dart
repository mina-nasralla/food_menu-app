import 'package:equatable/equatable.dart';
import 'addon_model.dart';
import 'menu_item_model.dart';

/// Model representing an item in the shopping cart
class CartItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double basePrice;
  final String imageUrl;
  final int quantity;
  final List<AddOn> selectedAddOns;
  final SpiceLevel? spiceLevel;
  final String? specialInstructions;
  final MenuItem originalItem; // Store original menu item for editing

  const CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.imageUrl,
    required this.quantity,
    required this.originalItem,
    this.selectedAddOns = const [],
    this.spiceLevel,
    this.specialInstructions,
  });

  /// Calculate price per item including add-ons
  double get pricePerItem {
    final addOnsTotal = selectedAddOns.fold(0.0, (sum, addon) => sum + (addon.price * addon.quantity));
    return basePrice + (addOnsTotal / quantity);
  }

  /// Calculate total price for this item (pricePerItem * quantity)
  double get totalPrice => pricePerItem * quantity;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        basePrice,
        imageUrl,
        quantity,
        selectedAddOns,
        spiceLevel,
        specialInstructions,
        originalItem,
      ];

  /// Create a copy with updated values
  CartItem copyWith({
    String? id,
    String? name,
    String? description,
    double? basePrice,
    String? imageUrl,
    int? quantity,
    List<AddOn>? selectedAddOns,
    SpiceLevel? spiceLevel,
    String? specialInstructions,
    MenuItem? originalItem,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      spiceLevel: spiceLevel ?? this.spiceLevel,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      originalItem: originalItem ?? this.originalItem,
    );
  }
}
