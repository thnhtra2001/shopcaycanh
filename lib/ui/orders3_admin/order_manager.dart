import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';
class OrdersManagerAdmin3 with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders = [];
  late List<OrderItem> _orders0 = [];
  late List<OrderItem> _orders1 = [];
  late List<OrderItem> _orders2 = [];
  late List<OrderItem> _orders3 = [];

  int get ordersCount {
    return _orders.length;
  }
  List<OrderItem> get orders {
    return [..._orders];
  }

  // List<OrderItem> get order0 {
  //   _orders.forEach((order) {
      
  //   });
  //   return _orders0;
  // }
    List<OrderItem> updateList() {
    _orders3 = _orders
        .where((element) =>
            element.orderStatus == 1)
        .toList();
    return _orders3;
  }

  int get orders3Count {
    return _orders3.length;
  }
  List<OrderItem> get orders3 {
    return [..._orders3];
  }
  Future<void> fetchOrders() async {
    _orders = await _orderService.fetchOrders();
    print(_orders.length);
    notifyListeners();
  }
}
