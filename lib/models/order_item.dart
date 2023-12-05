import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';

class OrderItem with ChangeNotifier {
  late String? id;
  late double amount;
  late List<CartItem> products;
  late DateTime dateTime;
  late int totalQuantity;
  late String name;
  late String phone;
  late String address;
  late String payResult;
  late String customerId;
  late int orderStatus;
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
    required this.customerId,
    required this.orderStatus,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
    int? totalQuantity,
    String? name,
    String? phone,
    String? address,
    String? payResult,
    String? customerId,
    int? orderStatus,
    String? owner,
    String? origin,
    String? status,
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
      customerId: customerId ?? this.customerId,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  void add(
      int i,
      OrderItem paymentItem,
      int totalQuantity,
      String name,
      String phone,
      String address,
      String payResult,
      String customerId,
      List<CartItem> products,
      String owner,
      String origin,
      String status,
      int orderStatus,
      ) {}

  Map toJson() {
    return {
      'amount': amount,
      'products': products.map((item) => item.toJson()).toList(),
      'dateTime': dateTime.toString(),
      'totalQuantity': totalQuantity,
      'name': name,
      'phone': phone,
      'address': address,
      'payResult': payResult,
      'customerId': customerId,
      'orderStatus': orderStatus,
    };
  }

  factory OrderItem.fromJson(dynamic json) {
    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      products: (json['products'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      dateTime: DateTime.parse(json['dateTime']),
      totalQuantity: json['totalQuantity'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      payResult: json['payResult'],
      customerId: json['customerId'],
      orderStatus: json['orderStatus']
    );
  }
}
