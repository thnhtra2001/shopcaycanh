import 'dart:convert';

import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String? id;
  final String? productId;
  final String title;
  late final int quantity;
  late String description;
  final int price0;
  final int price;
  final String imageUrl;
  final String owner;
  final String origin;
  final String status;
  final String type;
  final int sl;

  CartItem({
    this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.description,
    required this.price0,
    required this.price,
    required this.imageUrl,
    required this.owner,
    required this.origin,
    required this.status,
    required this.type,
    required this.sl,
  });

  CartItem copyWith(
      {String? id,
      String? productId,
      String? title,
      int? quantity,
      String? description,
      int? price0,
      int? price,
      String? imageUrl,
      String? owner,
      String? origin,
      String? status,
      String? type,
      int? sl,
      }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      price0: price0 ?? this.price0,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      owner: owner ?? this.owner,
      origin: origin ?? this.origin,
      status: status ?? this.status,
      type: type ?? this.type,
      sl: sl ?? this.sl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'quantity': quantity,
      'description': description,
      'price0': price0,
      'price': price,
      'imageUrl': imageUrl,
      'owner': owner,
      'origin': origin,
      'status': status,
      'type': type,
      'sl': sl,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        productId: json['productId'],
        title: json['title'],
        quantity: json['quantity'],
        description: json['description'],
        price0: json['price0'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        owner: json['owner'],
        origin: json['origin'],
        status: json['status'],
        type: json['type'],
        sl: json['sl']
        );
  }
  // @override
  // String toString() {
  //   return '{${this.id}, ${this.title}, ${this.quantity},${this.price}, ${this.imageUrl}}';
  // }
}
