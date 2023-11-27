import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';

import '../../models/cart_item1.dart';
import '../../models/product.dart';

import '../cart/cart_manager1.dart';
import 'product_detail_screen.dart';

class ProductGridTile extends StatefulWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });
  final Product product;
  @override
  State<ProductGridTile> createState() => _ProductGridTileState();
}

class _ProductGridTileState extends State<ProductGridTile> {
  late Future<void> _fetchCarts = Future(() => null);

  @override
  void initState() {
    super.initState();
    _fetchCarts = context.read<CartManager1>().fetchCarts();
  }

  late CartItem1 _cart;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GridTile(
          footer: buildGridFooterBar(context),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(widget.product)));
            },
            child: Image.network(
              widget.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget buildGridFooterBar(BuildContext context) {
    // final cartManager = context.read<CartManager1>();
    // final cartItem = context.select<CartManager1, List<CartItem1>>((cartManager) => cartManager.cartItem);
    // print("AAAAAAAAAAA cartItem length");
    // print(cartItem.length);
    return FutureBuilder(
      future: _fetchCarts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<CartManager1>(builder: (context, cartManager, child) {
                      return GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              widget.product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                // final cartManager1 = context.read<CartManager1>();
                print("AAAAAAAAAAAAAAA");
                print(widget.product.id);
                final _cartStatus = cartManager.cartItem.first.productId;
                print("Carts Status productId");
                print(_cartStatus);
                _cart = CartItem1(
                    productId: widget.product.id,
                    title: widget.product.title,
                    quantity: 1,
                    price: widget.product.price,
                    imageUrl: widget.product.imageUrl,
                    owner: widget.product.owner,
                    origin: widget.product.origin,
                    status: widget.product.status);
                cartManager.addCart(_cart);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: const Text('Đã thêm vào giỏ hàng!'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Xóa',
                      onPressed: () {
                        cartManager.removeSingleItem(widget.product.id!);
                      },
                    ),
                  ));
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
          },);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // return GridTileBar(
    //   backgroundColor: Colors.black54,
    //   title: Text(
    //     widget.product.title,
    //     textAlign: TextAlign.center,
    //   ),
    //   trailing: IconButton(
    //     icon: const Icon(
    //       Icons.shopping_cart,
    //     ),
    //     onPressed: () {
    //       final cartManager1 = context.read<CartManager1>();
    //       print("AAAAAAAAAAAAAAA");
    //       print(widget.product.id);
    //       ///////////////
    //       _cart = CartItem1(
    //           productId: widget.product.id,
    //           title: widget.product.title,
    //           quantity: 1,
    //           price: widget.product.price,
    //           imageUrl: widget.product.imageUrl,
    //           owner: widget.product.owner,
    //           origin: widget.product.origin,
    //           status: widget.product.status);
    //       cartManager1.addCart(_cart);
    //       ScaffoldMessenger.of(context)
    //         ..hideCurrentSnackBar()
    //         ..showSnackBar(SnackBar(
    //           content: const Text('Đã thêm vào giỏ hàng!'),
    //           duration: const Duration(seconds: 2),
    //           action: SnackBarAction(
    //             label: 'Xóa',
    //             onPressed: () {
    //               cartManager1.removeSingleItem(widget.product.id!);
    //             },
    //           ),
    //         ));
    //     },
    //     color: Theme.of(context).colorScheme.secondary,
    //   ),
    // );
  }
}
