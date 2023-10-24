import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/payment.dart';
import '../../models/cart_item.dart';

class PaymentManager extends ChangeNotifier {
  List<Payment> _productSelected = [];

  int get productSelectedCount {
    return _productSelected.length;
  }

  List<Payment> get payments {
    return [..._productSelected];
  }

  void addPaymentInCart(List<CartItem> cartPayments, double total) {
    _productSelected.insert(
      0,
      Payment(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartPayments,
      ),
    );
    notifyListeners();
  }

  void addPaymentInProductDetail(List<CartItem> cartPayments, double total) {
    _productSelected.insert(
      0,
      Payment(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartPayments,
      ),
    );
    notifyListeners();
  }
}
