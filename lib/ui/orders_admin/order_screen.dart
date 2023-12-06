import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/orders/order_detail_screen.dart';
import 'package:shopcaycanh/ui/orders_admin/order_detail_screen.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import 'order_item_card.dart';
import 'order_manager.dart';
import '../shared/app_drawer.dart';

class OrdersScreenAdmin extends StatefulWidget {
  static const routeName = '/admin-order';
  const OrdersScreenAdmin({super.key});

  @override
  State<OrdersScreenAdmin> createState() => _OrdersScreenAdminState();
}

class _OrdersScreenAdminState extends State<OrdersScreenAdmin> {
  late Future<void> _fetchOrders = Future(() => null);
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<OrdersManagerAdmin>().fetchOrders();
    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
    // context.read<OrdersManagerAdmin>().updateList();
  }
  Future<void> _refreshProduct(BuildContext context) async {
    await context.read<OrdersManagerAdmin>().fetchOrders();
  }
  @override
  Widget build(BuildContext context) {
    // context.read<OrdersManagerAdmin>().updateList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Xác nhận đơn hàng'),
        ),
        drawer: const AdminAppDrawer(),
        body: FutureBuilder(
            future: _fetchOrders,
            builder: (contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<OrdersManagerAdmin>(
                  builder: (ctx, ordersManager, child) {
                    return ListView.builder(
                        itemCount: ordersManager.orders0Count,
                        itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailScreenAdmin(
                                            ordersManager.orders0[i])),
                              );
                            },
                            child: 
                            RefreshIndicator(
                  onRefresh: () => _refreshProduct(context),
                  child: Column(
                    children: [
                            OrderItemCard(ordersManager.orders0[i])
                      // SizedBox(
                          // height: 700,
                          // child: buildUserProductListView(productsManager)),
                    ],
                  )
                  // buildTotalProduct(productsManager),
                  // SizedBox(child: buildUserProductListView(productsManager)),
                  ),
                            // OrderItemCard(ordersManager.orders0[i])
                            ));
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
