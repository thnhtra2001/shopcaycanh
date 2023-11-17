
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/cart_item.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';

import '../../models/product.dart';

import '../cart/cart_manager1.dart';
import 'product_detail_screen.dart';
import 'products_manager.dart';

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
    return GridTileBar(
      backgroundColor: Colors.black87,
      leading: ValueListenableBuilder<bool>(
        valueListenable: widget.product.isFavoriteListenable,
        builder: (context, isFavorite, child) {
          return IconButton(
            icon: Icon(
              widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              // product.isFavorite = !isFavorite;
              context.read<ProductsManager>().toggleFavoriteStatus(widget.product);
            },
          );
        },
      ),
      title: Text(
        widget.product.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.shopping_bag_outlined,
        ),
        onPressed: () {
          final cart = context.read<CartManager>();
          // print("cart 1 id: ");
          // print(_cart1.id);
          // if(_cart1.id == null){
                // cart.addCart(widget.product.id, widget.product.title, widget.product.price, widget.product.imageUrl, 1);
          // }
                cart.addItem(widget.product);

          // if(product.id ==null){
          //       cart.addCart(product.id, product.title, product.price, product.imageUrl, 1);
          // } else {
          //       cart.updateCart(1);
            
          // }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: const Text('Da them vao gio hang'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Xoa',
                onPressed: () {
                  cart.removeSingleItem(widget.product.id!);
                },
              ),
            ));
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
