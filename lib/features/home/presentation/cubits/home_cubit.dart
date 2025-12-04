import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/home/data/models/addon_model.dart';
import 'package:food_menu_app/features/home/data/models/menu_item_model.dart';
import '../../data/models/cart_item_model.dart';
import '../../../cart/data/models/order_model.dart';
import 'home_state.dart';

/// Cubit for managing home page logic
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  /// Initialize home page
  void initialize() {
    // Add initialization logic here when needed
  }

  /// Toggle between grid and list view
  void toggleViewMode() {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  /// Get quantity for a specific item
  int getItemQuantity(String itemId) {
    return state.itemQuantities[itemId] ?? 1;
  }

  /// Increment item quantity
  void incrementItemQuantity(String itemId) {
    final currentQuantity = getItemQuantity(itemId);
    final updatedQuantities = Map<String, int>.from(state.itemQuantities);
    updatedQuantities[itemId] = currentQuantity + 1;
    emit(state.copyWith(itemQuantities: updatedQuantities));
  }

  /// Decrement item quantity
  void decrementItemQuantity(String itemId) {
    final currentQuantity = getItemQuantity(itemId);
    if (currentQuantity > 1) {
      final updatedQuantities = Map<String, int>.from(state.itemQuantities);
      updatedQuantities[itemId] = currentQuantity - 1;
      emit(state.copyWith(itemQuantities: updatedQuantities));
    }
  }

  /// Add item to cart
  void addToCart({
    required String id,
    required String name,
    required String description,
    required double basePrice,
    required String imageUrl,
    required MenuItem originalItem,
    List<AddOn> selectedAddOns = const [],
    SpiceLevel? spiceLevel,
    String? specialInstructions,
  }) {
    final quantity = getItemQuantity(id);
    final updatedCart = List<CartItem>.from(state.cartItems);
    
    // Check if item already exists in cart with same customization
    final existingIndex = updatedCart.indexWhere((item) => 
      item.id == id && 
      item.selectedAddOns == selectedAddOns &&
      item.spiceLevel == spiceLevel &&
      item.specialInstructions == specialInstructions
    );
    
    if (existingIndex != -1) {
      // Update existing item quantity
      updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
        quantity: updatedCart[existingIndex].quantity + quantity,
      );
    } else {
      // Add new item to cart
      updatedCart.add(CartItem(
        id: id,
        name: name,
        description: description,
        basePrice: basePrice,
        imageUrl: imageUrl,
        quantity: quantity,
        originalItem: originalItem,
        selectedAddOns: selectedAddOns,
        spiceLevel: spiceLevel,
        specialInstructions: specialInstructions,
      ));
    }
    
    // Reset the quantity selector for this item back to 1
    final updatedQuantities = Map<String, int>.from(state.itemQuantities);
    updatedQuantities[id] = 1;
    
    emit(state.copyWith(
      cartItems: updatedCart,
      itemQuantities: updatedQuantities,
    ));
  }

  /// Remove item from cart
  void removeFromCart(String itemId) {
    final updatedCart = state.cartItems.where((item) => item.id != itemId).toList();
    emit(state.copyWith(cartItems: updatedCart));
  }

  /// Update cart item quantity
  void updateCartItemQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(itemId);
      return;
    }
    
    final updatedCart = state.cartItems.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
    
    emit(state.copyWith(cartItems: updatedCart));
  }

  /// Update an existing cart item with new customizations
  void updateCartItem({
    required String itemId,
    List<AddOn>? selectedAddOns,
    SpiceLevel? spiceLevel,
    String? specialInstructions,
  }) {
    final updatedCart = state.cartItems.map((item) {
      if (item.id == itemId) {
        return item.copyWith(
          selectedAddOns: selectedAddOns,
          spiceLevel: spiceLevel,
          specialInstructions: specialInstructions,
        );
      }
      return item;
    }).toList();
    
    emit(state.copyWith(cartItems: updatedCart));
  }

  /// Update or add an add-on to a cart item
  void updateCartItemAddOn(String itemId, AddOn addOn) {
    final updatedCart = state.cartItems.map((item) {
      if (item.id == itemId) {
        final updatedAddOns = List<AddOn>.from(item.selectedAddOns);
        final existingIndex = updatedAddOns.indexWhere((a) => a.id == addOn.id);
        
        if (existingIndex != -1) {
          // Update existing add-on quantity
          updatedAddOns[existingIndex] = updatedAddOns[existingIndex].copyWith(
            quantity: updatedAddOns[existingIndex].quantity + 1,
          );
        } else {
          // Add new add-on
          updatedAddOns.add(addOn);
        }
        
        return item.copyWith(selectedAddOns: updatedAddOns);
      }
      return item;
    }).toList();
    
    emit(state.copyWith(cartItems: updatedCart));
  }

  /// Remove an add-on from a cart item
  void removeAddOnFromCartItem(String itemId, AddOn addOn) {
    final updatedCart = state.cartItems.map((item) {
      if (item.id == itemId) {
        final updatedAddOns = List<AddOn>.from(item.selectedAddOns);
        final existingIndex = updatedAddOns.indexWhere((a) => a.id == addOn.id);
        
        if (existingIndex != -1) {
          if (updatedAddOns[existingIndex].quantity > 1) {
            // Decrease quantity
            updatedAddOns[existingIndex] = updatedAddOns[existingIndex].copyWith(
              quantity: updatedAddOns[existingIndex].quantity - 1,
            );
          } else {
            // Remove add-on completely
            updatedAddOns.removeAt(existingIndex);
          }
        }
        
        return item.copyWith(selectedAddOns: updatedAddOns);
      }
      return item;
    }).toList();
    
    emit(state.copyWith(cartItems: updatedCart));
  }


  /// Place an order
  void placeOrder(Order order) {
    // Set placing order state
    emit(state.copyWith(isPlacingOrder: true));
    
    // Simulate API call delay (in production, this would be an actual API call)
    Future.delayed(const Duration(milliseconds: 500), () {
      // Store the order and clear cart
      emit(state.copyWith(
        lastOrder: order,
        cartItems: const [],
        isPlacingOrder: false,
      ));
    });
  }

  /// Clear entire cart
  void clearCart() {
    emit(state.copyWith(cartItems: const []));
  }

  /// Select a category
  void selectCategory(String? category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
