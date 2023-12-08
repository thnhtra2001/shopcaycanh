import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:shopcaycanh/ui/orders/order_detail_screen.dart';
import 'package:shopcaycanh/ui/orders_admin/order_detail_screen.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import 'filter_item_card.dart';
import 'filter_admin_manager.dart';
import '../shared/app_drawer.dart';

class FilterOrderAdmin extends StatefulWidget {
  static const routeName = '/filter-order-admin';
  const FilterOrderAdmin({super.key});

  @override
  State<FilterOrderAdmin> createState() => _FilterOrderAdminState();
}

class _FilterOrderAdminState extends State<FilterOrderAdmin> {
  late Future<List<OrderItem>> _fetchOrders;
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<FilterOrderAdminManager>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    var orders = context.read<FilterOrderAdminManager>();
    // var orderFilter = orders.filterOrder(4, 2023);
    print("BBBBBBBBBBBBB");
    // print(orderFilter.length);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thống kê doanh thu theo quý'),
        ),
        drawer: const AdminAppDrawer(),
        body: SingleChildScrollView(
            child: FutureBuilder(
                future: _fetchOrders,
                builder: (contex, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // return Center(child: Text(snapshot.data!.first.amount.toString()),);
                    return SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length.toInt(),
                          itemBuilder: (context, index) {
                            // OrderItemCard(snapshot.data![index]);
                            return Container(
                              child: Column(children: [
                                ListTile(
                                  title: Text(
                                      'Hoa don ${index + 1}: ${snapshot.data![index].id}'),
                                  subtitle: Text(
                                      'Ngay: ${snapshot.data![index].dateTime.day}/${snapshot.data![index].dateTime.month}/${snapshot.data![index].dateTime.year} - Tong tien: ${snapshot.data![index].amount}'),
                                  trailing: Text('Tien goc: ${snapshot.data![index].amount0}'),
                                ),
                                const Divider()
                              ]),
                            );
                          },
                        ));
                  }
                  return const Center(child: CircularProgressIndicator());
                })
            //     child: ListView.builder(
            //   itemCount: orderFilter.length,
            //   itemBuilder: (context, index) {
            //     var i = orderFilter[index];
            //     return ListTile(
            //       title: Text('Hoa don ${i.id}'),
            //       subtitle: Text(
            //           'Ngay: ${i.dateTime.day}/${i.dateTime.month}/${i.dateTime.year} - Tong tien: ${i.amount}'),
            //     );
            //   },
            // )
            ));
  }
}
