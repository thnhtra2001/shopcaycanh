import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/cart_item.dart';
// import 'package:shopcaycanh/ui/payment/payment_manager.dart';
import '../../models/payment.dart';
import '../../models/product.dart';
import '../../services/user_service.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment-detail';
  const PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Future<Map<String, dynamic>> _futureFetchUserInformation;

  @override
  void initState() {
    super.initState();
    _futureFetchUserInformation = UserService().fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    print(args.price);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang thanh toán'),
      ),
      body: Column(
        children: [
          FutureBuilder<Map<String, dynamic>>(
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
                        ],
                      )),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Column(
            children: [productDetails(args)],
          )
        ],
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

  Widget productDetails(args) {
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
              child:
                  CircleAvatar(backgroundImage: NetworkImage(args.imageUrl))),
          const SizedBox(width: 7),
          Text(
            args.title ?? '',
          ),
          const SizedBox(width: 7),
          Container(
            child: Text(args.price.toString()),
          )
        ]));
  }
}
