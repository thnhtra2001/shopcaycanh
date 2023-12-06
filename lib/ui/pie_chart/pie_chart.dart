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
  late Future<void> _fetchOrders = Future(() => null);
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<PieChartManager>().fetchOrders1();
    _fetchOrders = context.read<PieChartManager>().fetchOrders2();
    _fetchOrders = context.read<PieChartManager>().fetchOrders3();

    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
    // context.read<OrdersManagerAdmin3>().updateList();
  }

  @override
  Widget build(BuildContext context) {
    late final orders1 =
        context.read<PieChartManager>().orders1Count.toDouble();
    late final orders2 =
        context.read<PieChartManager>().orders2Count.toDouble();
    late final orders3 =
        context.read<PieChartManager>().orders3Count.toDouble();
    print("Da dat");
    print(orders1);
    print("Dang giao");
    print(orders2);
    print("Da huy");
    print(orders3);
    Map<String, double> dataMap = {
      "Đã đặt": orders1,
      "Đang vận chuyển": orders2,
      "Đã hủy": orders3
    };
    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    print(orders1);
    // final orders1 = context.read<OrdersManagerAdmin1>().orders1Count;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê đơn hàng'),
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
          DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Đơn đã đặt',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Đơn đang vận chuyển',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Đơn đã hủy',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(orders1.toString())),
                  DataCell(Text(orders2.toString())),
                  DataCell(Text(orders3.toString())),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
