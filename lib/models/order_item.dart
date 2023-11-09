import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/cart_item.dart';

import 'cart_item.dart';

class OrderItem {
  late  String? id;
  late double amount;
  late List<CartItem> products;
  late DateTime dateTime;
  late int totalQuantity;
  late String name;
  late String phone;
  late String address;
  late String payResult;

  int get productCount {
    return products.length;
  }
  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    required this.totalQuantity,
    required this.name,
    required this.phone,
    required this.address,
    required this.payResult,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    OrderItem? payments,
    DateTime? dateTime,
    int? totalQuantity,
    String? name,
    String? phone,
    String? address,
    String? payResult,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      payResult: payResult ?? this.payResult,
    );
  }

  void add(int i, OrderItem paymentItem, int totalQuantity, String name, String phone, String address, String payResult) {}
}
