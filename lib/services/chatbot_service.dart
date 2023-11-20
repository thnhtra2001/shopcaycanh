import 'dart:convert';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/models/product.dart';

import '../models/cart_item1.dart';
import '../models/order_item.dart';
import './firebase_service.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ChatbotService extends FirebaseService{
  ChatbotService(): super();

  Future<Map<String, dynamic>> fetchCarts() async{
    final Map<String, dynamic> _cartItem = {};

    try{
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      final uid = (await AuthService().loadSavedAuthToken())!.userId;
      final ordersUrl = Uri.parse('$databaseUrl/carts.json?auth=$authToken');
      final response = await http.get(ordersUrl);
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;

      if(response.statusCode != 200){
        print(ordersMap['error']);
        return _cartItem;
      }

      // ordersMap.forEach((id, carts) { 
      //   _cartItem.putIfAbsent(id, CartItem.fromJson({'id':id, ...carts}));

      // });

      return _cartItem;
    }catch(error){
      print(error);
      return _cartItem;
    }
  }

  Future<CartItem?> addCarts(CartItem cart) async{
    try{
      final url = Uri.parse('$databaseUrl/carts.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          cart.toJson(),
        )
      );

      if(response.statusCode != 200){
        throw Exception(json.decode(response.body)['error']);
      }

      print(json.decode(response.body));

      return cart.copyWith(
        id: json.decode(response.body)
      );
    } catch(error){
      print(error);
      return null;
    }
  }
    Future<bool> updateCart(CartItem cart) async {
    try {
      final url =
          Uri.parse('$databaseUrl/carts/${cart.id}.json?auth=$token');
      final response =
          await http.patch(url, body: json.encode(cart.toJson()));

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