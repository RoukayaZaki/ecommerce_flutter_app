// lib/src/services/search_service.dart
import '../models/product_model.dart';
import 'package:design_by_contract/annotation.dart';

part 'search_service.g.dart';

@Contract()
class SearchService {
  @Precondition({
    'products != null': 'Products list must not be null',
  })
  List<ProductModel> _searchByText(List<ProductModel> products, String query) {
    if (query.isEmpty) {
      return products;
    }
    return products.where((product) =>
      product.name.toLowerCase().contains(query.toLowerCase()) ||
      product.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}
