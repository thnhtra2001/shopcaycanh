import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/orders3_admin/order_manager.dart';
import 'package:shopcaycanh/ui/pie_chart/pie_chart_manager.dart';
import 'package:shopcaycanh/ui/shared/admin_app_drawer.dart';

import '../orders1_admin/order_manager.dart';

class PieChartScreen extends StatefulWidget {
  static const routeName = '/pieChart';

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  late Future<Map<String, double>> _fetchOrders;
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<PieChartManager>().fetchOrdersAll();

    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
    // context.read<OrdersManagerAdmin3>().updateList();
  }

  @override
  Widget build(BuildContext context) {
    final pie = context.read<PieChartManager>();
    final dataMap = pie.data2;
    print(dataMap);
    // Map<String, double> dataMap = {
    //   "Đã đặt": orders1,
    //   "Đang vận chuyển": orders2,
    //   "Đã hủy": orders3
    // };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê đơn hàng'),
      ),
      drawer: const AdminAppDrawer(),
      body: SingleChildScrollView(
        // child: Center(child: Text(dataMap.length.toString()),),
          child: FutureBuilder(
        future: _fetchOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                // Center(
                //   child: Text(snapshot.data!.length.toString()),
                // ),
                Center(
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
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
      ),
    );
  }
}
