// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Food Menu';

  @override
  String get home => 'Home';

  @override
  String get cart => 'Cart';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get quantity => 'Qty';

  @override
  String get spiceLevel => 'Spice level';

  @override
  String get addOns => 'Add-ons';

  @override
  String get specialInstructions => 'Special Instructions';

  @override
  String get specialInstructionsHint =>
      'Add notes for the kitchen (no pickles, sauce on the side, etc.)';

  @override
  String get applyTo => 'Apply to:';

  @override
  String get ofPreposition => 'of';

  @override
  String get total => 'Total';

  @override
  String get item => 'item';

  @override
  String get items => 'items';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(int count, String itemText) {
    return 'Added $count $itemText to cart!';
  }

  @override
  String get preparationTime => 'min';

  @override
  String get searchHint => 'Search for burgers, pizza, drinks...';

  @override
  String get homeNav => 'Home';

  @override
  String get bestSellers => 'Best Sellers';

  @override
  String get seeAll => 'See all';

  @override
  String get categories => 'Categories';

  @override
  String get browseAll => 'Browse all';

  @override
  String get categoryItems => 'Category Items';

  @override
  String get switchToList => 'Switch to List View';

  @override
  String get switchToGrid => 'Switch to Grid View';

  @override
  String get todaysOffers => 'Today\'s offers';

  @override
  String get viewAll => 'View all';

  @override
  String get limitedTime => 'Limited time';

  @override
  String get order => 'Order';

  @override
  String get burgers => 'Burgers';

  @override
  String get pizza => 'Pizza';

  @override
  String get drinks => 'Drinks';

  @override
  String get desserts => 'Desserts';

  @override
  String get offerTitle => 'Up to 40% off on\nBurgers';

  @override
  String get offerSubtitle => 'Order 2 get free fries on\nselected combos.';

  @override
  String get burger1Name => 'Classic Double Burger';

  @override
  String get burger1Desc =>
      'Beef patty, cheddar, lettuce, tomato & house sauce.';

  @override
  String get burger2Name => 'Spicy Chicken Burger';

  @override
  String get burger2Desc =>
      'Crispy chicken, jalapeños, pepper jack cheese & chipotle mayo.';

  @override
  String get burger3Name => 'Veggie Delight';

  @override
  String get burger3Desc =>
      'Plant-based patty, lettuce, tomato, pickles & special sauce.';

  @override
  String get addonCheese => 'Extra cheddar';

  @override
  String get addonCheeseDesc => 'Add one extra slice of cheese';

  @override
  String get addonBacon => 'Bacon';

  @override
  String get addonBaconDesc => 'Smoked crispy bacon strips';

  @override
  String get addonCombo => 'Upgrade to combo';

  @override
  String get addonComboDesc => 'Fries + soft drink';

  @override
  String get addonAvocado => 'Avocado';

  @override
  String get addonAvocadoDesc => 'Fresh sliced avocado';

  @override
  String get addonMushrooms => 'Grilled mushrooms';

  @override
  String get addonMushroomsDesc => 'Sautéed portobello mushrooms';

  @override
  String get checkoutComingSoon => 'Checkout functionality coming soon!';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get addItemsToStart => 'Add items to get started';

  @override
  String get continueShopping => 'Continue Shopping';

  @override
  String get each => 'each';

  @override
  String get summary => 'Summary';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get deliveryFee => 'Delivery fee';

  @override
  String get serviceFee => 'Service fee';

  @override
  String get checkout => 'Checkout';

  @override
  String get editOrder => 'Edit Order';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get selectAddonsHint =>
      'Select how many items should have each add-on';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get deliveryInfo => 'Delivery Information';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneNumberHint => 'Enter your phone number';

  @override
  String get address => 'Delivery Address';

  @override
  String get addressHint => 'Enter your delivery address';

  @override
  String get deliveryNotes => 'Delivery Notes (Optional)';

  @override
  String get deliveryNotesHint => 'Add any special delivery instructions';

  @override
  String get confirmOrder => 'Confirm Order';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get orderConfirmation => 'Order Confirmation';

  @override
  String get confirmAndPay => 'Confirm & Place Order';

  @override
  String get orderSuccess => 'Order Placed Successfully!';

  @override
  String get orderSuccessMessage =>
      'Your order has been placed and will be delivered soon.';

  @override
  String get orderNumber => 'Order Number';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidPhone => 'Please enter a valid phone number';

  @override
  String get reviewOrder => 'Review Your Order';

  @override
  String get customerInfo => 'Customer Information';

  @override
  String get cancel => 'Cancel';

  @override
  String itemsCount(int count) {
    return '$count items';
  }
}
