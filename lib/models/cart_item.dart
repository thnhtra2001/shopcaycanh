import 'dart:convert';

import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String? id;
  final String? productId;
  final String title;
  late final int quantity;
  final int price0;
  final int price;
  final String imageUrl;
  final String owner;
  final String origin;
  final String status;

  CartItem({
    this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price0,
    required this.price,
    required this.imageUrl,
    required this.owner,
    required this.origin,
    required this.status,
  });

  CartItem copyWith(
      {String? id,
      String? productId,
      String? title,
      int? quantity,
      int? price0,
      int? price,
      String? imageUrl,
      String? owner,
      String? origin,
      String? status
      }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price0: price0 ?? this.price0,
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
      'price0': price0,
      'price': price,
      'imageUrl': imageUrl,
      'owner': owner,
      'origin': origin,
      'status': status,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        productId: json['productId'],
        title: json['title'],
        quantity: json['quantity'],
        price0: json['price0'],
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
