import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import '../../repo_zalo/payment.dart';
import '../../services/user_service.dart';
import '../screens.dart';
import 'package:provider/provider.dart';

import '../cart/cart_manager.dart';
import '../payment_cart1/payment_cart_item.dart';
import '../orders/order_manager.dart';
import '../shared/dialog_utils.dart';
import '../widget/custom_rich_text.dart';

class PaymentCartScreen1 extends StatefulWidget {
  static const routeName = '/payment-cart1';

  const PaymentCartScreen1({super.key});

  @override
  State<PaymentCartScreen1> createState() => _PaymentCartScreen1State();
}

class _PaymentCartScreen1State extends State<PaymentCartScreen1> {
  late OrderItem _order;
  int orderStatus = 0;
  String zpTransToken = "";
  String payResult = "Thanh toán bằng tiền mặt";
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                FutureBuilder<Map<String, dynamic>>(
                  future: _futureFetchUserInformation,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                paymentAddress(snapshot.data!['address']),
                                inforNameUser(snapshot.data!['name']),
                                const SizedBox(height: 20),
                                inforPhoneUser(snapshot.data!['phone']),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: cart.productCount * 80,
                                  child: buildCartDetails(cart),
                                ),
                                buildProductTotal(cart),
                                paymentNow(snapshot, cart),
                                SizedBox(height: 20),
                                paymentZaloPay(snapshot, cart),
                                SizedBox(height: 20),
                              ],
                            )),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget inforPhoneUser(data) {
    return Column(
      children: [
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          child: const Text('Số điện thoại:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          color: Colors.white,
          height: 60,
          width: 400,
          child: Row(
            children: [
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

  Widget paymentAddress(data) {
    return Column(children: [
      Container(
        height: 40,
        alignment: Alignment.centerLeft,
        child: const Text('Địa chỉ:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        width: 400,
        margin: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 64, 59, 59),
                width: 0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(0)),
        child: Text(
          data,
          style: TextStyle(fontSize: 16),
        ),
      )
    ]);
  }

  Widget inforNameUser(data) {
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
          height: 60,
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
                  color: Colors.black,
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
        ),
      ),
    );
  }

  Widget paymentNow(snapshot, cart) {
    return Container(
      width: 400,
      height: 50,
      child: GestureDetector(
        onTap: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
          _order = OrderItem(
            amount: cart.totalAmount,
            amount0: cart.totalAmount0,
            products: cart.products,
            totalQuantity: cart.totalQuantity,
            name: snapshot.data['name'],
            phone: snapshot.data['phone'],
            address: snapshot.data['address'],
            customerId: snapshot.data['uid'],
            payResult: payResult,
            orderStatus: orderStatus,
            // owner: cart.owner,
            // origin: cart.origin,
            // status: cart.status,
          );
          context.read<OrdersManager>().addOrders(_order);
          // cart.clear();
          showMyDialog(context, cart);
          // Navigator.of(context).pushNamed(OrdersScreen.routeName);
        },
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: const Text("Thanh toán bằng tiền mặt",
                style: TextStyle(color: Colors.white, fontSize: 16))),
      ),
    );
  }

  Widget paymentZaloPay(snapshot, cart) {
    return Container(
      width: 400,
      height: 50,
      child: GestureDetector(
        onTap: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
          int amount = cart.totalAmount.toInt();
          var result = await createOrder(amount);
          if (result != null) {
            Navigator.pop(context);
            zpTransToken = result.zptranstoken;
            print("zpTransTokenAAAAAAAAAAAA $zpTransToken'.");
            setState(() {
              zpTransToken = result.zptranstoken;
            });
          }
          FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).then((event) {
            setState(() {
              switch (event) {
                case FlutterZaloPayStatus.cancelled:
                  payResult = "User Huỷ Thanh Toán";
                  showConfirmDialogZaloCancel(context, payResult);
                  print(payResult + 'aaaa');
                  break;
                case FlutterZaloPayStatus.success:
                  payResult = "Thanh toán thành công";
                  _order = OrderItem(
                    amount: cart.totalAmount,
            amount0: cart.totalAmount0,

                    products: cart.products,
                    totalQuantity: cart.totalQuantity,
                    name: snapshot.data['name'],
                    phone: snapshot.data['phone'],
                    address: snapshot.data['address'],
                    customerId: snapshot.data['uid'],
                    payResult: payResult,
                    orderStatus: orderStatus,
                    // owner: cart.owner,
                    // origin: cart.origin,
                    // status: cart.status,
                  );
                  context.read<OrdersManager>().addOrders(_order);
                  showConfirmDialogZalo(context, payResult, cart);
                  print(payResult);
                  print(payResult + 'aaaa');
                  break;
                case FlutterZaloPayStatus.failed:
                  payResult = "Thanh toán thất bại";
                  _order = OrderItem(
                    amount: cart.totalAmount,
            amount0: cart.totalAmount0,

                    products: cart.products,
                    totalQuantity: cart.totalQuantity,
                    name: snapshot.data['name'],
                    phone: snapshot.data['phone'],
                    address: snapshot.data['address'],
                    customerId: snapshot.data['uid'],
                    payResult: payResult,
                    orderStatus: orderStatus,
                    // owner: cart.owner,
                    // origin: cart.origin,
                    // status: cart.status,
                  );
                  context.read<OrdersManager>().addOrders(_order);
                  showConfirmDialogZalo(context, payResult, cart);
                  print(payResult);
                  print(payResult + 'aaaa');
                  break;
                default:
                  payResult = "Thanh toán đang được xử lý";
                  _order = OrderItem(
                    amount: cart.totalAmount,
            amount0: cart.totalAmount0,

                    products: cart.products,
                    totalQuantity: cart.totalQuantity,
                    name: snapshot.data['name'],
                    phone: snapshot.data['phone'],
                    address: snapshot.data['address'],
                    customerId: snapshot.data['uid'],
                    payResult: payResult,
                    orderStatus: orderStatus,
                    // owner: cart.owner,
                    // origin: cart.origin,
                    // status: cart.status,
                  );
                  context.read<OrdersManager>().addOrders(_order);
                  showConfirmDialogZalo(context, payResult, cart);
                  print(payResult);
                  print(payResult + 'aaaa');
                  break;
              }
            });
          });

          // showConfirmDialogZalo(context, payResult);
          // cart.clear();
          // showMyDialog(context, cart);
          // Navigator.of(context).pushNamed(OrdersScreen.routeName);
          // Navigator.of(context).pushReplacementNamed('/');
        },
        child: Container(
            // height: 50,
            // width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: const Text("Thanh toán bằng ZaloPay",
                style: TextStyle(color: Colors.white, fontSize: 16))),
      ),
    );
  }
}
