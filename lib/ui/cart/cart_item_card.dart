
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/cart/cart_manager1.dart';

import '../../models/cart_item.dart';
import '../../models/cart_item1.dart';
import '../shared/dialog_utils.dart';
import 'cart_manager.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem1 cardItem;

  const CartItemCard({
    required this.productId,
    required this.cardItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
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
        context.read<CartManager1>().removeItem(cardItem);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(cardItem.imageUrl),
          ),
          title: Text(cardItem.title),
          subtitle: Text('Giá: ${(cardItem.price * cardItem.quantity)}'),
          trailing: Text('SL: ${cardItem.quantity}'),
        ),
      ),
    );
  }
}
