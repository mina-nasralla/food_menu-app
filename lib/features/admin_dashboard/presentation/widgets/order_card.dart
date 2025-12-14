import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';
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
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(theme),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(item),
              )).toList(),
            ),
            const SizedBox(height: 16),
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
                      ),
                    ),
                    Text(
                      timeago.format(order.timestamp),
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
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

  Widget _buildStatusChip(ThemeData theme) {
    Color color;
    String label;
    switch (order.status) {
      case OrderStatus.newOrder:
        color = Colors.blue;
        label = 'New';
        break;
      case OrderStatus.inProgress:
        color = Colors.orange;
        label = 'In Progress';
        break;
      case OrderStatus.done:
        color = Colors.green;
        label = 'Done';
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
    if (order.status == OrderStatus.newOrder) {
      return OutlinedButton(
        onPressed: onViewDetails,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: const Text('View Details'),
      );
    } else if (order.status == OrderStatus.inProgress) {
      return ElevatedButton(
        onPressed: () => onStatusChange(OrderStatus.done),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: const Text('Complete'),
      );
    } else {
      return const SizedBox.shrink(); // No action for done orders
    }
  }
}
