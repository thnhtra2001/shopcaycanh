import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'product.dart';

class CartItem1 with ChangeNotifier {
  // final String? id;
  // final String? productId;
  // final String title;
  // final int quantity;
  // final double price;
  // final String imageUrl;
  final int quantity;
  final List<Product> products;

  CartItem1({
    // this.id,
    // required this.productId,
    // required this.title,
    // required this.quantity,
    // required this.price,
    // required this.imageUrl,
    required this.quantity,
    required this.products,
  });

  CartItem1 copyWith(
      {String? id,
      // String? productId,
      // String? title,
      // int? quantity,
      // double? price,
      // String? imageUrl
      int? quantity,
      List<Product>? products,
      }) {
    return CartItem1(
      // id: id ?? this.id,
      // productId: productId,
      // title: title ?? this.title,
      // quantity: quantity ?? this.quantity,
      // price: price ?? this.price,
      // imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': productId,
      // 'title': title,
      // 'quantity': quantity,
      // 'price': price,
      // 'imageUrl': imageUrl
      'quantity': quantity,
      'products': products,
    };
  }

  factory CartItem1.fromJson(Map<String, dynamic> json) {
    return CartItem1(
        // id: json['id'],
        // productId: json['productId'],
        // title: json['title'],
        // quantity: json['quantity'],
        // price: json['price'],
        // imageUrl: json['imageUrl']);
        quantity: json['quantity'],
        products: json['products'],
    );
  }
  // @override
  // String toString() {
  //   return '{${this.id}, ${this.title}, ${this.quantity},${this.price}, ${this.imageUrl}}';
  // }
}
