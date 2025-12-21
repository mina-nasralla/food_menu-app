import 'package:flutter/material.dart';
import 'package:food_menu_app/features/admin_dashboard/data/models/order_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;


class OrderCard extends StatelessWidget {
  final OrderModel order;
  final Function(OrderStatus) onStatusChange;
  final VoidCallback? onViewDetails;

  const OrderCard({
    super.key,
    required this.order,
    required this.onStatusChange,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero, // Spacing handled by GridView
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.orderDetails(order.id),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(context, theme),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: order.items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $item',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${order.total.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      timeago.format(
                        order.timestamp,
                        locale: Localizations.localeOf(context).languageCode,
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                _buildActionButtons(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    Color color;
    String label;
    switch (order.status) {
      case OrderStatus.newOrder:
        color = Colors.blue;
        label = l10n.newOrder;
        break;
      case OrderStatus.inProgress:
        color = Colors.orange;
        label = l10n.inProgress;
        break;
      case OrderStatus.done:
        color = Colors.green;
        label = l10n.doneStatus;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (order.status == OrderStatus.newOrder) {
      return OutlinedButton(
        onPressed: onViewDetails,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Text(l10n.viewDetails),
      );
    } else if (order.status == OrderStatus.inProgress) {
      return ElevatedButton(
        onPressed: () => onStatusChange(OrderStatus.done),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Text(l10n.complete),
      );
    } else {
      return const SizedBox.shrink(); // No action for done orders
    }
  }
}
