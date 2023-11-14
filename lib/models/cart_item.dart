import 'dart:convert';

import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String? id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    this.id,
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

  Map toJson() => {
        'title': title,
        'quantity': quantity,
        'price': price,
        'imageUrl': imageUrl
      };

      
  factory CartItem.fromJson(dynamic json) {
    return CartItem(
        id: json['id'],
        title: json['title'],
        quantity: json['quantity'],
        price: json['price'],
        imageUrl: json['imageUrl']);
  }
  @override
  String toString(){
    return '{${this.id}, ${this.title}, ${this.quantity},${this.price}, ${this.imageUrl}}';
  }
}
