import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/cart_item.dart';

import 'cart_item.dart';

class PaymentItem {
  late  String? id;
  late double amount;
  late List<CartItem> products;
  late DateTime dateTime;

  int get productCount {
    return products.length;
  }
  PaymentItem({
    this.id,
    required this.amount,
    required this.products,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  PaymentItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    PaymentItem? payments,
    DateTime? dateTime,
  }) {
    return PaymentItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  void add(int i, PaymentItem paymentItem) {}
}
