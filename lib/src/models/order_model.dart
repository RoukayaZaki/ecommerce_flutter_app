// lib/src/models/order_model.dart
import 'order_item.dart';
import 'package:design_by_contract/annotation.dart';

part 'order_model.g.dart';


@Contract()
class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double total;
  final DateTime date;

  @Precondition({
    'id.isNotEmpty': 'Order ID must be provided',
    'userId.isNotEmpty': 'User ID must be provided',
    'items.isNotEmpty': 'Items list must not be empty',
    'total > 0': 'Total must be greater than zero',
  })
  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.date,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String docId) {
    var items = (map['items'] as List)
        .map((e) => OrderItem.fromMap(e))
        .toList();
    return OrderModel(
      id: docId,
      userId: map['userId'] ?? '',
      items: items,
      total: (map['total'] as num).toDouble(),
      date: DateTime.parse(map['date']),
    );
  }

  @Postcondition({
    'result["userId"] == userId': 'userId must match original value',
    'result["items"].length == items.length': 'items count must match',
    'result["total"] == total': 'total must match original value',
  })
  Map<String, dynamic> _toMap() {
    return {
      'userId': userId,
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'date': date.toIso8601String(),
    };
  }
}
