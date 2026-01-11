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
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      imageUrl: json['image_url']?.toString(),
      itemsCount: int.tryParse(json['items_count']?.toString() ?? '0') ?? 0,
      createdAt: DateTime.parse(json['created_at']?.toString() ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, itemsCount, createdAt];
}
