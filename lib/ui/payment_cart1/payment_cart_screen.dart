import 'package:flutter/material.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/payment_cart/payment_cart_screen.dart';
import 'package:shopcaycanh/ui/payment_cart1/payments_selectiton.dart';
import '../../services/user_service.dart';
import '../screens.dart';
import 'package:provider/provider.dart';

import '../cart/cart_manager.dart';
import '../payment_cart1/payment_cart_item.dart';

import '../payment_cart/payment_cart_manager.dart';

import '../orders/order_manager.dart';
import '../widget/custom_rich_text.dart';

class PaymentCartScreen1 extends StatefulWidget {
  static const routeName = '/payment-cart1';

  const PaymentCartScreen1({super.key});

  @override
  State<PaymentCartScreen1> createState() => _PaymentCartScreen1State();
}

class _PaymentCartScreen1State extends State<PaymentCartScreen1> {
  late Future<Map<String, dynamic>> _futureFetchUserInformation;
  @override
  void initState() {
    super.initState();
    _futureFetchUserInformation = UserService().fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang thanh toán'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    'Hình thức thanh toán:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  )),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 5),
                child: PaymentSelectionDropdown(),
              ),
            ],
          ),
          const Divider(),
          FutureBuilder<Map<String, dynamic>>(
            future: _futureFetchUserInformation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Container(
                      alignment: Alignment.center,
                      // width: deviceSize.width * 0.9,
                      child: Column(
                        children: [
                          paymentAddress(snapshot.data!['address']),
                          inforUser(snapshot.data!['name']),
                        ],
                      )),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          // buildCartSummary(cart, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart),
          ),
          buildProductTotal(cart)
        ],
      ),
    );
  }
  Widget paymentAddress(data) {
    return Column(children: [
      Container(
        height: 40,
        alignment: Alignment.centerLeft,
        child: const Text('Địa chỉ:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 8),
          child: TextFormField(
            initialValue: data,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.red, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                prefixIcon: Icon(Icons.location_city_outlined)),
            style: const TextStyle(fontSize: 18),
          ))
    ]);
  }
    Widget inforUser(data) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: const Text('Người mua:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          color: Colors.white,
          height: 90,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    )),
                child: Image.asset(
                  'assets/Images/user-icon.png',
                  color: Colors.black12,
                  height: 23,
                  width: 23,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                data ?? '',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }
  Widget buildProductTotal(CartManager cart) {
    return Container(
      height: 100,
      child: Container(
        child: Column(
          children: [
            CustomRowText(
              title: 'Tổng số lượng',
              value: '${cart.totalQuantity}',
            ),
                        CustomRowText(
              title: 'Tổng giá',
              value: '${cart.totalAmount}',
            )
          ],
          // children: widget.payment.products
          //     .map((prod) => Column(
          //           children: [
          //             CustomRowText(
          //               title: '${prod.quantity}',
          //               value: '${prod.price}',
          //             ),
          //           ],
          //         ))
          //     .toList(),
        ),
      ),
    );
  }
}
