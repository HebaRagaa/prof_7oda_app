

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.image,
    required super.price,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      image: json['thumbnail'], // 👈 من DummyJSON
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
    );
  }
}


