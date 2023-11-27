import 'dart:convert';

import 'package:flutter/material.dart';

class CartItem1 with ChangeNotifier {
  final String? id;
  final String? productId;
  final String title;
  late final int quantity;
  final double price;
  final String imageUrl;
  final String owner;
  final String origin;
  final String status;

  CartItem1({
    this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.owner,
    required this.origin,
    required this.status,
  });

  CartItem1 copyWith(
      {String? id,
      String? productId,
      String? title,
      int? quantity,
      double? price,
      String? imageUrl,
      String? owner,
      String? origin,
      String? status
      }) {
    return CartItem1(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      owner: owner ?? this.owner,
      origin: origin ?? this.origin,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'owner': owner,
      'origin': origin,
      'status': status,
    };
  }

  factory CartItem1.fromJson(Map<String, dynamic> json) {
    return CartItem1(
        id: json['id'],
        productId: json['productId'],
        title: json['title'],
        quantity: json['quantity'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        owner: json['owner'],
        origin: json['origin'],
        status: json['status']
        );
  }
  // @override
  // String toString() {
  //   return '{${this.id}, ${this.title}, ${this.quantity},${this.price}, ${this.imageUrl}}';
  // }
}
