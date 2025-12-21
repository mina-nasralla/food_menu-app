import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';


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
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        bool isAccepting = true;
        if (state is OrdersLoaded) {
          isAccepting = state.isAcceptingOrders;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.ordersNav),
            automaticallyImplyLeading: false,
            actions: [
              Row(
                children: [
                  Text(
                    isAccepting
                        ? AppLocalizations.of(context)!.ordersOn
                        : AppLocalizations.of(context)!.ordersOff,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isAccepting ? Colors.green : Colors.red,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isAccepting,
                      onChanged: (value) {
                        context.read<OrdersCubit>().toggleAcceptingOrders();
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              if (!isAccepting)
                Container(
                  width: double.infinity,
                  color: Colors.red.shade100,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.notAcceptingOrders,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
                        return _buildEmptyState(context);
                      }

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1400),
                              child: GridView.builder(
                                padding: const EdgeInsets.all(16),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 500,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  mainAxisExtent: 180, // Adjust based on card height
                                ),
                                itemCount: filteredOrders.length,
                                itemBuilder: (context, index) {
                                  final order = filteredOrders[index];
                                  return OrderCard(
                                    order: order,
                                    onStatusChange: (newStatus) {
                                      context.read<OrdersCubit>().updateOrderStatus(
                                        order.id,
                                        newStatus,
                                      );
                                    },
                                    onViewDetails: () =>
                                        _showOrderDetailsDialog(context, order),
                                  );
                                },
                              ),
                            ),
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
      },
    );
  }

  void _showOrderDetailsDialog(BuildContext context, OrderModel order) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.orderDetails(order.id)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.itemsLabel, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ...order.items.map((item) => Text('• $item')).toList(),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${l10n.total}:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<OrdersCubit>().updateOrderStatus(
                order.id,
                OrderStatus.inProgress,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l10n.orderAccepted)));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.acceptOrder),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Theme.of(context).hintColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noOrdersFound,
            style: TextStyle(fontSize: 16, color: Theme.of(context).hintColor.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
