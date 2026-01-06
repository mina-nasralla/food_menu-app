import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Food Menu'**
  String get appTitle;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Cart page title
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// Language label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Arabic language
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// Quantity label
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get quantity;

  /// Spice level section title
  ///
  /// In en, this message translates to:
  /// **'Spice level'**
  String get spiceLevel;

  /// Add-ons section title
  ///
  /// In en, this message translates to:
  /// **'Add-ons'**
  String get addOns;

  /// Recommended add-ons section title
  ///
  /// In en, this message translates to:
  /// **'Recommended Add-ons'**
  String get recommendedAddons;

  /// Special instructions section title
  ///
  /// In en, this message translates to:
  /// **'Special Instructions'**
  String get specialInstructions;

  /// Placeholder text for special instructions
  ///
  /// In en, this message translates to:
  /// **'Add notes for the kitchen (no pickles, sauce on the side, etc.)'**
  String get specialInstructionsHint;

  /// Label for add-on quantity selector
  ///
  /// In en, this message translates to:
  /// **'Apply to:'**
  String get applyTo;

  /// Preposition for quantity (X of Y)
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get ofPreposition;

  /// Total price label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Single item
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item;

  /// Multiple items
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// Add to cart button text
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// Success message when item added to cart
  ///
  /// In en, this message translates to:
  /// **'Added {count} {itemText} to cart!'**
  String addedToCart(int count, String itemText);

  /// Minutes abbreviation for preparation time
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get preparationTime;

  /// Hint text for search bar
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchHint;

  /// Generic search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchPlaceholder;

  /// Message when no addons match search
  ///
  /// In en, this message translates to:
  /// **'No addons found'**
  String get noAddonsFound;

  /// Home navigation label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeNav;

  /// Best sellers section title
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get bestSellers;

  /// See all button text
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// Categories section title
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Browse all button text
  ///
  /// In en, this message translates to:
  /// **'Browse all'**
  String get browseAll;

  /// Category items section title
  ///
  /// In en, this message translates to:
  /// **'Category Items'**
  String get categoryItems;

  /// Tooltip for switching to list view
  ///
  /// In en, this message translates to:
  /// **'Switch to List View'**
  String get switchToList;

  /// Tooltip for switching to grid view
  ///
  /// In en, this message translates to:
  /// **'Switch to Grid View'**
  String get switchToGrid;

  /// Offers section title
  ///
  /// In en, this message translates to:
  /// **'Today\'s offers'**
  String get todaysOffers;

  /// View all button text
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// Limited time badge text
  ///
  /// In en, this message translates to:
  /// **'Limited time'**
  String get limitedTime;

  /// Order button text
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// Burgers category
  ///
  /// In en, this message translates to:
  /// **'Burgers'**
  String get burgers;

  /// Pizza category
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get pizza;

  /// Drinks category
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// Desserts category
  ///
  /// In en, this message translates to:
  /// **'Desserts'**
  String get desserts;

  /// Mock offer title
  ///
  /// In en, this message translates to:
  /// **'Up to 40% off on\nBurgers'**
  String get offerTitle;

  /// Mock offer subtitle
  ///
  /// In en, this message translates to:
  /// **'Order 2 get free fries on\nselected combos.'**
  String get offerSubtitle;

  /// Burger 1 Name
  ///
  /// In en, this message translates to:
  /// **'Classic Double Burger'**
  String get burger1Name;

  /// Burger 1 Description
  ///
  /// In en, this message translates to:
  /// **'Beef patty, cheddar, lettuce, tomato & house sauce.'**
  String get burger1Desc;

  /// Burger 2 Name
  ///
  /// In en, this message translates to:
  /// **'Spicy Chicken Burger'**
  String get burger2Name;

  /// Burger 2 Description
  ///
  /// In en, this message translates to:
  /// **'Crispy chicken, jalapeños, pepper jack cheese & chipotle mayo.'**
  String get burger2Desc;

  /// Burger 3 Name
  ///
  /// In en, this message translates to:
  /// **'Veggie Delight'**
  String get burger3Name;

  /// Burger 3 Description
  ///
  /// In en, this message translates to:
  /// **'Plant-based patty, lettuce, tomato, pickles & special sauce.'**
  String get burger3Desc;

  /// Addon Cheese Name
  ///
  /// In en, this message translates to:
  /// **'Extra cheddar'**
  String get addonCheese;

  /// Addon Cheese Description
  ///
  /// In en, this message translates to:
  /// **'Add one extra slice of cheese'**
  String get addonCheeseDesc;

  /// Addon Bacon Name
  ///
  /// In en, this message translates to:
  /// **'Bacon'**
  String get addonBacon;

  /// Addon Bacon Description
  ///
  /// In en, this message translates to:
  /// **'Smoked crispy bacon strips'**
  String get addonBaconDesc;

  /// Addon Combo Name
  ///
  /// In en, this message translates to:
  /// **'Upgrade to combo'**
  String get addonCombo;

  /// Addon Combo Description
  ///
  /// In en, this message translates to:
  /// **'Fries + soft drink'**
  String get addonComboDesc;

  /// Addon Avocado Name
  ///
  /// In en, this message translates to:
  /// **'Avocado'**
  String get addonAvocado;

  /// Addon Avocado Description
  ///
  /// In en, this message translates to:
  /// **'Fresh sliced avocado'**
  String get addonAvocadoDesc;

  /// Addon Mushrooms Name
  ///
  /// In en, this message translates to:
  /// **'Grilled mushrooms'**
  String get addonMushrooms;

  /// Addon Mushrooms Description
  ///
  /// In en, this message translates to:
  /// **'Sautéed portobello mushrooms'**
  String get addonMushroomsDesc;

  /// Checkout coming soon message
  ///
  /// In en, this message translates to:
  /// **'Checkout functionality coming soon!'**
  String get checkoutComingSoon;

  /// Empty cart message
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// Add items hint
  ///
  /// In en, this message translates to:
  /// **'Add items to get started'**
  String get addItemsToStart;

  /// Continue shopping button text
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

  /// Per item label
  ///
  /// In en, this message translates to:
  /// **'each'**
  String get each;

  /// Cart summary title
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// Subtotal label
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Delivery fee label
  ///
  /// In en, this message translates to:
  /// **'Delivery fee'**
  String get deliveryFee;

  /// Service fee label
  ///
  /// In en, this message translates to:
  /// **'Service fee'**
  String get serviceFee;

  /// Checkout button text
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// Edit order dialog title
  ///
  /// In en, this message translates to:
  /// **'Edit Order'**
  String get editOrder;

  /// Quantity label full text
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// Hint for addon selection
  ///
  /// In en, this message translates to:
  /// **'Select how many items should have each add-on'**
  String get selectAddonsHint;

  /// Checkout page title
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// Delivery information section title
  ///
  /// In en, this message translates to:
  /// **'Delivery Information'**
  String get deliveryInfo;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Full name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// Phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Phone number field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberHint;

  /// Address field label
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get address;

  /// Address field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your delivery address'**
  String get addressHint;

  /// Delivery notes field label
  ///
  /// In en, this message translates to:
  /// **'Delivery Notes (Optional)'**
  String get deliveryNotes;

  /// Delivery notes field hint
  ///
  /// In en, this message translates to:
  /// **'Add any special delivery instructions'**
  String get deliveryNotesHint;

  /// Confirm order button text
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get confirmOrder;

  /// Order summary section title
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// Order confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Order Confirmation'**
  String get orderConfirmation;

  /// Final confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm & Place Order'**
  String get confirmAndPay;

  /// Order success title
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully!'**
  String get orderSuccess;

  /// Order success message
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed and will be delivered soon.'**
  String get orderSuccessMessage;

  /// Order number label
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// Back to home button text
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Required field validation message
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Invalid phone validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhone;

  /// Review order section title
  ///
  /// In en, this message translates to:
  /// **'Review Your Order'**
  String get reviewOrder;

  /// Customer info section title
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInfo;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Items count label
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(int count);

  /// Orders navigation label
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersNav;

  /// Menu navigation label
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuNav;

  /// Statistics navigation label
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statsNav;

  /// Profile navigation label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileNav;

  /// Pending order status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Accepted order status
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// Preparing order status
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get preparing;

  /// Ready order status
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get ready;

  /// Completed order status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Accept order button
  ///
  /// In en, this message translates to:
  /// **'Accept Order'**
  String get acceptOrder;

  /// Reject button
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// Mark as ready button
  ///
  /// In en, this message translates to:
  /// **'Mark as Ready'**
  String get markAsReady;

  /// Complete button
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No orders message
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrders;

  /// Items tab label
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get itemsTab;

  /// Add-ons tab label
  ///
  /// In en, this message translates to:
  /// **'Add-ons'**
  String get addonsTab;

  /// Offers tab label
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offersTab;

  /// Create banner button
  ///
  /// In en, this message translates to:
  /// **'Create Banner'**
  String get createBanner;

  /// Edit offer dialog title
  ///
  /// In en, this message translates to:
  /// **'Edit Offer'**
  String get editOffer;

  /// Headline field label
  ///
  /// In en, this message translates to:
  /// **'Headline'**
  String get headline;

  /// Subtitle field label
  ///
  /// In en, this message translates to:
  /// **'Subtitle/Description'**
  String get subtitleDescription;

  /// Price field label
  ///
  /// In en, this message translates to:
  /// **'Price (if applicable)'**
  String get priceIfApplicable;

  /// Image URL field label
  ///
  /// In en, this message translates to:
  /// **'Image URL'**
  String get imageUrl;

  /// Selected items label
  ///
  /// In en, this message translates to:
  /// **'Selected Items'**
  String get selectedItems;

  /// Selected addons label
  ///
  /// In en, this message translates to:
  /// **'Selected Addons'**
  String get selectedAddons;

  /// Estimated value label
  ///
  /// In en, this message translates to:
  /// **'Estimated Value'**
  String get estimatedValue;

  /// Use estimated button
  ///
  /// In en, this message translates to:
  /// **'Use Estimated'**
  String get useEstimated;

  /// Final price label
  ///
  /// In en, this message translates to:
  /// **'Final Price'**
  String get finalPrice;

  /// Pricing section label
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// Header section label
  ///
  /// In en, this message translates to:
  /// **'Header'**
  String get header;

  /// Visuals section label
  ///
  /// In en, this message translates to:
  /// **'Visuals'**
  String get visuals;

  /// Included items section label
  ///
  /// In en, this message translates to:
  /// **'Included Items'**
  String get includedItems;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Inactive status
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Create button
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Add item button
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// Item name field
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// Description field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Price field
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// Category field
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Available addons label
  ///
  /// In en, this message translates to:
  /// **'Available Add-ons'**
  String get availableAddons;

  /// Add addon button
  ///
  /// In en, this message translates to:
  /// **'Add Add-on'**
  String get addAddon;

  /// Addon name field
  ///
  /// In en, this message translates to:
  /// **'Add-on Name'**
  String get addonName;

  /// Total orders stat
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// Revenue stat
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// Active offers stat
  ///
  /// In en, this message translates to:
  /// **'Active Offers'**
  String get activeOffers;

  /// Menu items stat
  ///
  /// In en, this message translates to:
  /// **'Menu Items'**
  String get menuItems;

  /// My restaurant title
  ///
  /// In en, this message translates to:
  /// **'My Restaurant'**
  String get myRestaurant;

  /// Location label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Website label
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// Facebook label
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// WhatsApp label
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// Total visitors label
  ///
  /// In en, this message translates to:
  /// **'Total Visitors'**
  String get totalVisitors;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Chief login title
  ///
  /// In en, this message translates to:
  /// **'Chief Login'**
  String get chiefLogin;

  /// Welcome back message
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// Login subtitle
  ///
  /// In en, this message translates to:
  /// **'Login to manage your restaurant'**
  String get loginToManage;

  /// Email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Don't have account text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Register button
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Email validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Email validation
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// Password validation
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// Use estimated short label
  ///
  /// In en, this message translates to:
  /// **'Use Est'**
  String get useEst;

  /// Status when restaurant is accepting orders
  ///
  /// In en, this message translates to:
  /// **'Accepting Orders'**
  String get acceptingOrders;

  /// Status when restaurant is not accepting orders
  ///
  /// In en, this message translates to:
  /// **'Not Accepting Orders'**
  String get notAcceptingOrders;

  /// Toggle label for orders on
  ///
  /// In en, this message translates to:
  /// **'Orders On'**
  String get ordersOn;

  /// Toggle label for orders off
  ///
  /// In en, this message translates to:
  /// **'Orders Off'**
  String get ordersOff;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @operationalStatus.
  ///
  /// In en, this message translates to:
  /// **'Operational Status'**
  String get operationalStatus;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @totalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get totalSales;

  /// No description provided for @visitors.
  ///
  /// In en, this message translates to:
  /// **'Visitors'**
  String get visitors;

  /// No description provided for @avgOrder.
  ///
  /// In en, this message translates to:
  /// **'Avg. Order'**
  String get avgOrder;

  /// No description provided for @yourSubscription.
  ///
  /// In en, this message translates to:
  /// **'Your Subscription'**
  String get yourSubscription;

  /// No description provided for @basicPlan.
  ///
  /// In en, this message translates to:
  /// **'Basic Plan'**
  String get basicPlan;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeStatus;

  /// No description provided for @expiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires on {date}'**
  String expiresOn(Object date);

  /// No description provided for @availablePlans.
  ///
  /// In en, this message translates to:
  /// **'Available Plans'**
  String get availablePlans;

  /// No description provided for @proPlan.
  ///
  /// In en, this message translates to:
  /// **'Pro Plan'**
  String get proPlan;

  /// No description provided for @enterprisePlan.
  ///
  /// In en, this message translates to:
  /// **'Enterprise Plan'**
  String get enterprisePlan;

  /// No description provided for @unlimitedItems.
  ///
  /// In en, this message translates to:
  /// **'Unlimited items, Priority Support'**
  String get unlimitedItems;

  /// No description provided for @customPlanDesc.
  ///
  /// In en, this message translates to:
  /// **'Dedicated Manager, Scaling'**
  String get customPlanDesc;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newOrder;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @doneStatus.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneStatus;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order #{id} Details'**
  String orderDetails(Object id);

  /// No description provided for @itemsLabel.
  ///
  /// In en, this message translates to:
  /// **'Items:'**
  String get itemsLabel;

  /// No description provided for @orderAccepted.
  ///
  /// In en, this message translates to:
  /// **'Order Accepted'**
  String get orderAccepted;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @noOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// No description provided for @editItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get editItem;

  /// No description provided for @addNewItem.
  ///
  /// In en, this message translates to:
  /// **'Add New Item'**
  String get addNewItem;

  /// No description provided for @selectAddons.
  ///
  /// In en, this message translates to:
  /// **'Select Addons:'**
  String get selectAddons;

  /// No description provided for @editAddon.
  ///
  /// In en, this message translates to:
  /// **'Edit Addon'**
  String get editAddon;

  /// No description provided for @addNewAddon.
  ///
  /// In en, this message translates to:
  /// **'Add New Addon'**
  String get addNewAddon;

  /// No description provided for @menuManagement.
  ///
  /// In en, this message translates to:
  /// **'Menu Management'**
  String get menuManagement;

  /// No description provided for @acceptingOrdersDesc.
  ///
  /// In en, this message translates to:
  /// **'Currently accepting and serving orders.'**
  String get acceptingOrdersDesc;

  /// No description provided for @notAcceptingOrdersDesc.
  ///
  /// In en, this message translates to:
  /// **'Shop is currently closed to the public.'**
  String get notAcceptingOrdersDesc;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @cuisineType.
  ///
  /// In en, this message translates to:
  /// **'Cuisine Type'**
  String get cuisineType;

  /// No description provided for @facebookUrl.
  ///
  /// In en, this message translates to:
  /// **'Facebook URL'**
  String get facebookUrl;

  /// No description provided for @whatsappNumber.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Number'**
  String get whatsappNumber;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @updateLogo.
  ///
  /// In en, this message translates to:
  /// **'Update Logo'**
  String get updateLogo;

  /// No description provided for @updateBanner.
  ///
  /// In en, this message translates to:
  /// **'Update Banner'**
  String get updateBanner;

  /// No description provided for @editWorkingHours.
  ///
  /// In en, this message translates to:
  /// **'Edit Working Hours'**
  String get editWorkingHours;

  /// No description provided for @openingTime.
  ///
  /// In en, this message translates to:
  /// **'Opening Time'**
  String get openingTime;

  /// No description provided for @closingTime.
  ///
  /// In en, this message translates to:
  /// **'Closing Time'**
  String get closingTime;

  /// No description provided for @isClosed.
  ///
  /// In en, this message translates to:
  /// **'Is Closed'**
  String get isClosed;

  /// Save changes button text
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @deliveryTimeValue.
  ///
  /// In en, this message translates to:
  /// **'20-30 min'**
  String get deliveryTimeValue;

  /// No description provided for @deliveryLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Option to select address on map
  ///
  /// In en, this message translates to:
  /// **'Select on Map'**
  String get selectOnMap;

  /// Subtitle for select on map option
  ///
  /// In en, this message translates to:
  /// **'Choose location visually'**
  String get chooseLocationVisually;

  /// Option to type address manually
  ///
  /// In en, this message translates to:
  /// **'Type Address'**
  String get typeAddress;

  /// Subtitle for type address option
  ///
  /// In en, this message translates to:
  /// **'Enter address manually'**
  String get enterAddressManually;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Customer name label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Customer name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nameHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
