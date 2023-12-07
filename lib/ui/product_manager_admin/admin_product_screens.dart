import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';
import '../../models/orders_admin_product.dart';
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
  late Future<void> _fetchOrders = Future(() => null);
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<AdminProductsManager>().fetchOrders();
    // print("-------------------------------");
    // print(_fetchOrders);
    // print('-----------------------------');
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<AdminProductsManager>();
    final orders1 = orders.orders1;
    Map<String, OrdersAdminProduct> data1 = {};
    for (var order in orders1) {
      for (var product in order.products) {
        if (data1.containsKey(product.productId)) {
          data1.update(
              product.productId!,
              (value) =>
                  value.copyWith(quantity: value.quantity + product.quantity));
        } else {
          data1.putIfAbsent(
              product.productId!,
              () => OrdersAdminProduct(
                  title: product.title,
                  quantity: product.quantity,
                  price: product.price,
                  price0: product.price0,
                  type: product.type));
        }
      }
    }
    // print("________________________________");
    // print(data1.length);
    // print(data1.values.last.title);
    // print(data1.values.last.quantity);

    Map<String, double> dataMap = {
      "Đã đặt": 5,
      "Đang vận chuyển": 5,
      "Đã hủy": 5
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê san pham'),
      ),
      drawer: AdminAppDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Center(
              child: PieChart(
                dataMap: dataMap,
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
          // DataTable(
          //   columns: const <DataColumn>[
          //     DataColumn(
          //       label: Expanded(
          //         child: Text(
          //           'San pham ban nhieu nhat',
          //           style: TextStyle(fontStyle: FontStyle.italic),
          //         ),
          //       ),
          //     ),
          //     DataColumn(
          //       label: Expanded(
          //         child: Text(
          //           'San pham co doanh thu cao nhat',
          //           style: TextStyle(fontStyle: FontStyle.italic),
          //         ),
          //       ),
          //     ),
          //     DataColumn(
          //       label: Expanded(
          //         child: Text(
          //           'San pham ban thap nhat',
          //           style: TextStyle(fontStyle: FontStyle.italic),
          //         ),
          //       ),
          //     ),
          //   ],
          //   rows: <DataRow>[
          //     DataRow(
          //       cells: <DataCell>[
          //         // DataCell(Text(orders1.toString())),
          //         // DataCell(Text(orders2.toString())),
          //         // DataCell(Text(orders3.toString())),
          //       ],
          //     ),
          //   ],
          // )
        ],
      )),
    );
  }
}
