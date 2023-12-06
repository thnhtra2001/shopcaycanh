import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';
class AdminProductsManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  // late List<OrderItem> _orders = [];
  late List<OrderItem> _orders = [];
  late List<OrderItem> _orders1 = [];

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
  //   double get totalAmount {
  //   var total = 0.0;
  //   _orders1.forEach((key, cartItem) {
  //     total += cartItem.price * cartItem.quantity;
  //   });
  //   return total;
  // }
}
