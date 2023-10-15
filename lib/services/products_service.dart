import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopcaycanh/services/auth_service.dart';

import '../models/product.dart';

import '../models/auth_token.dart';

import 'firebase_service.dart';

class ProductsService extends FirebaseService {
  // ProductsService() : super();
  ProductsService([AuthToken? authToken]) : super(authToken);
  Future<List<Product>> fetchProducts() async {
    final List<Product> products = [];
    try {
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      final productUrl =
          Uri.parse('$databaseUrl/products.json?auth=$authToken');
      final response = await http.get(productUrl);
      final productsMap = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return products;
      }
      productsMap.forEach((id, product) {
        products.add(Product.fromJson({
          'id': id,
          ...product,
        }));
      });
      return products;
    } catch (error) {
      print(error);
      return products;
    }
  }

  Future<Product?> addProduct(Product product) async {
    try {
      final url = Uri.parse('$databaseUrl/products.json?auth=$token');
      final response =
          await http.post(url, body: json.encode(product.toJson()));
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return product.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

// products.forEach((id, element) => print(element));
  Future<bool> updateProduct(Product product) async {
    try {
      final url =
          Uri.parse('$databaseUrl/products/${product.id}.json?auth=$token');
      final response =
          await http.patch(url, body: json.encode(product.toJson()));

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/products/$id.json?auth=$token');
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
