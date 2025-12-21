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

/// Model representing a menu item
class MenuItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double basePrice;
  final String imageUrl;
  final String category; // 'burgers', 'pizza', 'drinks', 'desserts'
  final List<AddOn> availableAddOns;
  final bool hasSpiceLevelOption;
  final int preparationTime; // in minutes
  final bool isAvailable;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.imageUrl,
    required this.category,
    this.availableAddOns = const [],
    this.hasSpiceLevelOption = false,
    this.preparationTime = 20,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        basePrice,
        imageUrl,
        category,
        availableAddOns,
        hasSpiceLevelOption,
        preparationTime,
        isAvailable,
      ];

  MenuItem copyWith({
    String? id,
    String? name,
    String? description,
    double? basePrice,
    String? imageUrl,
    String? category,
    List<AddOn>? availableAddOns,
    bool? hasSpiceLevelOption,
    int? preparationTime,
    bool? isAvailable,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      availableAddOns: availableAddOns ?? this.availableAddOns,
      hasSpiceLevelOption: hasSpiceLevelOption ?? this.hasSpiceLevelOption,
      preparationTime: preparationTime ?? this.preparationTime,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
