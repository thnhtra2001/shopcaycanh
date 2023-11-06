import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/cart_item.dart';

import 'cart_item.dart';

class OrderItem {
  late  String? id;
  late double amount;
  late List<CartItem> products;
  late DateTime dateTime;
  late int totalQuantity;

  int get productCount {
    return products.length;
  }
  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    required this.totalQuantity,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    OrderItem? payments,
    DateTime? dateTime,
    int? totalQuantity,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  void add(int i, OrderItem paymentItem, int totalQuantity) {}
}
