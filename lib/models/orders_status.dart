import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';

class OrderStatus with ChangeNotifier {
  late String title;
  late int quantity;
  OrderStatus({
    required this.title,
    required this.quantity,
  });

  OrderStatus copyWith({
    String? title,
    int? quantity,
  }) {
    return OrderStatus(
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
    );
  }
}