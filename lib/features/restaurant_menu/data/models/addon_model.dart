import 'package:equatable/equatable.dart';

/// Model representing an add-on option for a menu item
class AddOn extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity; // How many times this add-on is applied
  final bool isAvailable;
  final String? imageUrl;
  final DateTime? createdAt;

  const AddOn({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 1,
    this.isAvailable = true,
    this.imageUrl,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, description, price, quantity, isAvailable, imageUrl, createdAt];

  factory AddOn.fromJson(Map<String, dynamic> json) {
    return AddOn(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'],
      isAvailable: json['is_available'] ?? true,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  AddOn copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    bool? isAvailable,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return AddOn(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isAvailable: isAvailable ?? this.isAvailable,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
