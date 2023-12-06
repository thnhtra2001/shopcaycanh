import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/models/http_exception.dart';
import 'package:shopcaycanh/services/order_service.dart';
import 'package:shopcaycanh/ui/orders/order_manager.dart';
import 'package:shopcaycanh/ui/shared/dialog_utils.dart';

import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;
  const OrderItemCard(this.order, {super.key});
  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  Future<void> _submit(order) async {
    try {
      await OrderService().updateOrder(order);
    } catch (error) {
      showErrorDialog(context,
          (error is HttpException) ? error.toString() : 'Có lỗi xảy ra');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
              child: widget.order.orderStatus == 0
                  ? buildStatusOrder()
                  : widget.order.orderStatus == 1
                      ? buildStatusOrder1()
                      : widget.order.orderStatus == 2
                      ? buildStatusOrder2() : buildStatusOrder3()),
          buildOrderSummary(),
          buildOrderDetails()
        ],
      ),
    );
  }

  Widget buildStatusOrder() {
    late OrderItem _order;
    return Container(
      child: ListTile(
        title: Text('Chờ xác nhận'),
        trailing: ElevatedButton(
          child: Text("Hủy"),
          onPressed: () {
            print("BBBBBBBBBBBBBB");
            setState(() {
              final a = widget.order.orderStatus = 1;
              print(a);
            });
            _order = OrderItem(
                id: widget.order.id,
                amount: widget.order.amount,
                amount0: widget.order.amount0,
                products: widget.order.products,
                totalQuantity: widget.order.totalQuantity,
                name: widget.order.name,
                phone: widget.order.phone,
                address: widget.order.address,
                payResult: widget.order.payResult,
                customerId: widget.order.customerId,
                orderStatus: 1);
            _submit(_order);
          },
        ),
      ),
    );
  }

  Widget buildStatusOrder1() {
    late OrderItem _order;
    return Container(
      child: ListTile(
        title: Text('Đơn hàng đã hủy'),
        trailing: ElevatedButton(
          child: Text("Đã hủy"),
          onPressed: () {
            print("Hủy rồi còn click làm gì ?");
            // setState(() {
            //   final a = widget.order.orderStatus = 2;
            //   print(a);
            // });
            // _order = OrderItem(
            //     id: widget.order.id,
            //     amount: widget.order.amount,
            //     products: widget.order.products,
            //     totalQuantity: widget.order.totalQuantity,
            //     name: widget.order.name,
            //     phone: widget.order.phone,
            //     address: widget.order.address,
            //     payResult: widget.order.payResult,
            //     customerId: widget.order.customerId,
            //     orderStatus: 2);
            // _submit(_order);
          },
        ),
      ),
    );
  }

  Widget buildStatusOrder2() {
    late OrderItem _order;
    return Container(
      child: ListTile(
        title: Text('Đang vận chuyển'),
        trailing: ElevatedButton(
          child: Text("Đã nhận được hàng"),
          onPressed: () {
            print("BBBBBBBBBBBBBB");
            setState(() {
              final a = widget.order.orderStatus = 3;
              print(a);
            });
            _order = OrderItem(
                id: widget.order.id,
                amount: widget.order.amount,
                amount0: widget.order.amount0,
                products: widget.order.products,
                totalQuantity: widget.order.totalQuantity,
                name: widget.order.name,
                phone: widget.order.phone,
                address: widget.order.address,
                payResult: widget.order.payResult,
                customerId: widget.order.customerId,
                orderStatus: 3);
            _submit(_order);
          },
        ),
      ),
    );
  }
  Widget buildStatusOrder3() {
    late OrderItem _order;
    return Container(
      child: ListTile(
        title: Text('Vận chuyển thành công!'),
        trailing: ElevatedButton(
          child: Text("Đã nhận"),
          onPressed: () {
            print("Nhận được hàng rồi còn click gì nữa mèn ơi");
            // setState(() {
            //   final a = widget.order.orderStatus = 3;
            //   print(a);
            // });
            // _order = OrderItem(
            //     id: widget.order.id,
            //     amount: widget.order.amount,
            //     products: widget.order.products,
            //     totalQuantity: widget.order.totalQuantity,
            //     name: widget.order.name,
            //     phone: widget.order.phone,
            //     address: widget.order.address,
            //     payResult: widget.order.payResult,
            //     customerId: widget.order.customerId,
            //     orderStatus: 3);
            // _submit(_order);
          },
        ),
      ),
    );
  }
  Widget buildOrderDetails() {
    return SizedBox(
      height: widget.order.productCount * 32,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListView(
          children: widget.order.products
              .map(
                (prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      prod.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${prod.quantity}x${prod.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget buildOrderSummary() {
    return ListTile(
      title: Text('${widget.order.amount} VND'),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
      ),
    );
  }
}
