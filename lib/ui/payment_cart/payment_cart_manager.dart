
import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/models/payment_cart.dart';


import 'package:flutter/foundation.dart';

import '../../models/product.dart';

class PaymentsManager with ChangeNotifier {
  final List<PaymentItem> _payments = [];
  int get paymentCount {
    return _payments.length;
  }

  List<PaymentItem> get payment {
    return [..._payments];
  }
  void addPayment(List<CartItem> cartProducts, double total, int totalQuantity) async {
    _payments.insert(
      0,
      PaymentItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
        totalQuantity: totalQuantity,
      ),
    );
    notifyListeners();
  }
}