import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';

class FilterOrderAdminManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders = [];
  late List<OrderItem> data = [];
  late List<OrderItem> _orders1 = [];

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

  Future<List<OrderItem>> fetchOrders() async {
    _orders1 = await _orderService.fetchOrders(3);
    var quater = 4;
    var year = 2023;
      final startMonth = (quater - 1) * 3 + 1;
      final endMonth = startMonth + 2;
      return data=_orders1
          .where((e) =>
              e.dateTime.year == year &&
              e.dateTime.month >= startMonth &&
              e.dateTime.month <= endMonth)
          .toList();
  }

  // List<OrderItem> filterOrder(int quater, int year) {
  //   print("AAAAAAAAAAAaa");
  //   final startMonth = (quater - 1) * 3 + 1;
  //   final endMonth = startMonth + 2;
  //   return _orders1
  //       .where((order1) =>
  //           order1.dateTime.year == year &&
  //           order1.dateTime.month >= startMonth &&
  //           order1.dateTime.month <= endMonth)
  //       .toList();
  // }
}
