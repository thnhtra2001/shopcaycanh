import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/models/order_item.dart';


import 'package:flutter/foundation.dart';

import '../../models/product.dart';

class OrdersManager with ChangeNotifier {
  final List<OrderItem> _orders = [];
  int get ordersCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }
  void addOrders(List<CartItem> cartProducts, double total, int totalQuantity, String name, String phone, String address, String payResult) async {
    _orders.insert(
      0,
      OrderItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
        totalQuantity: totalQuantity,
        name:  name,
        phone: phone,
        address: address,
        payResult: payResult
      ),
    );
    notifyListeners();
  }
}