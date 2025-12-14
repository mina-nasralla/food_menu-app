import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/order_model.dart';
import '../manager/orders_cubit.dart';
import '../widgets/order_card.dart';
import '../widgets/orders_filter_bar.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..loadOrders(),
      child: const _OrdersViewBody(),
    );
  }
}

class _OrdersViewBody extends StatefulWidget {
  const _OrdersViewBody();

  @override
  State<_OrdersViewBody> createState() => _OrdersViewBodyState();
}

class _OrdersViewBodyState extends State<_OrdersViewBody> {
  OrderStatus _selectedFilter = OrderStatus.newOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          OrdersFilterBar(
            selectedFilter: _selectedFilter,
            onFilterSelected: (status) {
              setState(() {
                _selectedFilter = status;
              });
            },
          ),
          
          Expanded(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoaded) {
                  final filteredOrders = state.orders
                      .where((order) => order.status == _selectedFilter)
                      .toList();

                  if (filteredOrders.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return OrderCard(
                        order: order,
                        onStatusChange: (newStatus) {
                          context.read<OrdersCubit>().updateOrderStatus(order.id, newStatus);
                        },
                        onViewDetails: () => _showOrderDetailsDialog(context, order),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetailsDialog(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order #${order.id} Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Items:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Text('• $item')).toList(),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<OrdersCubit>().updateOrderStatus(order.id, OrderStatus.inProgress);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order Accepted')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Accept Order'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'No orders found',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
