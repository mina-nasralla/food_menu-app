import 'package:flutter/material.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import '../../data/models/order_model.dart';

class OrdersFilterBar extends StatelessWidget {
  final OrderStatus selectedFilter;
  final Function(OrderStatus) onFilterSelected;

  const OrdersFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filters = OrderStatus.values;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(_getLabel(context, filter)),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onFilterSelected(filter);
                }
              },
              backgroundColor: theme.canvasColor,
              selectedColor: theme.colorScheme.primaryContainer,
              labelStyle: TextStyle(
                color: isSelected 
                    ? theme.colorScheme.onPrimaryContainer 
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getLabel(BuildContext context, OrderStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case OrderStatus.newOrder:
        return l10n.newOrder;
      case OrderStatus.inProgress:
        return l10n.inProgress;
      case OrderStatus.done:
        return l10n.doneStatus;
    }
  }
}
