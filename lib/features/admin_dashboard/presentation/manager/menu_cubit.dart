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
    // Dummy Data
    final initialAddons = [
      const AddOn(id: 'a1', name: 'Extra Cheese', description: 'Cheddar cheese slice', price: 1.50),
      const AddOn(id: 'a2', name: 'Spicy Sauce', description: 'Hot chili sauce', price: 0.50),
    ];

    final initialItems = [
      const MenuItem(
        id: 'i1',
        name: 'Classic Burger',
        description: 'Beef patty with lettuce and tomato',
        basePrice: 8.99,
        imageUrl: 'https://placeholder.com/burger',
        category: 'burger',
        availableAddOns: [],
      ),
    ];

    final initialOffers = [
      const OfferModel(
        id: 'o1',
        title: 'Family Meal',
        description: '4 Burgers + 4 Fries + 4 Drinks',
        price: 35.00,
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80',
        isActive: true,
        linkTo: 'Category',
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
}
