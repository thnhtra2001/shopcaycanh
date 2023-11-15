import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/product.dart';
import 'package:shopcaycanh/services/cart_service.dart';

import '../../models/cart_item.dart';
import 'package:flutter/foundation.dart';
import '../../models/product.dart';

class CartManager1 with ChangeNotifier {
  final CartService _cartService = CartService();
  late List<CartItem> _cartItem = [];

  int get productCount {
    return _cartItem.length;
  }

  List<CartItem> get products {
    return [..._cartItem];
  }

  double get totalAmount {
    var total = 0.0;
    _cartItem.forEach((cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get totalQuantity {
    var totalQuantity = 0;
    _cartItem.forEach((cartItem) {
      totalQuantity += cartItem.quantity;
    });
    return totalQuantity;
  }

  Future<void> fetchCarts() async {
    _cartItem = await _cartService.fetchCarts();
    print(_cartItem.length);
    notifyListeners();
  }

  Future<void> addCart(String? productId, String title, double price,
      String imageUrl, int quantity) async {
    // final index = _cartItem.indexWhere((cart) => cart.id == cart.productId);
    // if (index > 0) {
    //   if (await _cartService.updateCart(CartItem(
    //       productId: productId,
    //       title: title,
    //       quantity: quantity,
    //       price: price,
    //       imageUrl: imageUrl))) {
    //     _cartItem[index].quantity += 1;
    //     notifyListeners();
    //   }
    // }

    final newOrders = await _cartService.addCarts(CartItem(
        productId: productId,
        title: title,
        quantity: 1,
        price: price,
        imageUrl: imageUrl));
    if (newOrders != null) {
      _cartItem.add(newOrders);
      notifyListeners();
    }
  }

  // Future<void> updateCart(int quantity) async {
  //   final index = _cartItem.indexWhere((cart) => cart.id == cart.productId);
  //   if (index >= 0) {
  //     if (await _cartService.updateCart(_cartItem.quantity)) {
  //       _cartItem[index].quantity = quantity +1;
  //       notifyListeners();
  //     }
  //   }
  // }

  Future<void> removeItem(String productId) async {
    _cartItem.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    notifyListeners();
  }

  Future<void> clear() async {
    _cartItem = [];
    notifyListeners();
  }
}
