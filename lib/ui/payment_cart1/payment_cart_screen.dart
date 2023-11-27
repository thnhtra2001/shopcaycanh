import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/models/order_item.dart';
import 'package:shopcaycanh/ui/orders/order_screen.dart';
import 'package:shopcaycanh/ui/payment_cart1/payments_selectiton.dart';
import '../../repo_zalo/payment.dart';
import '../../services/user_service.dart';
import '../cart/cart_manager1.dart';
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
    final cart = context.watch<CartManager1>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang thanh toán'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
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
          // Expanded(
          //   child: buildCartDetails(cart),
          // ),
          Expanded(
            child: Consumer<CartManager1>(
              builder: (ctx, cartManager1, child) {
                return ListView.builder(
                    itemCount: cartManager1.cartCount,
                    itemBuilder: (ctx, i) => GestureDetector(
                          child: Column(
                            children: [
                              Dismissible(
                                  key: ValueKey(cartManager1.cartItem[i].id),
                                  background: Container(
                                    color: Theme.of(context).colorScheme.error,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 4,
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (directiion) {
                                    return showConfirmDialog(
                                      context,
                                      'Bạn có chắc muốn xóa sản phẩm này?',
                                    );
                                  },
                                  onDismissed: (direction) {
                                    context.read<CartManager1>().removeItem(
                                        cartManager1.cartItem[i]
                                            );
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 4,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  cartManager1
                                                      .cartItem[i].imageUrl),
                                            ),
                                            title: Text(
                                                cartManager1.cartItem[i].title),
                                            subtitle: Text(
                                                'Giá: ${(cartManager1.cartItem[i].price * cartManager1.cartItem[i].quantity)}'),
                                            trailing: Text(
                                                'SL: ${cartManager1.cartItem[i].quantity}'),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ));
              },
            ),
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
                          SizedBox(height: 20),
                          paymentZaloPay(snapshot, cart),
                          SizedBox(height: 20),

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

  // Widget buildItemCard() {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(
  //       horizontal: 15,
  //       vertical: 4,
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8),
  //       child: ListTile(
  //         leading: CircleAvatar(
  //           backgroundImage: NetworkImage(cardItem.imageUrl),
  //         ),
  //         title: Text(cardItem.title),
  //         subtitle: Text('Giá: ${(cardItem.price * cardItem.quantity)}'),
  //         trailing: Text('SL: ${cardItem.quantity}'),
  //       ),
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
          width: 290,
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

  // Widget buildCartDetails(CartManager1 cart) {
  //   return ListView(
  //     children: cart.productEntries
  //         .map(
  //           (entry) => CartItemCard(
  //             productId: entry.key,
  //             cardItem: entry.value,
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  Widget buildProductTotal(CartManager1 cart) {
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
            products: cart.products,
            totalQuantity: cart.totalQuantity,
            name: snapshot.data['name'],
            phone: snapshot.data['phone'],
            address: snapshot.data['address'],
            customerId: snapshot.data['uid'],
            payResult: payResult,
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
            child: Text("Thanh toán bằng tiền mặt",
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
                  _order = OrderItem(
                    amount: cart.totalAmount,
                    products: cart.products,
                    totalQuantity: cart.totalQuantity,
                    name: snapshot.data['name'],
                    phone: snapshot.data['phone'],
                    address: snapshot.data['address'],
                    customerId: snapshot.data['uid'],
                    payResult: payResult,
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
                    products: cart.products,
                    totalQuantity: cart.totalQuantity,
                    name: snapshot.data['name'],
                    phone: snapshot.data['phone'],
                    address: snapshot.data['address'],
                    customerId: snapshot.data['uid'],
                    payResult: payResult,
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
                    products: cart.products,
                    totalQuantity: cart.totalQuantity,
                    name: snapshot.data['name'],
                    phone: snapshot.data['phone'],
                    address: snapshot.data['address'],
                    customerId: snapshot.data['uid'],
                    payResult: payResult,
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
          Navigator.of(context).pushReplacementNamed('/');
        },
        child: Container(
            // height: 50,
            // width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: Text("Thanh toán bằng ZaloPay",
                style: TextStyle(color: Colors.white, fontSize: 16))),
      ),
    );
  }
}
