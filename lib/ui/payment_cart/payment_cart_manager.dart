import 'package:flutter/widgets.dart';
import 'package:shopcaycanh/models/cart_item.dart';

import '../../models/payment_cart.dart';

import 'package:flutter/foundation.dart';

class PaymentsManager with ChangeNotifier {
  final List<PaymentItem> _payments = [];

  int get paymentCount {
    return _payments.length;
  }

  List<PaymentItem> get payments {
    return [..._payments];
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    _payments.insert(
      0,
      PaymentItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
