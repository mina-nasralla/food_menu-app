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
  String get recommendedAddons => 'Recommended Add-ons';

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
  String get searchHint => 'Search';

  @override
  String get searchPlaceholder => 'Search...';

  @override
  String get noAddonsFound => 'No addons found';

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

  @override
  String get ordersNav => 'Orders';

  @override
  String get menuNav => 'Menu';

  @override
  String get statsNav => 'Stats';

  @override
  String get profileNav => 'Profile';

  @override
  String get pending => 'Pending';

  @override
  String get accepted => 'Accepted';

  @override
  String get preparing => 'Preparing';

  @override
  String get ready => 'Ready';

  @override
  String get completed => 'Completed';

  @override
  String get acceptOrder => 'Accept Order';

  @override
  String get reject => 'Reject';

  @override
  String get markAsReady => 'Mark as Ready';

  @override
  String get complete => 'Complete';

  @override
  String get noOrders => 'No orders yet';

  @override
  String get itemsTab => 'Items';

  @override
  String get addonsTab => 'Add-ons';

  @override
  String get offersTab => 'Offers';

  @override
  String get createBanner => 'Create Banner';

  @override
  String get editOffer => 'Edit Offer';

  @override
  String get headline => 'Headline';

  @override
  String get subtitleDescription => 'Subtitle/Description';

  @override
  String get priceIfApplicable => 'Price (if applicable)';

  @override
  String get imageUrl => 'Image URL';

  @override
  String get selectedItems => 'Selected Items';

  @override
  String get selectedAddons => 'Selected Addons';

  @override
  String get estimatedValue => 'Estimated Value';

  @override
  String get useEstimated => 'Use Estimated';

  @override
  String get finalPrice => 'Final Price';

  @override
  String get pricing => 'Pricing';

  @override
  String get header => 'Header';

  @override
  String get visuals => 'Visuals';

  @override
  String get includedItems => 'Included Items';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get create => 'Create';

  @override
  String get loading => 'Loading...';

  @override
  String get addItem => 'Add Item';

  @override
  String get itemName => 'Item Name';

  @override
  String get description => 'Description';

  @override
  String get price => 'Price';

  @override
  String get category => 'Category';

  @override
  String get availableAddons => 'Available Add-ons';

  @override
  String get addAddon => 'Add Add-on';

  @override
  String get addonName => 'Add-on Name';

  @override
  String get totalOrders => 'Total Orders';

  @override
  String get revenue => 'Revenue';

  @override
  String get activeOffers => 'Active Offers';

  @override
  String get menuItems => 'Menu Items';

  @override
  String get myRestaurant => 'My Restaurant';

  @override
  String get location => 'Location';

  @override
  String get phone => 'Phone';

  @override
  String get website => 'Website';

  @override
  String get facebook => 'Facebook';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get totalVisitors => 'Total Visitors';

  @override
  String get logout => 'Logout';

  @override
  String get chiefLogin => 'Chief Login';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get loginToManage => 'Login to manage your restaurant';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get login => 'Login';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get register => 'Register';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get useEst => 'Use Est';

  @override
  String get acceptingOrders => 'Accepting Orders';

  @override
  String get notAcceptingOrders => 'Not Accepting Orders';

  @override
  String get ordersOn => 'Orders On';

  @override
  String get ordersOff => 'Orders Off';

  @override
  String get workingHours => 'Working Hours';

  @override
  String get day => 'Day';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get operationalStatus => 'Operational Status';

  @override
  String get open => 'Open';

  @override
  String get closed => 'Closed';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get statistics => 'Statistics';

  @override
  String get totalSales => 'Total Sales';

  @override
  String get visitors => 'Visitors';

  @override
  String get avgOrder => 'Avg. Order';

  @override
  String get yourSubscription => 'Your Subscription';

  @override
  String get basicPlan => 'Basic Plan';

  @override
  String get activeStatus => 'Active';

  @override
  String expiresOn(Object date) {
    return 'Expires on $date';
  }

  @override
  String get availablePlans => 'Available Plans';

  @override
  String get proPlan => 'Pro Plan';

  @override
  String get enterprisePlan => 'Enterprise Plan';

  @override
  String get unlimitedItems => 'Unlimited items, Priority Support';

  @override
  String get customPlanDesc => 'Dedicated Manager, Scaling';

  @override
  String get newOrder => 'New';

  @override
  String get inProgress => 'In Progress';

  @override
  String get doneStatus => 'Done';

  @override
  String get details => 'Details';

  @override
  String orderDetails(Object id) {
    return 'Order #$id Details';
  }

  @override
  String get itemsLabel => 'Items:';

  @override
  String get orderAccepted => 'Order Accepted';

  @override
  String get viewDetails => 'View Details';

  @override
  String get noOrdersFound => 'No orders found';

  @override
  String get editItem => 'Edit Item';

  @override
  String get addNewItem => 'Add New Item';

  @override
  String get selectAddons => 'Select Addons:';

  @override
  String get editAddon => 'Edit Addon';

  @override
  String get addNewAddon => 'Add New Addon';

  @override
  String get menuManagement => 'Menu Management';

  @override
  String get acceptingOrdersDesc => 'Currently accepting and serving orders.';

  @override
  String get notAcceptingOrdersDesc =>
      'Shop is currently closed to the public.';

  @override
  String get updateProfile => 'Update Profile';

  @override
  String get cuisineType => 'Cuisine Type';

  @override
  String get facebookUrl => 'Facebook URL';

  @override
  String get whatsappNumber => 'WhatsApp Number';

  @override
  String get update => 'Update';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get updateLogo => 'Update Logo';

  @override
  String get updateBanner => 'Update Banner';

  @override
  String get editWorkingHours => 'Edit Working Hours';

  @override
  String get openingTime => 'Opening Time';

  @override
  String get closingTime => 'Closing Time';

  @override
  String get isClosed => 'Is Closed';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get directions => 'Directions';

  @override
  String get call => 'Call';

  @override
  String get deliveryTimeValue => '20-30 min';

  @override
  String get deliveryLabel => 'Delivery';

  @override
  String get addressLabel => 'Address';

  @override
  String get error => 'Error';

  @override
  String get selectOnMap => 'Select on Map';

  @override
  String get chooseLocationVisually => 'Choose location visually';

  @override
  String get typeAddress => 'Type Address';

  @override
  String get enterAddressManually => 'Enter address manually';

  @override
  String get confirm => 'Confirm';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Enter your name';
}
