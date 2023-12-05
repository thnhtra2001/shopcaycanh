import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/orders/order_detail_screen.dart';
import 'package:shopcaycanh/ui/orders_admin/order_detail_screen.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import 'order_item_card.dart';
import 'order_manager.dart';
import '../shared/app_drawer.dart';

class OrdersScreenAdmin3 extends StatefulWidget {
  static const routeName = '/admin-order3';
  const OrdersScreenAdmin3({super.key});

  @override
  State<OrdersScreenAdmin3> createState() => _OrdersScreenAdmin3State();
}

class _OrdersScreenAdmin3State extends State<OrdersScreenAdmin3> {
  late Future<void> _fetchOrders = Future(() => null);
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<OrdersManagerAdmin3>().fetchOrders();
    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
    context.read<OrdersManagerAdmin3>().updateList();
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrdersManagerAdmin3>().updateList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đơn đã hủy'),
        ),
        drawer: const AdminAppDrawer(),
        body: FutureBuilder(
            future: _fetchOrders,
            builder: (contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<OrdersManagerAdmin3>(
                  builder: (ctx, ordersManager, child) {
                    return ListView.builder(
                        itemCount: ordersManager.orders3Count,
                        itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailScreenAdmin(
                                            ordersManager.orders3[i])),
                              );
                            },
                            child: OrderItemCard(ordersManager.orders3[i])));
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
