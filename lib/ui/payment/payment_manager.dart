// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import '../../models/product.dart';

// class PaymentManager extends ChangeNotifier {
//   Map<String, Product> _productSelected = {};

//   int get productSelected {
//     return _productSelected.length;
//   }

//   List<Product> get productsList {
//     return _productSelected.values.toList();
//   }

//   void setProductSelected(Product product) async {
//     this._productSelected = _productSelected;
//     notifyListeners();
//   }

//   void addItem(Product product) {
//     if (_productSelected.containsKey(product.id)) {
//       _productSelected.update(
//           product.id!,
//           (existingCarItem) => existingCarItem.copyWith(
//                 quantity: existingCarItem.quantity + 1,
//               ));
//     } else {
//       _productSelected.putIfAbsent(
//           product.id!,
//           () => Product(
//               id: 'c${DateTime.now().toIso8601String()}',
//               title: product.title,
//               quantity: 1,
//               price: product.price,
//               description: product.description,));
//     }
//     notifyListeners();
//   }
// }
