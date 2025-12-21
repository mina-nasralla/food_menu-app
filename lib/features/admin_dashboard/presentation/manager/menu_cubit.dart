import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/offer_model.dart';
import '../../../restaurant_menu/data/models/menu_item_model.dart';
import '../../../restaurant_menu/data/models/addon_model.dart';

// State
abstract class MenuState extends Equatable {
  const MenuState();
  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoaded extends MenuState {
  final List<OfferModel> offers;
  final List<MenuItem> items;
  final List<AddOn> addons;

  const MenuLoaded({
    this.offers = const [],
    this.items = const [],
    this.addons = const [],
  });

  @override
  List<Object?> get props => [offers, items, addons];

  MenuLoaded copyWith({
    List<OfferModel>? offers,
    List<MenuItem>? items,
    List<AddOn>? addons,
  }) {
    return MenuLoaded(
      offers: offers ?? this.offers,
      items: items ?? this.items,
      addons: addons ?? this.addons,
    );
  }
}

// Cubit
class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());

  void loadInitialData() {
    // Dummy Addons
    final aCheese = const AddOn(id: 'a1', name: 'Extra Cheese', description: 'Cheddar cheese slice', price: 1.50, isAvailable: true);
    final aSauce = const AddOn(id: 'a2', name: 'Spicy Sauce', description: 'Hot chili sauce', price: 0.50, isAvailable: true);
    final aBacon = const AddOn(id: 'a3', name: 'Crispy Bacon', description: 'Smoked bacon strips', price: 2.00, isAvailable: true);
    final aDrinkResize = const AddOn(id: 'a4', name: 'Upsize Drink', description: 'Upgrade to Large', price: 1.00, isAvailable: true);
    final aFriesResize = const AddOn(id: 'a5', name: 'Upsize Fries', description: 'Upgrade to Large', price: 1.50, isAvailable: true);
    final aPepperoni = const AddOn(id: 'a6', name: 'Extra Pepperoni', description: 'More pepperoni slices', price: 2.50, isAvailable: true);
    final aMushrooms = const AddOn(id: 'a7', name: 'Mushrooms', description: 'Fresh sliced mushrooms', price: 1.00, isAvailable: true);

    final initialAddons = [aCheese, aSauce, aBacon, aDrinkResize, aFriesResize, aPepperoni, aMushrooms];

    // Dummy Items
    final initialItems = [
      // Burgers
      MenuItem(
        id: 'i1',
        name: 'Classic Burger',
        description: 'Beef patty with lettuce and tomato',
        basePrice: 8.99,
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80',
        category: 'burger',
        availableAddOns: [aCheese, aSauce, aBacon, aFriesResize],
        isAvailable: true,
      ),
      MenuItem(
        id: 'i2',
        name: 'Double Cheeseburger',
        description: 'Two beef patties, double cheese',
        basePrice: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500&q=80',
        category: 'burger',
        availableAddOns: [aSauce, aBacon],
        isAvailable: true,
      ),
      MenuItem(
        id: 'i3',
        name: 'Chicken Sandwich',
        description: 'Crispy chicken breast with mayo',
        basePrice: 9.50,
        imageUrl: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=500&q=80',
        category: 'burger',
        availableAddOns: [aCheese, aSauce],
        isAvailable: true,
      ),
      // Pizzas
      MenuItem(
        id: 'i4',
        name: 'Margherita Pizza',
        description: 'Tomato sauce, mozzarella, basil',
        basePrice: 14.00,
        imageUrl: 'https://images.unsplash.com/photo-1574071318500-add68d717c36?w=500&q=80',
        category: 'pizza',
        availableAddOns: [aCheese, aPepperoni, aMushrooms],
        isAvailable: true,
      ),
      MenuItem(
        id: 'i5',
        name: 'Pepperoni Feast',
        description: 'Loaded with pepperoni and cheese',
        basePrice: 16.50,
        imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500&q=80',
        category: 'pizza',
        availableAddOns: [aCheese, aMushrooms, aSauce],
        isAvailable: true,
      ),
       // Drinks
      MenuItem(
        id: 'i6',
        name: 'Cola',
        description: 'Refreshing cola drink',
        basePrice: 2.50,
        imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500&q=80',
        category: 'drink',
        availableAddOns: [aDrinkResize],
        isAvailable: true,
      ),
       MenuItem(
        id: 'i7',
        name: 'Fresh Orange Juice',
        description: 'Squeezed fresh daily',
        basePrice: 4.00,
        imageUrl: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500&q=80',
        category: 'drink',
        availableAddOns: [],
        isAvailable: true,
      ),
      // Sides
      MenuItem(
        id: 'i8',
        name: 'French Fries',
        description: 'Golden crispy fries',
        basePrice: 3.50,
        imageUrl: 'https://images.unsplash.com/photo-1630384060421-cb20d0e0649d?w=500&q=80',
        category: 'sides',
        availableAddOns: [aCheese, aSauce, aFriesResize],
        isAvailable: true,
      ),
       MenuItem(
        id: 'i9',
        name: 'Onion Rings',
        description: 'Breaded onion rings',
        basePrice: 4.50,
        imageUrl: 'https://images.unsplash.com/photo-1639024471283-03518883512d?w=500&q=80',
        category: 'sides',
        availableAddOns: [aSauce],
        isAvailable: true,
      ),
    ];

    final initialOffers = [
      const OfferModel(
        id: 'o1',
        title: 'Family Meal',
        description: '4 Burgers + 4 Fries + 4 Drinks',
        price: 35.00,
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80',
        isActive: true, // linkedItemId and selectedAddonIds can be null/empty
      ),
    ];

    emit(MenuLoaded(
      offers: initialOffers,
      items: initialItems,
      addons: initialAddons,
    ));
  }

  void addOffer(OfferModel offer) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      emit(currentState.copyWith(
        offers: [...currentState.offers, offer],
      ));
    }
  }
  
  void deleteOffer(String id) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedOffers = currentState.offers.where((offer) => offer.id != id).toList();
      emit(currentState.copyWith(offers: updatedOffers));
    }
  }

  void toggleOfferStatus(String id) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedOffers = currentState.offers.map((offer) {
        return offer.id == id ? offer.copyWith(isActive: !offer.isActive) : offer;
      }).toList();
      emit(currentState.copyWith(offers: updatedOffers));
    }
  }

  void addItem(MenuItem item) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      emit(currentState.copyWith(
        items: [...currentState.items, item],
      ));
    }
  }

  void deleteItem(String id) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedItems = currentState.items.where((item) => item.id != id).toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }

  void toggleItemVisibility(String id) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedItems = currentState.items.map((item) {
        return item.id == id ? item.copyWith(isAvailable: !item.isAvailable) : item;
      }).toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }

  void addAddon(AddOn addon) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      emit(currentState.copyWith(
        addons: [...currentState.addons, addon],
      ));
    }
  }

  void updateItem(MenuItem updatedItem) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedItems = currentState.items.map((item) {
        return item.id == updatedItem.id ? updatedItem : item;
      }).toList();
      emit(currentState.copyWith(items: updatedItems));
    }
  }
  void deleteAddon(String id) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedAddons = currentState.addons.where((addon) => addon.id != id).toList();
      emit(currentState.copyWith(addons: updatedAddons));
    }
  }

  void updateAddon(AddOn updatedAddon) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedAddons = currentState.addons.map((addon) {
        return addon.id == updatedAddon.id ? updatedAddon : addon;
      }).toList();
      emit(currentState.copyWith(addons: updatedAddons));
    }
  }

  void toggleAddonVisibility(String id) {
    if (state is MenuLoaded) {
      final currentState = state as MenuLoaded;
      final updatedAddons = currentState.addons.map((addon) {
        return addon.id == id ? addon.copyWith(isAvailable: !addon.isAvailable) : addon;
      }).toList();
      emit(currentState.copyWith(addons: updatedAddons));
    }
  }
}
