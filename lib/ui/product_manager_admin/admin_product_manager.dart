import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/models/orders_admin_product.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';

class AdminProductsManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders1 = [];
    Map<String, OrdersAdminProduct> data1 = {};

  int get orders1Count {
    return _orders1.length;
  }

  List<OrderItem> get orders1 {
    return [..._orders1];
  }

  Future<void> fetchOrders() async {
    _orders1 = await _orderService.fetchOrders(3);
    notifyListeners();
  }

  Map<String, OrdersAdminProduct> get productTypeAdmin {
    for (var order in orders1) {
      for (var product in order.products) {
        if (data1.containsKey(product.title)) {
          data1.update(
              product.title,
              (value) =>
                  value.copyWith(quantity: value.quantity + product.quantity));
        } else {
          data1.putIfAbsent(
              product.title,
              () => OrdersAdminProduct(
                  title: product.title,
                  quantity: product.quantity,
                  price: product.price,
                  price0: product.price0,
                  type: product.type));
        }
      }
    }
  return data1;
  }

    List<OrdersAdminProduct> get data {
    return data1.values.toList();
  }
}
