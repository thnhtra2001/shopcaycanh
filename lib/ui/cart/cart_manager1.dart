import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/product.dart';
import 'package:shopcaycanh/services/cart_service.dart';

import '../../models/cart_item.dart';
import '../../models/cart_item1.dart';

import 'package:flutter/foundation.dart';
import '../../models/product.dart';

class CartManager1 with ChangeNotifier {
  CartService _cartService = CartService();
  List<CartItem1> _cartItem = [];

  int get cartCount {
    return _cartItem.length;
  }

  List<CartItem1> get products {
    return _cartItem.toList();
  }

  List<CartItem1> get cartItem {
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
    notifyListeners();
  }

  Future<void> addCart(CartItem1 cart) async {
    final newOrders = await _cartService.addCarts(cart);
    if (newOrders != null) {
      _cartItem.add(cart);

      notifyListeners();
    }
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa");
    print(_cartItem);
    print("----------------------------");
    print(_cartItem.length);
    print("AAAAAAAAAAAAAAAAAAAAAAAAA");
    _cartItem.add(cart);
    notifyListeners();
  }

  Future<void> updateCart(CartItem1 cart, int index) async {
    if (index >= 0) {
      if (await _cartService.updateCart(cart)) {
        _cartItem[index] = cart;
        print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
        print(_cartItem[index].quantity);
        notifyListeners();
      }
    }
  }

  void test(index) {
    print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
    print(index);
  }

  Future<void> removeItem(CartItem1 cart) async {
    await _cartService.deleteCarts(cart);
    _cartItem.remove(cart);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    notifyListeners();
  }

  Future<void> clear() async {
    await _cartService.deleteAllCarts();
    _cartItem = [];
    notifyListeners();
  }
}
