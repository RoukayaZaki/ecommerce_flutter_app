import 'package:flutter/foundation.dart';
import '../services/firestore_service.dart';
import '../models/product_model.dart';
import 'package:design_by_contract/annotation.dart';

part 'products_provider.g.dart';

@Contract()
class ProductsProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<ProductModel> products = [];

  ProductsProvider() {
    loadProducts();
  }

  @Postcondition({
    'products.isNotEmpty': 'Products should be loaded after fetching.',
  })
  Future<void> _loadProducts() async {
    products = await _service.getProducts();
    notifyListeners();
  }

  @Invariant()
  List<ProductModel> _searchByText(String query) {
    if (query.isEmpty) {
      return products;
    }
    return products.where((p) =>
      p.name.toLowerCase().contains(query.toLowerCase()) ||
      p.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  @Precondition({
    'id.isNotEmpty': 'Product ID must not be empty',
  })
  ProductModel? _getProductById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @Precondition({
    'product != null': 'Product must not be null',
    'product.name.isNotEmpty': 'Product must have a name',
  })
  @Postcondition({
    'products.any((p) => p.id == product.id)': 'The new product should appear in the product list',
  })
  Future<void> _addProduct(ProductModel product) async {
    await _service.addProduct(product.toMap());
    await loadProducts();
  }

  @Precondition({
    'product != null': 'Product must not be null',
    'product.id.isNotEmpty': 'Product must have an ID',
  })
  Future<void> _updateProduct(ProductModel product) async {
    await _service.updateProduct(product.id, product.toMap());
    await loadProducts();
  }

  @Precondition({
    'productId.isNotEmpty': 'Product ID must not be empty',
  })
  @Postcondition({
    '!products.any((p) => p.id == productId)': 'The product should not appear in the product list',
  })
  Future<void> _deleteProduct(String productId) async {
    await _service.deleteProduct(productId);
    await loadProducts();
  }
}
