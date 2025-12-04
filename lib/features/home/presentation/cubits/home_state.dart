import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';
import '../../../cart/data/models/order_model.dart';

/// Home state
class HomeState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  final Map<String, int> itemQuantities;
  final List<CartItem> cartItems;
  final Order? lastOrder;
  final bool isPlacingOrder;
  final String? selectedCategory;

  const HomeState({
    this.isLoading = false,
    this.isGridView = true, // Default to grid view
    this.itemQuantities = const {},
    this.cartItems = const [],
    this.lastOrder,
    this.isPlacingOrder = false,
    this.selectedCategory,
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
  List<Object?> get props => [isLoading, isGridView, itemQuantities, cartItems, lastOrder, isPlacingOrder, selectedCategory];

  HomeState copyWith({
    bool? isLoading,
    bool? isGridView,
    Map<String, int>? itemQuantities,
    List<CartItem>? cartItems,
    Order? lastOrder,
    bool? isPlacingOrder,
    String? selectedCategory,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      itemQuantities: itemQuantities ?? this.itemQuantities,
      cartItems: cartItems ?? this.cartItems,
      lastOrder: lastOrder ?? this.lastOrder,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
