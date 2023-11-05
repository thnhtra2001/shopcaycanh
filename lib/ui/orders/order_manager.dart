import 'package:flutter/widgets.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';

import 'package:flutter/foundation.dart';

class OrdersManager with ChangeNotifier {
  List<OrderItem> _items = [];

  int get orderCount {
    return _items.length;
  }

  List<OrderItem> get items {
    return [..._items];
  }

  OrderItem? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  void fetchOrders() async {
    notifyListeners();
  }

  void addOrder(OrderItem order) async {
      _items.add(order);
      notifyListeners();
  }
}
