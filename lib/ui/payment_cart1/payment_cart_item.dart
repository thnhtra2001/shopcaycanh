import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/payment_cart1/payments_selectiton.dart';

import '../../models/cart_item.dart';
import '../../services/user_service.dart';
import '../shared/dialog_utils.dart';
import '../cart/cart_manager.dart';

class CartItemCard extends StatefulWidget {
  final String productId;
  final CartItem cardItem;

  const CartItemCard({
    required this.productId,
    required this.cardItem,
    super.key,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Container(
          //     padding: EdgeInsets.only(left: 5),
          //     child: Text(
          //       'Hình thức thanh toán:',
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 15,
          //       ),
          //     )),
          // Container(
          //   alignment: Alignment.centerRight,
          //   padding: EdgeInsets.only(right: 5),
          //   child: PaymentSelectionDropdown(),
          // ),
          Dismissible(
            key: ValueKey(widget.cardItem.id),
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
              context.read<CartManager>().removeItem(widget.productId);
            },
            child: buildItemCard(),
          )
        ],
      ),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.cardItem.imageUrl),
          ),
          title: Text(widget.cardItem.title),
          subtitle: Text(
              'Giá: ${(widget.cardItem.price)}'),
          trailing: Text('SL: ${widget.cardItem.quantity}'),
        ),
      ),
    );
  }

}
