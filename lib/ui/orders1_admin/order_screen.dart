import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/orders/order_detail_screen.dart';
import 'package:shopcaycanh/ui/orders_admin/order_detail_screen.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import 'order_item_card.dart';
import 'order_manager.dart';
import '../shared/app_drawer.dart';

class OrdersScreenAdmin1 extends StatefulWidget {
  static const routeName = '/admin-order1';
  const OrdersScreenAdmin1({super.key});

  @override
  State<OrdersScreenAdmin1> createState() => _OrdersScreenAdmin1State();
}

class _OrdersScreenAdmin1State extends State<OrdersScreenAdmin1> {
  late Future<void> _fetchOrders = Future(() => null);
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<OrdersManagerAdmin1>().fetchOrders();
    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
    // context.read<OrdersManagerAdmin1>().updateList();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<OrdersManagerAdmin1>().updateList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đơn đã đặt thành công'),
        ),
        drawer: const AdminAppDrawer(),
        body: FutureBuilder(
            future: _fetchOrders,
            builder: (contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<OrdersManagerAdmin1>(
                  builder: (ctx, ordersManager, child) {
                    return ListView.builder(
                        itemCount: ordersManager.orders1Count,
                        itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailScreenAdmin(
                                            ordersManager.orders1[i])),
                              );
                            },
                            child: OrderItemCard(ordersManager.orders1[i])));
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
