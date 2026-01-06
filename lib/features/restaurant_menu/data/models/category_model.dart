import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final int itemsCount;
  final DateTime createdAt;

  const CategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.itemsCount,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['image_url'],
      itemsCount: json['items_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, itemsCount, createdAt];
}
