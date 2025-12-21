import 'package:equatable/equatable.dart';

class OfferModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String? imageUrl;
  final bool isActive;
  final List<String> linkedItemIds;
  final List<String> selectedAddonIds;

  const OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imageUrl,
    this.isActive = true,
    this.linkedItemIds = const [],
    this.selectedAddonIds = const [],
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    imageUrl,
    isActive,
    linkedItemIds,
    selectedAddonIds,
  ];

  OfferModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isActive,
    List<String>? linkedItemIds,
    List<String>? selectedAddonIds,
  }) {
    return OfferModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      linkedItemIds: linkedItemIds ?? this.linkedItemIds,
      selectedAddonIds: selectedAddonIds ?? this.selectedAddonIds,
    );
  }
}
