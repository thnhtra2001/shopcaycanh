import 'dart:convert';

import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  CartItem copyWith(
      {String? id,
      String? title,
      int? quantity,
      double? price,
      String? imageUrl}) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl
    };
  }

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        title: json['title'],
        quantity: json['quantity'],
        price: json['price'],
        imageUrl: json['imageUrl']);
  }
}
