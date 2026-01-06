import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/menu_item_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/repositories/restaurant_repository.dart';
import '../../data/models/cart_item_model.dart';
import '../../../cart/data/models/order_model.dart';
import 'restaurant_menu_state.dart';

/// Cubit for managing restaurant menu logic
class RestaurantMenuCubit extends Cubit<RestaurantMenuState> {
  final RestaurantRepository _repository;

  RestaurantMenuCubit({RestaurantRepository? repository})
      : _repository = repository ?? RestaurantRepository(),
        super(const RestaurantMenuState());

  /// Initialize home page
  void initialize() {
    fetchAddons();
  }

  /// Fetch addons from Supabase
  Future<void> fetchAddons() async {
    emit(state.copyWith(isLoadingAddons: true));
    try {
      final addons = await _repository.getAddons();
      emit(state.copyWith(
        addons: addons,
        isLoadingAddons: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoadingAddons: false));
      // In a real app, you might want to emit an error state or show a snackbar
    }
  }

  /// Toggle between grid and list view
  void toggleViewMode() {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  /// Update addon search term
  void setAddonSearchTerm(String term) {
    emit(state.copyWith(addonSearchTerm: term));
  }

  /// Update menu search term
  void setMenuSearchTerm(String term) {
    emit(state.copyWith(menuSearchTerm: term));
  }

  /// Get quantity for a specific item
  int getItemQuantity(String itemId) {
    return state.itemQuantities[itemId] ?? 0;
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
    if (currentQuantity > 0) {
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
    final quantity = state.itemQuantities[id] ?? 1;
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
    
    // Reset the quantity selector for this item back to 0 (or 1 depending on UX)
    final updatedQuantities = Map<String, int>.from(state.itemQuantities);
    updatedQuantities[id] = 0;
    
    emit(state.copyWith(
      cartItems: updatedCart,
      itemQuantities: updatedQuantities,
    ));
  }
  
  /// Add add-on as a standalone item to cart
  void addAddonToCart(AddOn addon) {
    final quantity = getItemQuantity(addon.id);
    if (quantity == 0) return;

    final updatedCart = List<CartItem>.from(state.cartItems);
    
    // Convert AddOn to a dummy MenuItem for CartItem compatibility
    final dummyMenuItem = MenuItem(
      id: addon.id,
      name: addon.name,
      description: addon.description,
      price: addon.price,
      categoryId: 'addons',
      createdAt: addon.createdAt ?? DateTime.now(),
      imageUrl: addon.imageUrl,
    );

    // Check if it's already in the cart as a standalone item
    final existingIndex = updatedCart.indexWhere((item) => item.id == addon.id);

    if (existingIndex != -1) {
      updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
        quantity: updatedCart[existingIndex].quantity + quantity,
      );
    } else {
      updatedCart.add(CartItem(
        id: addon.id,
        name: addon.name,
        description: addon.description,
        basePrice: addon.price,
        imageUrl: addon.imageUrl ?? '',
        quantity: quantity,
        originalItem: dummyMenuItem,
      ));
    }

    // Reset quantity
    final updatedQuantities = Map<String, int>.from(state.itemQuantities);
    updatedQuantities[addon.id] = 0;

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
  Future<void> placeOrder({
    required String name,
    required String phone,
    required String address,
    String? notes,
  }) async {
    // Set placing order state
    emit(state.copyWith(isPlacingOrder: true));

    try {
      // Prepare items for JSON
      final itemsJson = state.cartItems.map((item) {
        return {
          'name': item.name,
          'price': item.basePrice,
          'quantity': item.quantity,
          'item_id': item.id,
          'addons': item.selectedAddOns.map((addon) => {
            'name': addon.name,
            'price': addon.price,
            'addon_id': addon.id,
          }).toList(),
        };
      }).toList();

      // Try to parse coordinates if address is in "Lat: x, Lng: y" format
      double? latitude;
      double? longitude;
      
      if (address.startsWith('Lat:')) {
        try {
          final parts = address.split(',');
          if (parts.length == 2) {
            final latPart = parts[0].trim().substring(4).trim();
            final lngPart = parts[1].trim().substring(4).trim();
            latitude = double.tryParse(latPart);
            longitude = double.tryParse(lngPart);
          }
        } catch (_) {
          // Ignore parsing errors
        }
      }

      // Convert total price to double if needed (state.totalCartPrice is double)
      // Note: we removed fees, so total is just items total
      
      await _repository.submitOrder(
        customerName: name, // We might need to add name field to UI
        customerPhone: phone,
        address: address,
        latitude: latitude,
        longitude: longitude,
        items: itemsJson,
        notes: notes,
        totalPrice: state.totalCartPrice,
      );

      // Clear cart
      emit(state.copyWith(
        cartItems: const [],
        isPlacingOrder: false,
      ));
    } catch (e) {
      print('Error placing order: $e'); // For debugging
      emit(state.copyWith(
        isPlacingOrder: false,
        // In a real app, store error in state to show UI feedback
      ));
      rethrow; // Re-throw to handle in UI
    }
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
