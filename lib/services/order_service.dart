import 'dart:convert';
import '../models/order_item.dart';
import './firebase_service.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import 'package:flutter/services.dart';

class OrderService extends FirebaseService {
  OrderService() : super();

  Future<List<OrderItem>> fetchOrders() async {
    late List<OrderItem> orders = [];
    try {
      print("authToken:");
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      print(authToken);
      final uid = (await AuthService().loadSavedAuthToken())!.userId;
      print("uid:");
      print(uid);
      print("ordersUrl:");
      final ordersUrl = Uri.parse(
          '$databaseUrl/orders.json?orderBy="customerId"&equalTo="$uid"&auth=$authToken');
      print(ordersUrl);
      print("AAAAAAAAAAAA");
      await Clipboard.setData(ClipboardData(text: ordersUrl.toString()));
      print("response:");
      final response = await http.get(ordersUrl);
      // final response = await http.get(Uri.parse('https://shopcaycanh-8b3ff-default-rtdb.firebaseio.com/orders/-NirY3Zw28H48usGcRgF'));
      print(response);
      print("ordersMap key:");
      final ordersMap = json.decode(response.body) as Map<dynamic, dynamic>;
      print(ordersMap.keys.length);

      // if (response.statusCode != 200) {
      //   return orders;
      // }else {
      //   print("Some thing went wrong! Co loi xay ra.....");
      // }
      print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }
      print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
      // ordersMap.values.map((e) => orders.add(e));
      ordersMap.forEach((id, order) {
        orders.add(OrderItem.fromJson({'id': id, ...order}));
      });
      // print(ordersMap.values);
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
