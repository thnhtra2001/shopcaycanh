import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/auth/auth_manager.dart';
import 'package:shopcaycanh/ui/chatbot_rasa_ai/chatbot_rasa.dart';
import 'package:shopcaycanh/ui/chatbot_rasa_ai/chatbot_rasa_ai1.dart';

import '../cart/cart_manager.dart';
import '../cart/cart_screen.dart';
import '../orders/order_screen.dart';
import '../admin/user_product_screen.dart';
import '../personal/personal_screen.dart';
import '../products/top_right_badge.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text(''),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Trang cá nhân'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PersonalScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          // Consumer<CartManager>(
          //   builder: (context, cartManager, child) {
          //     return TopRightBadge(
          //       data: cartManager.productCount,
          //       child: Row(
          //         children: [
          //           IconButton(
          //               onPressed: () {
          //                 Navigator.of(context).pushNamed(CartScreen.routeName);
          //               },
          //               icon: const Icon(Icons.shopping_cart)),

          //           Text('Gio hang')
          //         ],
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Giỏ hàng'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Đơn đã đặt'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.message_rounded),
              title: const Text('Chatbot'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ChatbotScreen1.routeName);
              }),
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
