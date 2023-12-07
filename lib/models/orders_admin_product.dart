import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';

class OrdersAdminProduct with ChangeNotifier {
  late String? id;
  late String title;
  late int quantity;
  late int price;
  late int price0;
  late String type;
  OrdersAdminProduct({
    this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.price0,
    required this.type,
  });

  OrdersAdminProduct copyWith({
    String? id,
    String? title,
    int? quantity,
    int? price,
    int? price0,
    String? type,
  }) {
    return OrdersAdminProduct(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      price0: price0 ?? this.price0,
      type: type ?? this.type,
    );
  }
}