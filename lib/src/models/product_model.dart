import 'package:design_by_contract/annotation.dart';

part 'product_model.g.dart';


@Contract()
class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final double price;
  final int stockQuantity;
  final String imageUrl;
  final String description;

  @Precondition({
    'id.isNotEmpty': 'Product ID is required',
    'name.isNotEmpty': 'Name is required',
    'categoryId.isNotEmpty': 'Category ID is required',
    'price >= 0': 'Price cannot be negative',
    'stockQuantity >= 0': 'Stock quantity cannot be negative',
    'imageUrl.isNotEmpty': 'Image URL is required',
    'description.isNotEmpty': 'Description is required',
  })
  ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.stockQuantity,
    required this.imageUrl,
    required this.description,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String docId) {
    return ProductModel(
      id: docId,
      name: map['name'] ?? '',
      categoryId: map['category_id'] ?? '',
      price: (map['price'] as num).toDouble(),
      stockQuantity: map['stockQuantity'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
    );
  }

  @Postcondition({
    'result["price"] >= 0': 'price must be non-negative',
    'result["stockQuantity"] >= 0': 'stock must be non-negative',
  })
  Map<String, dynamic> _toMap() {
    return {
      'name': name,
      'category_id': categoryId,
      'price': price,
      'stockQuantity': stockQuantity,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
