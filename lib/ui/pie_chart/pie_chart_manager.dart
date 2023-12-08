import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';

class PieChartManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders1 = [];
  Map<String, double> data2 = {};

////da dat

  double get orders1Count {
    return _orders1.length.toDouble();
  }

  List<OrderItem> get orders1 {
    return [..._orders1];
  }

  Future<Map<String, double>> fetchOrdersAll() async {
    _orders1 = await _orderService.fetchOrdersAll();
    print("length order All");
    print(_orders1.length);
    for (var order in _orders1) {
      if (data2.containsKey(order.orderStatus.toString())) {
        data2.update(order.orderStatus.toString(), (value) => value + 1);
      } else {
        data2.putIfAbsent(order.orderStatus.toString(), () => 1);
      }
    }
    print("all");
    print(data2.length);
    return data2;
  }
}
