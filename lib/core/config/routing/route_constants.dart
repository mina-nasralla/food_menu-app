/// Route path and name constants for navigation
/// 
/// Centralized location for all route definitions to ensure type-safety
/// and prevent typos in route navigation
class RouteConstants {
  // Prevent instantiation
  RouteConstants._();

  // ============================================
  // Route Paths
  // ============================================
  
  /// Root/Home route path
  static const String homePath = '/';
  
  /// Home route name
  static const String homeName = 'home';

  /// Restaurant Menu route path
  static const String restaurantMenuPath = '/restaurant-menu';
  
  /// Restaurant Menu route name
  static const String restaurantMenuName = 'restaurant-menu';

  // ============================================
  // Cart Route
  // ============================================
  
  /// Cart route path
  static const String cartPath = '/cart';
  
  /// Cart route name
  static const String cartName = 'cart';

  // ============================================
  // Item Details Route
  // ============================================
  
  /// Item details route path
  static const String itemDetailsPath = '/item-details';
  
  /// Item details route name
  static const String itemDetailsName = 'item-details';

  // ============================================
  // Checkout Route
  // ============================================
  
  /// Checkout route path
  static const String checkoutPath = '/checkout';
  
  /// Checkout route name
  static const String checkoutName = 'checkout';

  // ============================================
  // Order Success Route
  // ============================================
  
  /// Order success route path
  static const String orderSuccessPath = '/order-success';
  
  /// Order success route name
  static const String orderSuccessName = 'order-success';

  // ============================================
  // Addons Route
  // ============================================
  
  /// All addons route path
  static const String allAddonsPath = '/all-addons';
  
  /// All addons route name
  static const String allAddonsName = 'all-addons';

  // ============================================
  // Example Feature Routes (Add your routes here)
  // ============================================
  
  // Example:
  // static const String menuPath = '/menu';
  // static const String menuName = 'menu';
  // 
  // static const String menuDetailPath = '/menu/:id';
  // static const String menuDetailName = 'menu-detail';
}
