import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/models/orders_admin_product.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';

class AdminProductsManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders1 = [];
  Map<String, double> data1 = {};

  int get orders1Count {
    return _orders1.length;
  }

  List<OrderItem> get orders1 {
    return [..._orders1];
  }

  Future<Map<String, double>> fetchOrders() async {
    _orders1 = await _orderService.fetchOrders(3);
    for (var order in _orders1) {
      print(order.id);
      for (var product in order.products) {
        if (data1.containsKey(product.title)) {
          data1.update(
              product.title,
              (value) =>
                 value + product.quantity);
        } else {
          data1.putIfAbsent(
              product.title,
              () => product.quantity.toDouble()
                  );
        }
      }
    }
    return data1;
  }

  // Map<String, OrdersAdminProduct> get productTypeAdmin {
  //   for (var order in _orders1) {
  //     print(order.id);
  //     for (var product in order.products) {
  //       if (data1.containsKey(product.title)) {
  //         data1.update(
  //             product.title,
  //             (value) =>
  //                 value.copyWith(quantity: value.quantity + product.quantity));
  //       } else {
  //         data1.putIfAbsent(
  //             product.title,
  //             () => OrdersAdminProduct(
  //                 title: product.title,
  //                 quantity: product.quantity,
  //                 price: product.price,
  //                 price0: product.price0,
  //                 type: product.type));
  //       }
  //     }
  //   }
  //   print("BBBBBBBBBBBBBBBBBBBBBBBb");
  //   print(data1);
  //   return data1;
  // }

  // List<OrdersAdminProduct> get data {
  //   return data1.values.toList();
  // }
}
