import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_constants.dart';
import '../../../features/restaurant_menu/presentation/views/restaurant_menu_view.dart';
import '../../../features/cart/presentation/views/cart_view.dart';
import '../../../features/cart/presentation/views/checkout_view.dart';
import '../../../features/cart/presentation/views/order_success_view.dart';
import '../../../features/restaurant_menu/presentation/views/item_details_view.dart';
import '../../../features/restaurant_menu/data/models/menu_item_model.dart';
import '../../../features/restaurant_menu/presentation/views/all_addons_view.dart';


/// App router configuration using GoRouter
/// 
/// Handles navigation and deep linking for web and mobile platforms
class AppRouter {
  // Prevent instantiation
  AppRouter._();

  /// GoRouter instance
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteConstants.restaurantMenuPath,
    routes: [
      /*GoRoute(
        path: RouteConstants.homePath,
        name: RouteConstants.homeName,
        builder: (context, state) => const HomeView(),
      ),*/
      GoRoute(
        path: RouteConstants.restaurantMenuPath,
        name: RouteConstants.restaurantMenuName,
        builder: (context, state) => const RestaurantMenuView(),
      ),
      
      GoRoute(
        path: RouteConstants.cartPath,
        name: RouteConstants.cartName,
        builder: (context, state) => const CartView(),
      ),
      
      GoRoute(
        path: RouteConstants.itemDetailsPath,
        name: RouteConstants.itemDetailsName,
        builder: (context, state) {
          final menuItem = state.extra as MenuItem;
          return ItemDetailsView(menuItem: menuItem);
        },
      ),
      
      GoRoute(
        path: RouteConstants.checkoutPath,
        name: RouteConstants.checkoutName,
        builder: (context, state) => const CheckoutView(),
      ),
      
      GoRoute(
        path: RouteConstants.orderSuccessPath,
        name: RouteConstants.orderSuccessName,
        builder: (context, state) => const OrderSuccessView(),
      ),
      
      GoRoute(
        path: RouteConstants.allAddonsPath,
        name: RouteConstants.allAddonsName,
        builder: (context, state) => const AllAddonsView(),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => _ErrorPage(error: state.error.toString()),
  );
}

/// Error page for navigation errors
class _ErrorPage extends StatelessWidget {
  final String error;
  
  const _ErrorPage({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RouteConstants.restaurantMenuPath),
              child: const Text('Go to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}

