import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/orders/order_detail_screen.dart';
import 'package:shopcaycanh/ui/orders_admin/order_detail_screen.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import 'order_item_card.dart';
import 'order_manager.dart';
import '../shared/app_drawer.dart';

class OrdersScreenAdmin2 extends StatefulWidget {
  static const routeName = '/admin-order2';
  const OrdersScreenAdmin2({super.key});

  @override
  State<OrdersScreenAdmin2> createState() => _OrdersScreenAdmin2State();
}

class _OrdersScreenAdmin2State extends State<OrdersScreenAdmin2> {
  late Future<void> _fetchOrders = Future(() => null);
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<OrdersManagerAdmin2>().fetchOrders();
    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
    // context.read<OrdersManagerAdmin2>().updateList();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<OrdersManagerAdmin2>().updateList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đơn đang giao'),
        ),
        drawer: const AdminAppDrawer(),
        body: FutureBuilder(
            future: _fetchOrders,
            builder: (contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<OrdersManagerAdmin2>(
                  builder: (ctx, ordersManager, child) {
                    return ListView.builder(
                        itemCount: ordersManager.orders2Count,
                        itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailScreenAdmin(
                                            ordersManager.orders2[i])),
                              );
                            },
                            child: OrderItemCard(ordersManager.orders2[i])));
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
