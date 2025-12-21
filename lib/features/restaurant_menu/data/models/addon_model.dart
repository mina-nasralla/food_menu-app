import 'package:equatable/equatable.dart';

/// Model representing an add-on option for a menu item
class AddOn extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity; // How many times this add-on is applied
  final bool isAvailable;

  const AddOn({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 1,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [id, name, description, price, quantity, isAvailable];

  AddOn copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    bool? isAvailable,
  }) {
    return AddOn(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
