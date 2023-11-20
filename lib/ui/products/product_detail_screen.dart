import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/cart/cart_screen.dart';
import 'package:shopcaycanh/ui/payment_cart1/payment_cart_screen.dart';
import 'package:shopcaycanh/ui/products/top_right_badge.dart';

import '../../models/product.dart';
import '../cart/cart_manager.dart';
import '../cart/cart_manager1.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết cây cảnh"),
      ),
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        width: 200,
                        // width: double.infinity,
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tên cây',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      '${product.title}',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Chủ cửa hàng',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      '${product.owner}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Xuất xứ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      '${product.origin}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Trạng thái',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      '${product.status}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Giá bán',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      '${product.price}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                buildShoppingCartIcon(),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ]),
              ),
              // SizedBox(
              //   height: 300,
              //   width: double.infinity,
              //   child: Image.network(
              //     product.imageUrl,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // const SizedBox(height: 10),
              // Text(
              //   '${product.title}',
              //   style: const TextStyle(
              //     color: Colors.red,
              //     fontStyle: FontStyle.italic,
              //     fontSize: 30,
              //   ),
              // ),
              // Text(
              //   '${product.owner}',
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 20,
              //   ),
              // ),
              // Text(
              //   '${product.origin}',
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 20,
              //   ),
              // ),
              // Text(
              //   '${product.status}',
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 20,
              //   ),
              // ),
              // Text(
              //   '${product.price}',
              //   style: const TextStyle(
              //     color: Colors.grey,
              //     fontSize: 20,
              //   ),
              // ),
              const SizedBox(height: 20),
              // buildShoppingCartIcon(),
              Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    final cart = context.read<CartManager>();
                    // cart.addCart(product.id, product.title, product.price, product.imageUrl, 1);
                    cart.addItem(product);
                    Navigator.of(context)
                        .pushNamed(PaymentCartScreen1.routeName);
                    //   print(product.title);
                    //   Navigator.of(context).pushNamed(PaymentDetailScreen.routeName,
                    //       arguments: Product(
                    //           title: product.title,
                    //           description: product.description,
                    //           price: product.price,
                    //           imageUrl: product.imageUrl)
                    //           );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Đặt hàng',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      'Mô tả cây cảnh',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.start,
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (context, cartManager, child) {
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Thêm vào giỏ:',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        //them vao cart
                        final cart = context.read<CartManager>();
                        cart.addItem(product);
                        // cart.addCart(product.id, product.title, product.price, product.imageUrl, 1);
                        //thong bao

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: const Text('Đã thêm vào giỏ hàng!'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'Xóa',
                              onPressed: () {
                                cart.removeSingleItem(product.id!);
                              },
                            ),
                          ));
                      },
                      icon: const Icon(Icons.shopping_cart)),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
