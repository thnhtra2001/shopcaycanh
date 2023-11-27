import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/services/products_service.dart';

import '../../models/product.dart';

import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  final ProductsService _productsService = ProductsService();
  List<Product> _items = [];
  List<Product> _display_product = [];

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
    // print(_items.length);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    print("tra index: ");
    print(index);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;

    if (!await _productsService.saveFavoriteStatus(product)) {
      product.isFavorite = savedStatus;
    }
  }

  ///////////////////////////////////////
  List<Product> updateList(String value) {
    _display_product = _items
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    return _display_product;
  }

  int get display_product_Count {
    return _display_product.length;
  }

  List<Product> get display_product {
    return [..._display_product];
  }
}
