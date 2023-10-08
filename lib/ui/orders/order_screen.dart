import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/shared/app_drawer.dart';

import 'order_item_card.dart';
import 'order_manager.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('building orders');
    final ordersManager = OrdersManager();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: Consumer(
          builder: (context, orderManage, child) {
            return ListView.builder(
              itemCount: ordersManager.orderCount,
              itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
            );
          },
        ));
  }
}
