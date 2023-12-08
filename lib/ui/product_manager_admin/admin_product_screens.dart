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
    final orders = context.read<AdminProductsManager>();
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
                // buildDetailProduct(orders),
              ],
            );
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
