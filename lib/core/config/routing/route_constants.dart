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

  // ============================================
  // Cart Route
  // ============================================
  
  /// Cart route path
  static const String cartPath = '/cart';
  
  /// Cart route name
  static const String cartName = 'cart';

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
