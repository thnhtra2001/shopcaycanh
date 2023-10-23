import 'package:flutter/material.dart';

class Payment {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  Payment({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  Payment copyWith({
    String? id,
    String? title,
    int? quantity,
    double? price,
    String? imageUrl,
  }) {
    return Payment(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
