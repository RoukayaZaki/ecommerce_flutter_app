import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import 'package:design_by_contract/annotation.dart';

part 'cart_provider.g.dart';

@Contract()
class CartProvider extends ChangeNotifier {
  Map<String, int> cartItems = {}; // productId -> quantity

  @Precondition({
    'product.id.isNotEmpty': 'Product ID must not be empty',
  })
  @Postcondition({
    'cartItems.containsKey(product.id)': 'Product should be in cart after adding',
  })
  void _addToCart(ProductModel product) {
    if (cartItems.containsKey(product.id)) {
      cartItems[product.id] = cartItems[product.id]! + 1;
    } else {
      cartItems[product.id] = 1;
    }
    notifyListeners();
  }

  @Precondition({
    'productId.isNotEmpty': 'Product ID must not be empty',
  })
  @Postcondition({
    '!cartItems.containsKey(productId)': 'Product should be removed from cart',
  })
  void _removeFromCart(String productId) {
    cartItems.remove(productId);
    notifyListeners();
  }

  @Precondition({
    'productId.isNotEmpty': 'Product ID must not be empty',
    'cartItems.containsKey(productId)': 'item must be in cart',
  })
  void _updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      cartItems.remove(productId);
    } else {
      cartItems[productId] = newQuantity;
    }
    notifyListeners();
  }

  @Invariant()
  double _getTotal(List<ProductModel> allProducts) {
    double total = 0.0;
    for (var entry in cartItems.entries) {
      var product = allProducts.firstWhere((p) => p.id == entry.key);
      total += product.price * entry.value;
    }
    return total;
  }


  @Postcondition({
    'cartItems.isEmpty': 'Cart should be empty after clearing',
  })
  void _clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
