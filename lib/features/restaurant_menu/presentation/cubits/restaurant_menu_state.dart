import 'package:equatable/equatable.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import '../../data/models/cart_item_model.dart';
import '../../../cart/data/models/order_model.dart';

/// RestaurantMenu state
class RestaurantMenuState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  final Map<String, int> itemQuantities;
  final List<CartItem> cartItems;
  final Order? lastOrder;
  final bool isPlacingOrder;
  final String? selectedCategory;
  final List<AddOn> addons;
  final bool isLoadingAddons;
  final String addonSearchTerm;
  final String menuSearchTerm;

  const RestaurantMenuState({
    this.isLoading = false,
    this.isGridView = false, // Default to list view on mobile
    this.itemQuantities = const {},
    this.cartItems = const [],
    this.lastOrder,
    this.isPlacingOrder = false,
    this.selectedCategory,
    this.addons = const [],
    this.isLoadingAddons = false,
    this.addonSearchTerm = '',
    this.menuSearchTerm = '',
  });

  /// Calculate total cart price
  double get totalCartPrice {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Get total number of items in cart
  int get totalCartItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  List<Object?> get props => [isLoading, isGridView, itemQuantities, cartItems, lastOrder, isPlacingOrder, selectedCategory, addons, isLoadingAddons, addonSearchTerm, menuSearchTerm];

  RestaurantMenuState copyWith({
    bool? isLoading,
    bool? isGridView,
    Map<String, int>? itemQuantities,
    List<CartItem>? cartItems,
    Order? lastOrder,
    bool? isPlacingOrder,
    String? selectedCategory,
    List<AddOn>? addons,
    bool? isLoadingAddons,
    String? addonSearchTerm,
    String? menuSearchTerm,
  }) {
    return RestaurantMenuState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      itemQuantities: itemQuantities ?? this.itemQuantities,
      cartItems: cartItems ?? this.cartItems,
      lastOrder: lastOrder ?? this.lastOrder,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      addons: addons ?? this.addons,
      isLoadingAddons: isLoadingAddons ?? this.isLoadingAddons,
      addonSearchTerm: addonSearchTerm ?? this.addonSearchTerm,
      menuSearchTerm: menuSearchTerm ?? this.menuSearchTerm,
    );
  }
}
