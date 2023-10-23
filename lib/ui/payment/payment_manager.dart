import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/product.dart';

class Payment extends ChangeNotifier {
  List<Product> _productSelected = [];

  int get productSelected {
    return _productSelected.length;
  }

  List<Product> get product {
    return [..._productSelected];
  }

  void addProductSelected(Product productSelected) {
    this._productSelected = _productSelected;
    notifyListeners();
  }
}
