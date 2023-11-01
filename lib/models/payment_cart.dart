import 'package:flutter/material.dart';

import 'cart_item.dart';

class PaymentItem {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

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
    DateTime? dateTime,
  }) {
    return PaymentItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
