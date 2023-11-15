import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/product.dart';
import 'package:shopcaycanh/services/cart_service.dart';

import '../../models/cart_item.dart';
import 'package:flutter/foundation.dart';
import '../../models/product.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _cartitems = {};
  int get productCount {
    return _cartitems.length;
  }

  List<CartItem> get products {
    return _cartitems.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._cartitems}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _cartitems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
    int get totalQuantity {
    var totalQuantity = 0;
    _cartitems.forEach((key, cartItem) {
      totalQuantity +=  cartItem.quantity;
    });
    return totalQuantity;
  }

  Future<void> fetchCarts() async {
    print(_cartitems.length);
    notifyListeners();
  }
  Future<void> addItem(Product product) async {
    if (_cartitems.containsKey(product.id)) {
      _cartitems.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _cartitems.putIfAbsent(
        product.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          productId: product.id,
          title: product.title,
          price: product.price,
          quantity: 1,
          imageUrl: product.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> removeItem(String productId) async{
    _cartitems.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_cartitems.containsKey(productId)) {
      return;
    }
    if (_cartitems[productId]?.quantity as num > 1) {
      _cartitems.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _cartitems.remove(productId);
    }
    notifyListeners();
  }

  Future<void> clear() async {
    _cartitems = {};
    notifyListeners();
  }
}
