import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/payment_cart1/payments_selectiton.dart';
import 'package:shopcaycanh/utils_zalo/theme_data.dart';
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
  String zpTransToken = "";
  String payResult = "Thanh toán khi nhận hàng";
  final valueStyle = TextStyle(
      color: AppColor.accentColor, fontSize: 18.0, fontWeight: FontWeight.w400);
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
          // SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     Container(
          //         padding: EdgeInsets.only(left: 5),
          //         child: Text(
          //           'Hình thức thanh toán:',
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //           ),
          //         )),
          //     Container(
          //       alignment: Alignment.centerRight,
          //       padding: EdgeInsets.only(right: 5),
          //       child: PaymentSelectionDropdown(),
          //     ),
          //   ],
          // ),
          // const Divider(),
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
                          inforPhoneUser(snapshot.data!['phone'])
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
          buildProductTotal(cart),
          FutureBuilder<Map<String, dynamic>>(
            future: _futureFetchUserInformation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          paymentNow(snapshot, cart),
                          paymentZaloPay(snapshot, cart),
                          // statusPayZalo(),
                        ],
                      )),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  // Widget statusPayZalo() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 5.0),
  //     child: Text(
  //       '${payResult} + aaaaaaaaaaaa',
  //       style: valueStyle,
  //     ),
  //   );
  // }

  Widget inforPhoneUser(data) {
    return Row(
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
          height: 50,
          child: Row(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //       border: Border.all(
              //         color: Colors.black,
              //         width: 0.5,
              //       )),
              //   child: Image.asset(
              //     'assets/Images/user-icon.png',
              //     color: Colors.black12,
              //     height: 23,
              //     width: 23,
              //   ),
              // ),
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
        ),
      ),
    );
  }

  Widget paymentNow(snapshot, cart) {
    return Container(
      width: 400,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          context.read<OrdersManager>().addOrders(
              cart.products,
              cart.totalAmount,
              cart.totalQuantity,
              snapshot.data['name'],
              snapshot.data['phone'],
              snapshot.data['address'],
              payResult,
              );
          // cart.clear();
          showMyDialog(context, cart);
          // Navigator.of(context).pushNamed(OrdersScreen.routeName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: const Text('Thanh toán bằng tiền mặt',
            style: TextStyle(
              color: Colors.white,
            )),
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
                return Center(
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
                  context.read<OrdersManager>().addOrders(
                      cart.products,
                      cart.totalAmount,
                      cart.totalQuantity,
                      snapshot.data['name'],
                      snapshot.data['phone'],
                      snapshot.data['address'],
                      payResult,
                      );
                  showConfirmDialogZalo(context, payResult, cart);
                  print(payResult);
                  print(payResult + 'aaaa');
                  break;
                case FlutterZaloPayStatus.failed:
                  payResult = "Thanh toán thất bại";
                  context.read<OrdersManager>().addOrders(
                      cart.products,
                      cart.totalAmount,
                      cart.totalQuantity,
                      snapshot.data['name'],
                      snapshot.data['phone'],
                      snapshot.data['address'],
                      payResult,
                      );
                  showConfirmDialogZalo(context, payResult, cart);
                  print(payResult);
                  print(payResult + 'aaaa');
                  break;
                default:
                  payResult = "Thanh toán đang được xử lý";
                  context.read<OrdersManager>().addOrders(
                      cart.products,
                      cart.totalAmount,
                      cart.totalQuantity,
                      snapshot.data['name'],
                      snapshot.data['phone'],
                      snapshot.data['address'],
                      payResult,
                      );
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
            height: 50,
            width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text("Thanh toán bằng VN Pay",
                style: TextStyle(color: Colors.white, fontSize: 20.0))),
      ),
    );
  }
}
