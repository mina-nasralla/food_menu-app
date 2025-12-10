import 'package:flutter/material.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/menu_item_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

/// Sample menu items data
class SampleMenuItems {
  static List<MenuItem> getLocalizedItems(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return [
      // Burgers
      MenuItem(
        id: 'burger_1',
        name: localizations.burger1Name,
        description: localizations.burger1Desc,
        basePrice: 8.99,
        imageUrl: 'assets/img.jpg',
        category: 'burgers',
        hasSpiceLevelOption: true,
        preparationTime: 20,
        availableAddOns: [
          AddOn(
            id: 'addon_cheese',
            name: localizations.addonCheese,
            description: localizations.addonCheeseDesc,
            price: 0.80,
          ),
          AddOn(
            id: 'addon_bacon',
            name: localizations.addonBacon,
            description: localizations.addonBaconDesc,
            price: 1.20,
          ),
          AddOn(
            id: 'addon_combo',
            name: localizations.addonCombo,
            description: localizations.addonComboDesc,
            price: 3.50,
          ),
        ],
      ),
      MenuItem(
        id: 'burger_2',
        name: localizations.burger2Name,
        description: localizations.burger2Desc,
        basePrice: 9.99,
        imageUrl: 'assets/img.jpg',
        category: 'burgers',
        hasSpiceLevelOption: true,
        preparationTime: 18,
        availableAddOns: [
          AddOn(
            id: 'addon_cheese',
            name: localizations.addonCheese,
            description: localizations.addonCheeseDesc,
            price: 0.80,
          ),
          AddOn(
            id: 'addon_avocado',
            name: localizations.addonAvocado,
            description: localizations.addonAvocadoDesc,
            price: 1.50,
          ),
          AddOn(
            id: 'addon_combo',
            name: localizations.addonCombo,
            description: localizations.addonComboDesc,
            price: 3.50,
          ),
        ],
      ),
      MenuItem(
        id: 'burger_3',
        name: localizations.burger3Name,
        description: localizations.burger3Desc,
        basePrice: 7.99,
        imageUrl: 'assets/img.jpg',
        category: 'burgers',
        hasSpiceLevelOption: false,
        preparationTime: 15,
        availableAddOns: [
          AddOn(
            id: 'addon_avocado',
            name: localizations.addonAvocado,
            description: localizations.addonAvocadoDesc,
            price: 1.50,
          ),
          AddOn(
            id: 'addon_mushrooms',
            name: localizations.addonMushrooms,
            description: localizations.addonMushroomsDesc,
            price: 1.00,
          ),
          AddOn(
            id: 'addon_combo',
            name: localizations.addonCombo,
            description: localizations.addonComboDesc,
            price: 3.50,
          ),
        ],
      ),

      // Pizza
      MenuItem(
        id: 'pizza_1',
        name: 'Margherita Pizza',
        description: 'Classic tomato sauce, mozzarella cheese, and fresh basil.',
        basePrice: 12.99,
        imageUrl: 'assets/img.jpg',
        category: 'pizza',
        preparationTime: 25,
        availableAddOns: [
          AddOn(id: 'extra_cheese', name: 'Extra Cheese', description: 'More mozzarella', price: 2.00),
        ],
      ),
      MenuItem(
        id: 'pizza_2',
        name: 'Pepperoni Pizza',
        description: 'Spicy pepperoni slices on top of melted mozzarella.',
        basePrice: 14.99,
        imageUrl: 'assets/img.jpg',
        category: 'pizza',
        preparationTime: 25,
        availableAddOns: [
          AddOn(id: 'extra_pepperoni', name: 'Extra Pepperoni', description: 'More pepperoni', price: 2.50),
        ],
      ),

      // Drinks
      MenuItem(
        id: 'drink_1',
        name: 'Cola',
        description: 'Chilled refreshing cola drink.',
        basePrice: 2.50,
        imageUrl: 'assets/img.jpg',
        category: 'drinks',
        preparationTime: 2,
      ),
      MenuItem(
        id: 'drink_2',
        name: 'Orange Juice',
        description: 'Freshly squeezed orange juice.',
        basePrice: 3.99,
        imageUrl: 'assets/img.jpg',
        category: 'drinks',
        preparationTime: 5,
      ),

      // Desserts
      MenuItem(
        id: 'dessert_1',
        name: 'Chocolate Cake',
        description: 'Rich chocolate layer cake with ganache frosting.',
        basePrice: 6.50,
        imageUrl: 'assets/img.jpg',
        category: 'desserts',
        preparationTime: 0,
      ),
      MenuItem(
        id: 'dessert_2',
        name: 'Ice Cream Sundae',
        description: 'Vanilla ice cream with chocolate syrup and a cherry.',
        basePrice: 5.99,
        imageUrl: 'assets/img.jpg',
        category: 'desserts',
        preparationTime: 5,
      ),
    ];
  }

  static MenuItem getById(String id, BuildContext context) {
    final items = getLocalizedItems(context);
    return items.firstWhere(
          (item) => item.id == id,
      orElse: () => items[0],
    );
  }
}
