// lib/src/providers/admin_provider.dart

import 'package:flutter/foundation.dart';
import '../services/firestore_service.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../models/order_model.dart'; // Import OrderModel
import 'package:design_by_contract/annotation.dart';

part 'admin_provider.g.dart';

@Contract()
class AdminProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();

  // Products Methods
  @Postcondition({
    'result is List<ProductModel>': 'Result must be a list of products',
  })
  Future<List<ProductModel>> _getAllProducts() async {
    return await _service.getProducts();
  }

  @Precondition({
    'product != null': 'ProductModel must not be null',
  })
  Future<void> _addProduct(ProductModel product) async {
    await _service.addProduct(product.toMap());
  }

  @Precondition({
    'product != null': 'ProductModel must not be null',
  })
  Future<void> _updateProduct(ProductModel product) async {
    await _service.updateProduct(product.id, product.toMap());
  }

  @Precondition({
    'productId.isNotEmpty': 'Product ID must not be empty',
  })
  Future<void> _deleteProduct(String productId) async {
    await _service.deleteProduct(productId);
  }

  @Precondition({
    'productId.isNotEmpty': 'Product ID must not be empty',
  })
  @Postcondition({
    'result != null && result.id == productId': 'If non-null, the returned product’s ID must match',
  })
  Future<ProductModel?> _getProductById(String productId) async {
    return await _service.getProductById(productId);
  }

  // Categories Methods
  @Postcondition({
    'result != null': 'getAllCategories must return a non-null list',
  })
  Future<List<CategoryModel>> _getAllCategories() async {
    return await _service.getCategories();
  }

  @Precondition({
    'category != null': 'CategoryModel must not be null',
  })
  Future<void> _addCategory(CategoryModel category) async {
    await _service.addCategory(category.toMap());
  }

  @Precondition({
    'category != null': 'CategoryModel must not be null',
  })
  Future<void> _updateCategory(CategoryModel category) async {
    await _service.updateCategory(category.id, category.toMap());
  }

  @Precondition({
    'categoryId.isNotEmpty': 'Category ID must not be empty',
  })
  Future<void> _deleteCategory(String categoryId) async {
    await _service.deleteCategory(categoryId);
  }

  @Precondition({
    'categoryId.isNotEmpty': 'Category ID must not be empty',
  })
  @Postcondition({
    'result != null && result.id == categoryId': 'If non-null, the returned category’s ID must match',
  })
  Future<CategoryModel?> _getCategoryById(String categoryId) async {
    return await _service.getCategoryById(categoryId);
  }

  // Fetch all 
  // TODO: check this try catch
  @Postcondition({
    'result != null': 'getAllOrders must return a non-null list',
  })
  Future<List<OrderModel>> _getAllOrders() async {
    try {
      List<OrderModel> orders = await _service.getAllOrders();
      return orders;
    } catch (e) {
      throw Exception('Failed to get all orders: $e');
    }
  }

  // Fetch orders by date
  // TODO: check this try catch
  @Precondition({
    'date != null': 'Date must not be null',
  })
  @Postcondition({
    'result != null': 'getOrdersByDate must return a non-null list',
  })
  Future<List<OrderModel>> _getOrdersByDate(DateTime date) async {
    try {
      List<OrderModel> orders = await _service.getOrdersByDate(date);
      return orders;
    } catch (e) {
      throw Exception('Failed to get orders by date: $e');
    }
  }

  @Postcondition({
    'result != null': 'getBestSellingProducts must return a non-null list',
  })
  Future<List<Map<String, dynamic>>> _getBestSellingProducts() async {
    try {
      List<Map<String, dynamic>> bestSelling = await _service.getBestSellingProducts();
      return bestSelling;
    } catch (e) {
      throw Exception('Failed to get best-selling products: $e');
    }
  }
}
