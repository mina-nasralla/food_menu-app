import 'package:equatable/equatable.dart';

class OfferModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String? imageUrl;
  final bool isActive;
  final String linkTo;

  const OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imageUrl,
    this.isActive = true,
    this.linkTo = 'Category',
  });

  @override
  List<Object?> get props => [id, title, description, price, imageUrl, isActive, linkTo];
  
  OfferModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isActive,
    String? linkTo,
  }) {
    return OfferModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      linkTo: linkTo ?? this.linkTo,
    );
  }
}
