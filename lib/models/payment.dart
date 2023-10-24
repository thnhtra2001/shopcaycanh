import 'package:flutter/material.dart';
import 'cart_item.dart';

class Payment {
  final String? id;
  final List<CartItem> products;
  final double amount;

   int get productSelectedCount {
    return products.length;
  }

  Payment({this.id, required this.products, required this.amount});

  Payment copyWith({
    String? id,
    List<CartItem>? products,
    double? amount,
  }) {
    return Payment(
      id: id ?? this.id,
      products: products ?? this.products,
      amount: amount ?? this.amount,
    );
  }
}
