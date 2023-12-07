import 'package:flutter/material.dart';
import '../../models/orders_admin_product.dart';

class AdminListTile extends StatelessWidget {
  final OrdersAdminProduct data;

  const AdminListTile(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title),
      subtitle: Text(
        '${data.price}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
