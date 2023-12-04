import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/cart/cart_manager.dart';
import '../../models/product.dart';
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
  @override
  Widget build(BuildContext context) {
    //_________________________________________________
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GridTile(
          footer: buildGridFooterBar(context),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(widget!.product!)));
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
          final cart = context.read<CartManager>();
          // print("cart 1 id: ");
          // print(_cart1.id);
          // if(_cart1.id == null){
                // cart.addCart(widget.product.id, widget.product.title, widget.product.price, widget.product.imageUrl, 1);
          // }
                cart.addItem(widget.product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: const Text('Đã thêm vào giỏ hàng!'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Xóa',
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
