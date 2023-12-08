import 'package:flutter/material.dart';
import '../../models/orders_admin_product.dart';

class AdminListTile extends StatelessWidget {
  final String title;
  final double quantity;

  const AdminListTile( {
    super.key, required this.title, required this.quantity
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        '${quantity}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
