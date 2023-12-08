import 'dart:convert';
import '../models/order_item.dart';
import './firebase_service.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'package:flutter/services.dart';

class OrderServiceAdmin extends FirebaseService {
  OrderServiceAdmin() : super();

  Future<List<OrderItem>> fetchOrders(value) async {
    late List<OrderItem> orders = [];
    try {
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      // final uid = (await AuthService().loadSavedAuthToken())!.userId;
      final ordersUrl = Uri.parse(
          '$databaseUrl/orders.json?orderBy="orderStatus"&equalTo=$value&auth=$authToken');
      final response = await http.get(ordersUrl);
      final ordersMap = json.decode(response.body) as Map<dynamic, dynamic>;
      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }
      ordersMap.forEach((keys, value) {
        orders.insert(0, OrderItem.fromJson({'id': keys, ...value}));
      });
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }
    Future<List<OrderItem>> fetchOrdersAll() async {
    late List<OrderItem> orders = [];
    try {
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      // final uid = (await AuthService().loadSavedAuthToken())!.userId;
      final ordersUrl = Uri.parse(
          '$databaseUrl/orders.json?orderBy="orderStatus"&auth=$authToken');
      final response = await http.get(ordersUrl);
      final ordersMap = json.decode(response.body) as Map<dynamic, dynamic>;
      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }
      ordersMap.forEach((keys, value) {
        orders.insert(0, OrderItem.fromJson({'id': keys, ...value}));
      });
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  // Future<OrderItem?> addOrder(OrderItem order) async {
  //   try {
  //     final url = Uri.parse('$databaseUrl/orders.json?auth=$token');
  //     final response = await http.post(url, body: json.encode(order.toJson()));

  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }

  //     print(json.decode(response.body));

  //     return order.copyWith(id: json.decode(response.body));
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }
}
