import 'dart:convert';
import '../models/order_item.dart';
import './firebase_service.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'package:flutter/services.dart';

class OrderService extends FirebaseService {
  // OrderService(): super();

  Future<List<OrderItem>> fetchOrders() async {
    final List<OrderItem> orders = [];
    try {
      print("authToken:");
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      print(authToken);
      final uid = (await AuthService().loadSavedAuthToken())!.userId;
      print("uid:");
      print(uid);
      print("ordersUrl:");
      final ordersUrl = Uri.parse(
          '$databaseUrl/orders.json?&orderBy="customerId"&equalTo="$uid"&auth=$authToken');
      print(ordersUrl);
      print("AAAAAAAAAAAA");
      await Clipboard.setData(ClipboardData(text: ordersUrl.toString()));
      print("response body:");
      final response = await http.get(ordersUrl);
      // final response = await http.get(Uri.parse('https://shopcaycanh-8b3ff-default-rtdb.firebaseio.com/orders/-NirY3Zw28H48usGcRgF'));
      print(response.body);
      print("ordersMap:");
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;
      print(ordersMap.values.last);

      if (response.statusCode != 200) {
        return orders;
      }

      ordersMap.forEach((id, order) {
        orders.add(OrderItem.fromJson({'id': id, ...order}));
      });
      print("orders:");
      print(orders);
      print("length:______________________________");
      print(orders.length);
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  Future<OrderItem?> addOrder(OrderItem order) async {
    try {
      final url = Uri.parse('$databaseUrl/orders.json?auth=$token');
      final response = await http.post(url, body: json.encode(order.toJson()));

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      print(json.decode(response.body));

      return order.copyWith(id: json.decode(response.body));
    } catch (error) {
      print(error);
      return null;
    }
  }
}
