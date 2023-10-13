import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/products_service.dart';

import '../../models/product.dart';

import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];

  final ProductsService _productsService = ProductsService();
  // // set authToken(AuthToken? authToken) {
  // //   _productsService.authToken = authToken;
  // // }
  //   final ProductsService _productsService;
  // ProductsManager([AuthToken? authToken])
  //     : _productsService = ProductsService(authToken);
  // set authToken(AuthToken? authToken) {
  //   _productsService.authToken = authToken;
  // }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((proItem) => proItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProducts() async {
    _items = await _productsService.fetchProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _items[index] == product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}
