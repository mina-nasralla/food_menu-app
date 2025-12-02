import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_constants.dart';
import '../../../features/home/presentation/views/home_view.dart';
import '../../../features/cart/presentation/views/cart_view.dart';

/// App router configuration using GoRouter
/// 
/// Handles navigation and deep linking for web and mobile platforms
class AppRouter {
  // Prevent instantiation
  AppRouter._();

  /// GoRouter instance
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteConstants.homePath,
    routes: [
      GoRoute(
        path: RouteConstants.homePath,
        name: RouteConstants.homeName,
        builder: (context, state) => const HomeView(),
      ),
      
      GoRoute(
        path: RouteConstants.cartPath,
        name: RouteConstants.cartName,
        builder: (context, state) => const CartView(),
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
              onPressed: () => context.go(RouteConstants.homePath),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

