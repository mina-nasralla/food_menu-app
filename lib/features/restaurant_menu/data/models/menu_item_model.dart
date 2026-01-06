import 'package:equatable/equatable.dart';

import 'addon_model.dart';

/// Spice level options
enum SpiceLevel {
  none('No spice'),
  mild('Mild'),
  medium('Medium'),
  hot('Hot');

  final String label;

  const SpiceLevel(this.label);
}

class MenuItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final String? imageUrl;
  final String? categoryName;
  final String categoryId;
  final bool isAvailable;
  final List<AddOn> availableAddOns;
  final bool hasSpiceLevelOption;
  final int preparationTime;
  final DateTime createdAt;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discount = 0.0,
    this.imageUrl,
    this.categoryName,
    required this.categoryId,
    this.isAvailable = true,
    this.availableAddOns = const [],
    this.hasSpiceLevelOption = false,
    this.preparationTime = 20,
    required this.createdAt,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'],
      categoryName: json['category'],
      categoryId: json['category_id'] ?? '',
      isAvailable: json['is_available'] ?? true,
      availableAddOns: const [],
      // Will be handled in a separate integration if needed
      hasSpiceLevelOption: false,
      preparationTime: 20,
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  double get finalPrice => price - discount;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    discount,
    imageUrl,
    categoryName,
    categoryId,
    isAvailable,
    availableAddOns,
    hasSpiceLevelOption,
    preparationTime,
    createdAt,
  ];

  MenuItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discount,
    String? imageUrl,
    String? categoryName,
    String? categoryId,
    bool? isAvailable,
    List<AddOn>? availableAddOns,
    bool? hasSpiceLevelOption,
    int? preparationTime,
    DateTime? createdAt,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryName: categoryName ?? this.categoryName,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      availableAddOns: availableAddOns ?? this.availableAddOns,
      hasSpiceLevelOption: hasSpiceLevelOption ?? this.hasSpiceLevelOption,
      preparationTime: preparationTime ?? this.preparationTime,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
