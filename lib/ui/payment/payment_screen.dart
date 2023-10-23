import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/payment/payment_manager.dart';
import '../../models/product.dart';
import '../../services/user_service.dart';

import 'package:shopcaycanh/ui/cart/cart_manager.dart';
import 'package:after_layout/after_layout.dart';

class PaymentDetailScreen extends StatefulWidget {
  static const routeName = '/payment-detail';
  const PaymentDetailScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen>
    with AfterLayoutMixin {
  late Future<Map<String, dynamic>> _futureFetchUserInformation;
  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    super.initState();
    _futureFetchUserInformation = UserService().fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> product;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang thanh toán'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureFetchUserInformation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Container(
                  alignment: Alignment.center,
                  width: deviceSize.width * 0.9,
                  child: Column(
                    children: [
                      paymentAddress(),
                      inforUser(snapshot.data!['name']),
                      productDetails(),
                    ],
                  )),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget paymentAddress() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Dia chi'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      maxLines: 1,
    );
  }

  Widget inforUser(data) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      color: Colors.white,
      height: 100,
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
          ),
        ],
      ),
    );
  }

  Widget productDetails() {
    return Container(
        padding: const EdgeInsets.only(left: 20),
        color: Colors.white,
        height: 100,
        child: Row(children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  )),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'))),
          const SizedBox(width: 7),
          Text(
            'AAAAA' ?? '',
          ),
        ]));
  }
}
