import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';
import '../../models/orders_admin_product.dart';
import 'admin_list_tile.dart';
import 'admin_product_manager.dart';

class AdminProductManagerScreens extends StatefulWidget {
  static const routeName = '/product-manager';
  const AdminProductManagerScreens({super.key});

  @override
  State<AdminProductManagerScreens> createState() =>
      AdminProductManagerScreensState();
}

class AdminProductManagerScreensState
    extends State<AdminProductManagerScreens> {
  late Future<Map<String, double>> _fetchOrders;
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<AdminProductsManager>().fetchOrders();
    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
  }

  @override
  Widget build(BuildContext context) {
    print("tea dep chaiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
    // final orders = context.read<AdminProductsManager>();
    // final orders1 = orders.productTypeAdmin;
    // print('-----------------------------');
    // print(orders1.length);
    // final data = orders.data;
    // print("dataaaaaaaaaaaaaa");
    // print(data.length);
    // Map<String, OrdersAdminProduct> data1 = {};
    // for (var order in orders1) {
    //   for (var product in order.products) {
    //     if (data1.containsKey(product.title)) {
    //       data1.update(
    //           product.title,
    //           (value) =>
    //               value.copyWith(quantity: value.quantity + product.quantity));
    //     } else {
    //       data1.putIfAbsent(
    //           product.title,
    //           () => OrdersAdminProduct(
    //               title: product.title,
    //               quantity: product.quantity,
    //               price: product.price,
    //               price0: product.price0,
    //               type: product.type));
    //     }
    //   }
    // }
    // print("________________________________");
    // print(data1.length);
    // print(data1.values.last.title);
    // print(data1.values.last.quantity);
    // final Map<String, double> dataMap = {"aaa": 0, "bbb":0};
    // orders1.forEach((key, value) =>
    //     dataMap.putIfAbsent(key, () => value.quantity.toDouble()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê sản phẩm'),
      ),
      drawer: AdminAppDrawer(),
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: _fetchOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data! == null) {
              return Center(
                child: Text("Chưa có đơn hàng nào thành công!"),
              );
            } else {
              return Column(
                children: [
                  Container(
                    child: Center(
                      child: PieChart(
                        dataMap: snapshot.data!,
                        chartRadius: MediaQuery.of(context).size.width / 1.5,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.bottom,
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //     child: Column(
                  //   children: [
                  //     ListTile(
                  //       title: Text(snapshot.data!.length.toString()),
                  //     ),
                  //   ],
                  // )
                  //     // Center(child: Text(snapshot.data!.values.toString())),
                  //     ),
                  // DataTable(
                  //   columns: const <DataColumn>[
                  //     DataColumn(
                  //       label: Expanded(
                  //         child: Text(
                  //           'San pham',
                  //           style: TextStyle(fontStyle: FontStyle.italic),
                  //         ),
                  //       ),
                  //     ),
                  //     DataColumn(
                  //       label: Expanded(
                  //         child: Text(
                  //           'So luong',
                  //           style: TextStyle(fontStyle: FontStyle.italic),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  //   rows: <DataRow>[
                  //     DataRow(
                  //       cells: <DataCell>[
                  //         DataCell(Text(snapshot.data!.keys.toString())),
                  //         DataCell(Text(snapshot.data!.values.toString())),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // Container(
                  //   child:
                  //   Column(
                  //     children: [
                  //       ListTile(
                  //         title:  Text(snapshot.data!.keys.toString()),
                  //         leading: Text(snapshot.data!.values.toString()),
                  //       ),
                  //     ],
                  //   )
                  //       // Center(child: Text(snapshot.data!.values.toString())),
                  // )
                  SizedBox(
                      height: 500,
                      child: Container(
                          child: ListView.builder(
                        itemCount: snapshot.data!.length.toInt(),
                        itemBuilder: (context, index) {
                          List<String> key = snapshot.data!.keys.toList();
                          List<double> value = snapshot.data!.values.toList();
                          return Container(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    key[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Số lượng: ${value[index]}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                const Divider()
                              ],
                            ),
                          );
                        },
                      )))
                  // buildDetailProduct(orders),
                ],
              );
            }
          } else
            return Center(
              child: SingleChildScrollView(),
            );
        },
      )),
    );
  }

  // Widget buildDetailProduct(AdminProductsManager data) {
  //   return Consumer<AdminProductsManager>(
  //     builder: (context, adminProductsManager, child) {
  //       return ListView.builder(
  //           itemCount: adminProductsManager.orders1Count,
  //           itemBuilder: (context, index) => Column(
  //                 children: [AdminListTile(adminProductsManager.data[index])],
  //               ));
  //     },
  //   );
  // }
}
