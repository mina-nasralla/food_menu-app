import 'package:flutter/material.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'orders_view.dart';
import 'menu_management_view.dart';
import 'statistics_view.dart';
import 'restaurant_profile_view.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    OrdersView(),
    MenuManagementView(),
    StatisticsView(),
    RestaurantProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 600;
        
        return Scaffold(
          body: Row(
            children: [
              if (isWide)
                _buildNavigationRail(context, isWide),
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: _screens,
                ),
              ),
            ],
          ),
          bottomNavigationBar: !isWide
              ? _buildNavigationBar(context)
              : null,
        );
      },
    );
  }

  Widget _buildNavigationRail(BuildContext context, bool isWide) {
    final l10n = AppLocalizations.of(context)!;
    return NavigationRail(
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      labelType: NavigationRailLabelType.all,
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.receipt_long_outlined),
          selectedIcon: const Icon(Icons.receipt_long),
          label: Text(l10n.ordersNav),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.restaurant_menu_outlined),
          selectedIcon: const Icon(Icons.restaurant_menu),
          label: Text(l10n.menuNav),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.bar_chart_outlined),
          selectedIcon: const Icon(Icons.bar_chart),
          label: Text(l10n.statsNav),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.store_outlined),
          selectedIcon: const Icon(Icons.store),
          label: Text(l10n.profileNav),
        ),
      ],
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.receipt_long_outlined),
          selectedIcon: const Icon(Icons.receipt_long),
          label: l10n.ordersNav,
        ),
        NavigationDestination(
          icon: const Icon(Icons.restaurant_menu_outlined),
          selectedIcon: const Icon(Icons.restaurant_menu),
          label: l10n.menuNav,
        ),
        NavigationDestination(
          icon: const Icon(Icons.bar_chart_outlined),
          selectedIcon: const Icon(Icons.bar_chart),
          label: l10n.statsNav,
        ),
        NavigationDestination(
          icon: const Icon(Icons.store_outlined),
          selectedIcon: const Icon(Icons.store),
          label: l10n.profileNav,
        ),
      ],
    );
  }
}
