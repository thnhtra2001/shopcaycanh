import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/payment_cart.dart';

class PaymentItemCart extends StatefulWidget {
  final PaymentItem payments;
  const PaymentItemCart(this.payments, {super.key});

  @override
  State<PaymentItemCart> createState() => _PaymentItemCartState();
}

class _PaymentItemCartState extends State<PaymentItemCart> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[buildPaymentSummary(), buildPaymentDetails()],
      ),
    );
  }

  Widget buildPaymentDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: min(widget.payments.productCount * 20.0 + 10, 100),
      child: ListView(
        children: widget.payments.products
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${prod.quantity}x\$${prod.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildPaymentSummary() {
    return ListTile(
      title: Text('\$${widget.payments.amount}'),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(widget.payments.dateTime),
      ),
    );
  }
}
