import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';

class OrdersManagerAdmin with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders = [];
  late List<OrderItem> _orders0 = [];
  late List<OrderItem> _ordersA = [];
  late List<OrderItem> _orders2 = [];
  late List<OrderItem> _orders3 = [];

  int get ordersCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  //   List<OrderItem> updateList() {
  //   _orders0 = _orders
  //       .where((element) =>
  //           element.orderStatus == 0)
  //       .toList();
  //   return _orders0;
  // }

  int get orders0Count {
    return _orders0.length;
  }

  List<OrderItem> get orders0 {
    return [..._orders0];
  }

  Future<void> fetchOrders() async {
    _orders0 = await _orderService.fetchOrders(0);
    notifyListeners();
  }

  // Future<void> removeItem(OrderItem order) async {
  //   _orders0.remove(order);
  //   notifyListeners();
  // }
    Future<void> removeItem(String id) async {
    final index = _orders0.indexWhere((item) => item.id == id);
    OrderItem? existingProduct = _orders0[index];
    _orders0.removeAt(index);
    notifyListeners();
  }
}
