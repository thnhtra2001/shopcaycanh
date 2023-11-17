import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/product.dart';
import 'package:shopcaycanh/services/cart_service.dart';

import '../../models/cart_item.dart';
import '../../models/cart_item1.dart';

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

  // Future<void> fetchCarts() async {
  //   _cartItem = await _cartService.fetchCarts();
  //   print(_cartItem.length);
  //   notifyListeners();
  // }

  // Future<void> addCart(List<Product> product, int quantity) async {
  //   final newOrders = await _cartService.addCarts(CartItem1(
  //      products: product,
  //      quantity: quantity,
  //       ));
  //   if (newOrders != null) {
  //     _cartItem.add(newOrders);
  //     notifyListeners();
  //   }
  // }

  Future<void> addCart(String? productId, String title, double price,
      String imageUrl, int quantity) async {
    // final index = _cartItem.indexWhere((cart) => cart.productId == productId);
    // print("AAAAAAAAAAAAAAAAAAAAAAAA");
    // print(index);
    // // print("CCCCCCCCCCCCCCCCCCCCCCCCCC");
    // // print(_cartItem.first.productId);
    // // print("BBBBBBBBBBBBBBBBBBBBBBBBB");
    // // print(_cartItem.first.id);

    // if (index == 0) {
    //   int quantity =1;
      final newOrders = await _cartService.addCarts(CartItem(
          id: productId,
          productId: productId,
          title: title,
          quantity: quantity,
          price: price,
          imageUrl: imageUrl));
      if (newOrders != null) {
        _cartItem.add(newOrders);
        notifyListeners();
      }
    // } else {
    //     final newOrders = await _cartService.addCarts(CartItem(
    //       productId: productId,
    //       title: title,
    //       quantity: 1,
    //       price: price,
    //       imageUrl: imageUrl));
    //   if (newOrders != null) {
    //     _cartItem.add(newOrders);
    //     notifyListeners();
    //   }
    // }
  }

  // Future<void> updateCart(CartItem cart) async {
  //   final index = _cartItem.indexWhere((cart) => cart.id == cart.productId);
  //   if (index >= 0) {
  //     if (await _cartService.updateCart(cart)) {
  //       _cartItem[index].quantity += 1;
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
