// lib/src/models/order_item.dart
import 'package:design_by_contract/annotation.dart';

part 'order_item.g.dart';

@Contract({
  'productId.isNotEmpty': 'Product ID must not be empty',
  'quantity > 0': 'Quantity must be greater than zero',
})
class OrderItem {
  final String productId;
  final int quantity;

  @Precondition({
    'productId.isNotEmpty': 'Product ID must be provided',
    'quantity > 0': 'Quantity must be greater than zero',
  })
  OrderItem({required this.productId, required this.quantity});

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  

  @Postcondition({
    'result.containsKey("productId")': 'Resulting map must include productId',
    'result["productId"] == productId': 'productId must match the object\'s value',
    'result.containsKey("quantity")': 'Resulting map must include quantity',
    'result["quantity"] == quantity': 'quantity must match the object\'s value',
  })
  Map<String, dynamic> _toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
