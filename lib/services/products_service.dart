import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopcaycanh/services/auth_service.dart';

import '../models/product.dart';

import '../models/auth_token.dart';

import 'firebase_service.dart';

class ProductsService extends FirebaseService {
  ProductsService() : super();
  Future<List<Product>> fetchProducts([bool filterByUser = false]) async {
    final List<Product> products = [];
    try {
      final filters =
          filterByUser ? 'orderby="creatorId"&equalTo="$userId"' : '';
      final authToken = (await AuthService().loadSavedAuthToken())!.token;
      final productUrl =
          Uri.parse('$databaseUrl/products.json?auth=$authToken');
      final response = await http.get(productUrl);
      final productsMap = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return products;
      }
      final userFavoriteUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');

      final userFavoritesResponse = await http.get(userFavoriteUrl);

      final userFavoritesMap = json.decode(userFavoritesResponse.body);
      productsMap.forEach((id, product) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[id] ?? false);
        products.add(Product.fromJson({ 
          'id': id,
          ...product,
        }).copyWith(isFavorite: isFavorite));
      });
      print("KKKKKKKKKKKKKK");
      print(products.length);
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

  Future<bool> saveFavoriteStatus(Product product) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${product.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          product.isFavorite,
        ),
      );
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
