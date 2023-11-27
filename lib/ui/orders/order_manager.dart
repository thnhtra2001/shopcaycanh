import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/models/order_item.dart';

import 'package:flutter/foundation.dart';

import '../../models/product.dart';
import '../../services/order_service.dart';

class OrdersManager with ChangeNotifier {
  final OrderService _orderService = OrderService();
  late List<OrderItem> _orders = [];

  int get ordersCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    _orders = await _orderService.fetchOrders();
    print(_orders.length);
    notifyListeners();
  }

  Future<void> addOrders(OrderItem order) async {
    final newOrder = await _orderService.addOrder(order);
    print("AAAAAAAAAAAAAAAAAAAAAAA");
    print(newOrder);
    if (newOrder != null) {
      _orders.insert(0, newOrder);
      notifyListeners();
    }
    print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBb");
    print(_orders.length);
  }
}
