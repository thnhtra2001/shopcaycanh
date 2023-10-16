import 'package:flutter/widgets.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';

import 'package:flutter/foundation.dart';

class OrdersManager with ChangeNotifier {
  final List<OrderItem> _orders = [
    // OrderItem(
    //   id: 'o1',
    //   amount: 59.98,
    //   products: [
    //     CartItem(
    //       id: 'c1',
    //       title: 'Red shirt',
    //       price: 29.99,
    //       quantity: 2,
    //     ),
    //   ],
    //   dateTime: DateTime.now(),
    // ),
  ];
  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    _orders.insert(
        0,
        OrderItem(
            id: 'o${DateTime.now().toIso8601String()}',
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
