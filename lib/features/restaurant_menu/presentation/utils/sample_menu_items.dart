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
        price: 8.99,
        categoryId: 'burgers',
        categoryName: 'Burgers',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
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
        price: 9.99,
        categoryId: 'burgers',
        categoryName: 'Burgers',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
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
        price: 7.99,
        categoryId: 'burgers',
        categoryName: 'Burgers',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
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
        price: 12.99,
        categoryId: 'pizza',
        categoryName: 'Pizza',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
        preparationTime: 25,
        availableAddOns: [
          AddOn(id: 'extra_cheese', name: 'Extra Cheese', description: 'More mozzarella', price: 2.00),
        ],
      ),
      MenuItem(
        id: 'pizza_2',
        name: 'Pepperoni Pizza',
        description: 'Spicy pepperoni slices on top of melted mozzarella.',
        price: 14.99,
        categoryId: 'pizza',
        categoryName: 'Pizza',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
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
        price: 2.50,
        categoryId: 'drinks',
        categoryName: 'Drinks',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
        preparationTime: 2,
      ),
      MenuItem(
        id: 'drink_2',
        name: 'Orange Juice',
        description: 'Freshly squeezed orange juice.',
        price: 3.99,
        categoryId: 'drinks',
        categoryName: 'Drinks',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
        preparationTime: 5,
      ),

      // Desserts
      MenuItem(
        id: 'dessert_1',
        name: 'Chocolate Cake',
        description: 'Rich chocolate layer cake with ganache frosting.',
        price: 6.50,
        categoryId: 'desserts',
        categoryName: 'Desserts',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
        preparationTime: 0,
      ),
      MenuItem(
        id: 'dessert_2',
        name: 'Ice Cream Sundae',
        description: 'Vanilla ice cream with chocolate syrup and a cherry.',
        price: 5.99,
        categoryId: 'desserts',
        categoryName: 'Desserts',
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.now(),
        preparationTime: 5,
      ),
    ];
  }

  static List<AddOn> getGlobalAddOns(BuildContext context) {
    return [
      AddOn(
        id: '1be8444f-c6c5-4afd-bcd2-8ec80cc956d0',
        name: 'شرايح الشيدر',
        description: 'Cheddar cheese slices',
        price: 15.00,
        imageUrl: 'assets/img.jpg',
        createdAt: DateTime.parse('2026-01-05 20:42:38.185104+00'),
      ),
      const AddOn(
        id: 'addon_extra_sauce',
        name: 'Extra Sauce',
        description: 'Signature house sauce',
        price: 5.00,
        imageUrl: 'assets/img.jpg',
      ),
      const AddOn(
        id: 'addon_jalapenos',
        name: 'Jalapeños',
        description: 'Spicy jalapeño slices',
        price: 8.00,
        imageUrl: 'assets/img.jpg',
      ),
      const AddOn(
        id: 'addon_onions',
        name: 'Grilled Onions',
        description: 'Sweet caramelized onions',
        price: 7.00,
        imageUrl: 'assets/img.jpg',
      ),
      const AddOn(
        id: 'addon_mushrooms_global',
        name: 'Mushrooms',
        description: 'Sautéed mushrooms',
        price: 10.00,
        imageUrl: 'assets/img.jpg',
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
