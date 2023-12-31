import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/admin/personal_screen.dart';
import 'package:shopcaycanh/ui/admin_user/admin_user_screen.dart';
import 'package:shopcaycanh/ui/auth/auth_manager.dart';
import 'package:shopcaycanh/ui/filter_order_admin/filter_order_admin.dart';
import 'package:shopcaycanh/ui/orders_admin/order_screen.dart';
import 'package:shopcaycanh/ui/pie_chart/pie_chart.dart';

import '../orders/order_screen.dart';
import '../admin/user_product_screen.dart';
import '../orders1_admin/order_screen.dart';
import '../orders2_admin/order_screen.dart';
import '../orders3_admin/order_screen.dart';
import '../personal/personal_screen.dart';
import '../product_manager_admin/admin_product_screens.dart';

class AdminAppDrawer extends StatelessWidget {
  const AdminAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Admin'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Trang cá nhân'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PersonalScreenAdmin.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.child_care),
            title: const Text('Quản lý người dùng'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AdminUserScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text('Xác nhận đơn hàng'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.plus_one),
            title: const Text('Đơn đã đặt'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin1.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.local_shipping_outlined),
            title: const Text('Đơn đang giao'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin2.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.cancel_presentation),
            title: const Text('Đơn đã hủy'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin3.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.pie_chart),
            title: const Text('Thống kê đơn hàng'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PieChartScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_note),
            title: const Text('Thống kê sản phẩm'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AdminProductManagerScreens.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.headphones),
            title: const Text('Thống kê doanh thu'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterOrderAdmin.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Đăng xuất'),
            onTap: () {
              // Navigator.of(context)
              //   ..pop()
              //   ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          )
        ],
      ),)
    );
  }
}
