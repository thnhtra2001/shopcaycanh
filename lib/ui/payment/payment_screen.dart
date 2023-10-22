import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../services/user_service.dart';

class PaymentDetailScreen extends StatefulWidget {
  static const routeName = '/payment-detail';
  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  late Future<Map<String, dynamic>> _futureFetchUserInformation;
  @override
  void initState() {
    super.initState();
    _futureFetchUserInformation = UserService().fetchUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    late Product product;
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
      maxLines: 3,
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
          // SvgPicture.asset(
          //   GlobalImages.copyIcon,
          //   height: 20,
          //   width: 20,
          //   color: GlobalColors.kGreyTextColor,
          // ),
        ],
      ),
    );
  }

  Widget productDetails(Product product) {
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
                child: CircleAvatar(
                    backgroundImage: NetworkImage(product.imageUrl))),
            const SizedBox(width: 7),
            Text(
              product.title ?? '',
            ),
            const SizedBox(width: 7),
            // SvgPicture.asset(
            //   GlobalImages.copyIcon,
            //   height: 20,
            //   width: 20,
            //   color: GlobalColors.kGreyTextColor,
            // ),
          ],
        ));
  }
}
