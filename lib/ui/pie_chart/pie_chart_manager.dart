import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';

class PieChartManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders0 = [];
  late List<OrderItem> _orders1 = [];
  late List<OrderItem> _orders2 = [];
  late List<OrderItem> _orders3 = [];
  final Map<String, dynamic> _dataMap = {};

  ///////da huy
  Future<void> fetchOrders3() async {
    _orders3 = await _orderService.fetchOrders(1);
    print(_orders3.length);
    notifyListeners();
  }
  int get orders3Count {
    return _orders3.length;
  }

  List<OrderItem> get orders3 {
    return [..._orders3];
  }

  /////dang van chuyen
  Future<void> fetchOrders2() async {
    _orders2 = await _orderService.fetchOrders(2);
    print(_orders2.length);
    notifyListeners();
  }
  int get orders2Count {
    return _orders2.length;
  }

  List<OrderItem> get orders2 {
    return [..._orders2];
  }
////da dat

  double get orders1Count {
    return _orders1.length.toDouble();
  }


  List<OrderItem> get orders1 {
    return [..._orders1];
  }

  Future<void> fetchOrders1() async {
    _orders1 = await _orderService.fetchOrders(3);
    print("///////////////////");
    print(_orders1.length);
    notifyListeners();
  }
}
