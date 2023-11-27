import 'package:flutter/material.dart';
import 'package:shopcaycanh/models/cart_item1.dart';
import 'package:shopcaycanh/ui/orders/order_item_card.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/payment_cart1/payment_cart_screen.dart';
import 'package:shopcaycanh/ui/shared/app_drawer.dart';
import '../screens.dart';
import 'package:provider/provider.dart';

import 'cart_manager.dart';
import 'cart_item_card.dart';
import '../orders/order_manager.dart';
import 'cart_manager1.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<void> _fetchCarts = Future(() => null);

  @override
  void initState() {
    super.initState();
    _fetchCarts = context.read<CartManager1>().fetchCarts();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager1>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Giỏ hàng'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: _fetchCarts,
            builder: (contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    buildCartSummary(cart, context),
                    Expanded(
                      child: Consumer<CartManager1>(
                        builder: (ctx, cartManager1, child) {
                          return ListView.builder(
                              itemCount: cartManager1.cartCount,
                              itemBuilder: (ctx, i) => GestureDetector(
                                    // onTap: () {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => OrderDetailScreen(
                                    //             cartManager1.orders[i])),
                                    //   );
                                    // },
                                    child: Column(
                                      children: [
                                        CartItemCard(
                                            productId: cartManager1
                                                .cartItem[i].productId
                                                .toString(),
                                            cardItem: cartManager1.cartItem[i]),
                                      ],
                                    ),
                                    // buildCartDetails(cartManager1.cartItem[i])
                                    // Center(child: Text(cartManager1.cartItem[i].productId.toString(),))
                                  ));
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            })
        // FutureBuilder(
        //   future: _fetchCarts,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return Column(
        //         children: <Widget>[
        //           // buildCartSummary(cart, context),
        //           const SizedBox(height: 10),
        //           Expanded(
        //             child: buildCartDetails(cart),
        //           )
        //         ],
        //       );
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // )
        );
  }

  // Widget buildCartDetails(CartManager1 cart) {
  //   return ListView(
  //     children: cart.cartItem
  //         .map(
  //           (entry) => CartItemCard(
  //             productId: cart.cartItem.first.productId.toString(),
  //             cardItem: cart.cartItem.first,
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  Widget buildCartSummary(CartManager1 cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Tổng cộng',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '${cart.totalAmount.toStringAsFixed(1)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            TextButton(
              onPressed: cart.totalAmount <= 0
                  ? null
                  : () {
                      cart.clear();
                      // Navigator.of(context)
                      //     .pushNamed(PaymentCartScreen1.routeName);
                    },
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
              child: const Text('Đặt hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
