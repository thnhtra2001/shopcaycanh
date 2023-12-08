
import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final String description;
  final int price0;
  final int price;
  final String imageUrl;
  late final String owner;
  late final String origin;
  late final String status;
  late final String type;
  late final int sl;
  final ValueNotifier<bool> _isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price0,
    required this.price,
    required this.imageUrl,
    required this.owner,
    required this.origin,
    required this.status,
    required this.type,
    required this.sl,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    int? price0,
    int? price,
    String? imageUrl,
    String? owner,
    String? origin,
    String? status,
    String? type,
    int? sl,
    bool? isFavorite,
  }) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price0: price0 ?? this.price0,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        owner: owner ?? this.owner,
        origin: origin ?? this.origin,
        status: status ?? this.status,
        type: type ?? this.type,
        sl: sl ?? this.sl,
        isFavorite: isFavorite ?? this.isFavorite,
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price0': price0,
      'price': price,
      'imageUrl': imageUrl,
      'owner': owner,
      'origin': origin,
      'status': status,
      'type' : type,
      'sl': sl,
      'isFavorite': isFavorite,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price0: json['price0'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      owner: json['owner'],
      origin: json['origin'],
      status: json['status'],
      type: json['type'],
      sl: json['sl'],
      isFavorite: json['isFavorite'],
    );
  }
}
