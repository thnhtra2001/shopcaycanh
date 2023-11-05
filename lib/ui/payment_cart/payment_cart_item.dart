import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/payment_cart/payments_selectiton.dart';
import 'package:shopcaycanh/ui/widget/custom_rich_text.dart';

import '../../models/payment_cart.dart';
import '../../services/user_service.dart';

class PaymentItemCard extends StatefulWidget {
  final PaymentItem payment;
  const PaymentItemCard(this.payment, {super.key});
  @override
  State<PaymentItemCard> createState() => _PaymentItemCardState();
}

class _PaymentItemCardState extends State<PaymentItemCard> {
  late Future<Map<String, dynamic>> _futureFetchUserInformation;
  @override
  void initState() {
    super.initState();
    _futureFetchUserInformation = UserService().fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      child: Column(
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
          // buildOrderSummary(),
          buildPaymentDetails(),
          buildProductTotal(),
          SizedBox(height: 10),
          paymentNow(),
          const SizedBox(
            height: 20,
          ),
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

  Widget buildPaymentDetails() {
    return Container(
      height: 250,
      child: Container(
        child: Column(
          children: widget.payment.products
              .map((prod) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(prod.imageUrl),
                      ),
                      title: Text(prod.title),
                      subtitle: Text('Tổng: ${(prod.price * prod.quantity)}'),
                      trailing: Text('SL: ${prod.quantity}'),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  // Widget buildOrderSummary() {
  //   return ListTile(
  //     title: Text('${widget.payment.amount}'),
  //     subtitle: Text(
  //       DateFormat('dd/MM/yyyy hh:mm').format(widget.payment.dateTime),
  //     ),
  //   );
  // }
  Widget paymentNow() {
    return Container(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          context.read<OrdersManager>().addOrder(
            OrderItem(products: context.read<PaymentItem>().products, amount: context.read<PaymentItem>().amount, dateTime: context.read<PaymentItem>().dateTime)
          );
          Navigator.of(context).pushNamed(OrdersScreen.routeName);
          print('AAAAAAAAAAAAAAAAAAAAAAa');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: const Text('Thanh toán',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  Widget buildProductTotal() {
    return Container(
      height: 100,
      child: Container(
        child: Column(
          children: [
            CustomRowText(
              title: 'Tổng số lượng',
              value: '${widget.payment.totalQuantity}',
            ),
                        CustomRowText(
              title: 'Tổng giá',
              value: '${widget.payment.amount}',
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
