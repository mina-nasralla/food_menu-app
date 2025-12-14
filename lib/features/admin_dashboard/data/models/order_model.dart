enum OrderStatus { newOrder, inProgress, done }

class OrderModel {
  final String id;
  final List<String> items;
  final double total;
  final OrderStatus status;
  final DateTime timestamp;

  const OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.timestamp,
  });

  OrderModel copyWith({
    String? id,
    List<String>? items,
    double? total,
    OrderStatus? status,
    DateTime? timestamp,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
