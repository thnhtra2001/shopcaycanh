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
                const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chú thích:"),
                      Text("0: Đơn hàng đang chờ xác nhận"),
                      Text("1: Đơn hàng đã hủy"),
                      Text("2: Đơn hàng đang vận chuyển"),
                      Text("3: Đơn hàng đã đặt"),
                    ]),
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
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
