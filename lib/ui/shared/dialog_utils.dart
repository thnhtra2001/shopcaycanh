import 'package:flutter/material.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Thông báo'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Không'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('Có'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    ),
  );
}
Future<bool?> showConfirmDialogZalo(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Thông báo'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Có lỗi xảy ra!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
Future<void> showMyDialog(BuildContext context, CartManager cart) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thông báo'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Đặt hàng thành công!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
              cart.clear();
            },
          ),
        ],
      );
    },
  );
}