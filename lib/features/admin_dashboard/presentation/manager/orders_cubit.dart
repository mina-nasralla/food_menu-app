import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/order_model.dart';

// State
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;
  
  OrdersLoaded(this.orders);
}

// Cubit
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  List<OrderModel> _allOrders = [];

  void loadOrders() {
    // Dummy Data
    _allOrders = [
      OrderModel(
        id: '1001',
        items: ['2x Burger', '1x Fries', '1x Cola'],
        total: 24.50,
        status: OrderStatus.newOrder,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      OrderModel(
        id: '1002',
        items: ['1x Pizza', '2x Soda'],
        total: 18.00,
        status: OrderStatus.newOrder,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      OrderModel(
        id: '1003',
        items: ['3x Tacos', '1x Water'],
        total: 15.75,
        status: OrderStatus.inProgress,
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      ),
       OrderModel(
        id: '1004',
        items: ['1x Salad', '1x Soup'],
        total: 12.00,
        status: OrderStatus.done,
        timestamp: DateTime.now().subtract(const Duration(minutes: 60)),
      ),
    ];
    emit(OrdersLoaded(List.from(_allOrders)));
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _allOrders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _allOrders[index] = _allOrders[index].copyWith(status: newStatus);
      emit(OrdersLoaded(List.from(_allOrders)));
    }
  }
}
