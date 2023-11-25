import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/admin/personal_screen.dart';
import 'package:shopcaycanh/ui/auth/auth_manager.dart';

import '../orders/order_screen.dart';
import '../admin/user_product_screen.dart';
import '../personal/personal_screen.dart';

class AdminAppDrawer extends StatelessWidget {
  const AdminAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text(''),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Admin'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
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
      ),
    );
  }
}
