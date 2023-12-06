import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';
class OrdersManagerAdmin2 with ChangeNotifier {
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
  //   List<OrderItem> updateList() {
  //   _orders2 = _orders
  //       .where((element) =>
  //           element.orderStatus == 2)
  //       .toList();
  //   return _orders2;
  // }

  int get orders2Count {
    return _orders2.length;
  }
  List<OrderItem> get orders2 {
    return [..._orders2];
  }
  Future<void> fetchOrders() async {
    _orders2 = await _orderService.fetchOrders(2);
    print(_orders2.length);
    notifyListeners();
  }
}
