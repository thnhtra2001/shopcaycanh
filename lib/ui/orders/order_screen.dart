import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/orders/order_detail_screen.dart';

import 'order_item_card.dart';
import 'order_manager.dart';
import '../shared/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn đã đặt'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<OrdersManager>(
        builder: (ctx, ordersManager, child) {
          return ListView.builder(
              itemCount: ordersManager.ordersCount,
              itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailScreen(ordersManager.orders[i])),
                      );
                    },
                    child: OrderItemCard(ordersManager.orders[i]),
                  ));
        },
      ),
    );
  }
}
