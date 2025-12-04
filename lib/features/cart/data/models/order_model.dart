import 'package:equatable/equatable.dart';
import '../../../home/data/models/cart_item_model.dart';

/// Enum representing order status
enum OrderStatus {
  pending,
  confirmed,
  preparing,
  outForDelivery,
  delivered,
  cancelled,
}

/// Extension to get display name for order status
extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Model representing a placed order
class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final String phoneNumber;
  final String address;
  final String? deliveryNotes;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;
  final DateTime orderDate;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.items,
    required this.phoneNumber,
    required this.address,
    this.deliveryNotes,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.total,
    required this.orderDate,
    this.status = OrderStatus.pending,
  });

  @override
  List<Object?> get props => [
        id,
        items,
        phoneNumber,
        address,
        deliveryNotes,
        subtotal,
        deliveryFee,
        serviceFee,
        total,
        orderDate,
        status,
      ];

  /// Create a copy with updated values
  Order copyWith({
    String? id,
    List<CartItem>? items,
    String? phoneNumber,
    String? address,
    String? deliveryNotes,
    double? subtotal,
    double? deliveryFee,
    double? serviceFee,
    double? total,
    DateTime? orderDate,
    OrderStatus? status,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      serviceFee: serviceFee ?? this.serviceFee,
      total: total ?? this.total,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
    );
  }

  /// Convert order to JSON (for API calls or storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => {
        'id': item.id,
        'name': item.name,
        'quantity': item.quantity,
        'price': item.pricePerItem,
        'total': item.totalPrice,
        'addons': item.selectedAddOns.map((addon) => {
          'name': addon.name,
          'quantity': addon.quantity,
          'price': addon.price,
        }).toList(),
        'spiceLevel': item.spiceLevel?.toString(),
        'specialInstructions': item.specialInstructions,
      }).toList(),
      'phoneNumber': phoneNumber,
      'address': address,
      'deliveryNotes': deliveryNotes,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'serviceFee': serviceFee,
      'total': total,
      'orderDate': orderDate.toIso8601String(),
      'status': status.toString(),
    };
  }
}
