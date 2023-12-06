import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';
class OrdersManagerAdmin1 with ChangeNotifier {
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
  //   _orders1 = _orders1
  //       .where((element) =>
  //           element.orderStatus == 3)
  //       .toList();
  //   return _orders1;
  // }

  int get orders1Count {
    return _orders1.length;
  }
  List<OrderItem> get orders1 {
    return [..._orders1];
  }
  Future<void> fetchOrders() async {
    _orders1 = await _orderService.fetchOrders(3);
    print("///////////////////");
    print(_orders1.length);
    notifyListeners();
  }
}
