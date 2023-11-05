import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import '../../models/payment_cart.dart';
import '../../models/product.dart';
import '../../services/user_service.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';

import '../payment_detail/payment_item_card.dart';

import '../payment_detail/payments_selectiton.dart';

class PaymentDetailScreen extends StatefulWidget {
  static const routeName = '/payment-detail';
  const PaymentDetailScreen({super.key});
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
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    // print(args.price);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang thanh toán'),
      ),
      body: Column(
        children: [
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
                      width: deviceSize.width * 0.9,
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
          Column(
            children: [buildPaymentDetails(args)],
          ),
          Column(
            children: [paymentNow()],
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
        child: Text('Địa chỉ:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 8),
          child: TextFormField(
            initialValue: data,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.red, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                prefixIcon: Icon(Icons.location_city_outlined)),
            style: TextStyle(fontSize: 18),
          ))
    ]);
  }

  Widget inforUser(data) {
    return Column(
      children: [
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: Text('Người mua:',
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
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget buildPaymentDetails(Product args) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(args.imageUrl),
                      ),
                      title: Text(args.title),
                      subtitle: Text('Tổng: ${(args.price)}'),
                      trailing: Text('SL: 1'),
                    )
    );
  }
  // Widget productDetails(args) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: 40,
  //         alignment: Alignment.centerLeft,
  //         child: Text('Sản phẩm:',
  //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       ),
  //       Container(
  //           padding: const EdgeInsets.only(left: 20),
  //           color: Colors.white,
  //           height: 100,
  //           child: Row(children: [
  //             Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(100),
  //                     border: Border.all(
  //                       color: Colors.black,
  //                       width: 0.5,
  //                     )),
  //                 child: CircleAvatar(
  //                     backgroundImage: NetworkImage(args.imageUrl))),
  //             const SizedBox(width: 7),
  //             Text(
  //               args.title ?? '',
  //             ),
  //             const SizedBox(width: 7),
  //             Container(
  //               child: Text(args.price.toString()),
  //             )
  //           ]))
  //     ],
  //   );
  // }

  Widget paymentNow() {
    return Container(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          print('chuyen den trang order');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: const Text('Thanh toánnnn',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}