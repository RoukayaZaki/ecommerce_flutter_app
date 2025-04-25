import 'package:flutter/foundation.dart';
import '../services/firestore_service.dart';
import '../models/order_model.dart';
import 'package:design_by_contract/annotation.dart';

part 'orders_provider.g.dart';

@Contract()
class OrdersProvider extends ChangeNotifier {
  final _service = FirestoreService();
  List<OrderModel> userOrders = [];

  @Precondition({
    'userId.isNotEmpty': 'User ID must not be empty',
  })
  Future<void> _loadUserOrders(String userId) async {
    userOrders = await _service.getUserOrders(userId);
    notifyListeners();
  }

  @Precondition({
    'order != null': 'Order must not be null',
    'order.userId.isNotEmpty': 'Order must have a valid userId',
  })
  @Postcondition({
    'userOrders.any((o) => o.userId == order.userId)': 'The new order should appear in user orders',
  })
  Future<void> _placeOrder(OrderModel order) async {
    await _service.addOrder(order.toMap());
    // Reload orders if needed
    await loadUserOrders(order.userId);
  }
}
