import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/models/orders_admin_product.dart';
import 'package:shopcaycanh/services/orders_admin_service.dart';

class AdminProductsManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrdersAdminProduct> _pro = [];
  late List<OrderItem> _orders1 = [];

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

  // List<OrdersAdminProduct> get productIdAdmin {
  //   late OrdersAdminProduct _x;
  //   late List<OrdersAdminProduct> pro = [];
  //   for (int i = 0; i < _orders1.length; i++) {
  //     for (int j = 0; j < _orders1[i].products.length; j++) {
  //       if (pro.isEmpty) {
  //         print("NULLLLLLLLL");
  //         _x = OrdersAdminProduct(
  //             id: _orders1[i].products[j].id,
  //             title: _orders1[i].products[j].title,
  //             quantity: _orders1[i].products[j].quantity,
  //             price0: _orders1[i].products[j].price0,
  //             price: _orders1[i].products[j].price,
  //             type: _orders1[i].products[j].type);
  //         pro.add(_x);
  //         print("length:");
  //         print(pro.length);
  //       } else if (pro.length >= 1) {
  //         for (int k = 0; k < pro.length; k++) {
  //           if (pro[k].id != _orders1[i].products[j].productId) {
  //             _x = OrdersAdminProduct(
  //                 id: _orders1[i].products[j].id,
  //                 title: _orders1[i].products[j].title,
  //                 quantity: _orders1[i].products[j].quantity,
  //                 price0: _orders1[i].products[j].price0,
  //                 price: _orders1[i].products[j].price,
  //                 type: _orders1[i].products[j].type);
  //             pro.add(_x);
  //           } 
  //           // else {
  //           //   pro[k].quantity += _orders1[i].products[j].quantity;
  //           //   pro[k].price += _orders1[i].products[j].price;
  //           //   pro[k].price0 += _orders1[i].products[j].price0;
  //           //   print("-------------------A-----------------------");
  //           //   print(pro[0].quantity);
  //           //   print(pro[0].price);
  //           //   print(pro[0].price0);
  //           //   print("-------------------B-----------------------");
  //           // }
  //           // _pro[k].quantity += _orders1[i].products[j].quantity;
  //           // _pro[k].price += _orders1[i].products[j].price;
  //           // _pro[k].price0 += _orders1[i].products[j].price0;
  //           // print("------------------------------------------");
  //           // print(_pro[0].quantity);
  //           // print(_pro[0].price);
  //           // print(_pro[0].price0);
  //         }
  //       }
  //     }
  //   }
  //   return pro;
  // }

  List<OrdersAdminProduct> get productTypeAdmin {
    late OrdersAdminProduct _x;
    late List<OrdersAdminProduct> _pro = [];
    for (int i = 0; i >= _orders1.length - 1; i++) {
      for (int j = 0; j >= _orders1[i].products.length; j++) {
        for (int k = 0; k >= _pro.length; k++) {
          if (_orders1[i].products[j].type != _pro[k].type) {
            _x = OrdersAdminProduct(
              id: _orders1[i].products[j].id,
              title: _orders1[i].products[j].title,
              quantity: _orders1[i].products[j].quantity,
              price0: _orders1[i].products[j].price0,
              price: _orders1[i].products[j].price,
              type: _orders1[i].products[j].type,
            );
            _pro.add(_x);
          } else {
            // _x = OrdersAdminProduct(
            //     id: _orders1[i].products[j].id,
            //     title: _orders1[i].products[j].title,
            //     quantity: _orders1[i].products[j].quantity,
            //     price0: _orders1[i].products[j].price0,
            //     price: _orders1[i].products[j].price);
            // _pro.add(_x);
            _pro[k].quantity += _orders1[i].products[j].quantity;
            _pro[k].price += _orders1[i].products[j].price;
            _pro[k].price0 += _orders1[i].products[j].price0;
          }
        }
      }
    }
    return _pro;
  }
}
