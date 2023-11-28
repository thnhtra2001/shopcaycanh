import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/models/product.dart';

import '../models/cart_item1.dart';
import './firebase_service.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class CartService extends FirebaseService {
  CartService() : super();
  Future<List<CartItem1>> fetchCarts() async {
    final List<CartItem1> _cartItem = [];
    try {
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      // final uid = (await AuthService().loadSavedAuthToken())!.userId;
      final cartsUrl = Uri.parse('$databaseUrl/carts.json?auth=$authToken');
      final response = await http.get(cartsUrl);
      final cartsMap = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        print(cartsMap['error']);
        return _cartItem;
      }
      cartsMap.forEach((key, value) {
        _cartItem.add( CartItem1.fromJson({'id': key, ...value}));
      });
      print(_cartItem);
      return _cartItem;
    } catch (error) {
      print(error);
      return _cartItem;
    }
  }
  Future<CartItem1?> addCarts(CartItem1 cart) async {
    try {
      final url = Uri.parse('$databaseUrl/carts.json?auth=$token');
      final response = await http.post(url,
          body: json.encode(
            cart.toJson(),
          ));
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      print(json.decode(response.body));
      return cart.copyWith(id: json.decode(response.body));
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateCart(CartItem1 cart) async {
    try {
      final url = Uri.parse('$databaseUrl/carts/${cart.id}.json?auth=$token');
      final response = await http.put(url, body: json.encode(cart.toJson()));
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
  Future<bool> deleteCarts(CartItem1 cart) async {
    try {
      final url = Uri.parse('$databaseUrl/carts/${cart.id}.json?auth=$token');
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
    Future<bool> deleteAllCarts() async {
    try {
      final url = Uri.parse('$databaseUrl/carts.json?auth=$token');
      await Clipboard.setData(ClipboardData(text: url.toString()));
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
