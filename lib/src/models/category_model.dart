// lib/src/models/category_model.dart
import 'package:design_by_contract/annotation.dart';

part 'category_model.g.dart';

@Contract()
class CategoryModel {
  final String id;
  final String name;
  @Precondition({
    'id != null': 'id must be provided',
    'name != null': 'name must be provided',
  })
  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromMap(Map<String, dynamic> map, String docId) {
    return CategoryModel(
      id: docId,
      name: map['name'] ?? 'Unnamed Category', // Provide a default value
    );
  }

  @Postcondition({
    'result.containsKey("name")': 'The map must contain a name field',
    'result["name"] == name': 'The map must contain the correct name value',
  })
  Map<String, dynamic> _toMap() {
    return {
      'name': name,
      // Add other fields if necessary
    };
  }
}
