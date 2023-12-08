import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../orders/order_manager.dart';
import '../../models/order_item.dart';

class OrderDetailScreenAdmin extends StatefulWidget {
  final OrderItem order;

  const OrderDetailScreenAdmin(this.order, {super.key});

  @override
  State<OrderDetailScreenAdmin> createState() => _OrderDetailScreenAdminState();
}

class _OrderDetailScreenAdminState extends State<OrderDetailScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết đơn'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 5),
                      child: const Text(
                        'Ngày đặt',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 5),
                    child: Text(DateFormat('dd/MM/yyyy HH:mm')
                        .format(widget.order.dateTime)),
                  ),
                ],
              ),
              const Divider(),
              Container(
                  padding: EdgeInsets.all(20),
                  child: buildPaymentDetailScreen()),
            ],
          ),
        ));
  }

  Widget buildPaymentDetailScreen() {
    return Container(
        width: 500,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.teal, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            buildNameRow(),
            const SizedBox(height: 20),
            buildPhoneRow(),
            const SizedBox(height: 20),
            buildAddressRow(),
            // const SizedBox(height: 20),
            const Divider(
              color: Colors.black,
            ),
            buildNameProductRow(),
            // const SizedBox(height: 20),
            buildOrderDetails(),
            const Divider(
              color: Colors.black,
            ),
            // const SizedBox(height: 20),
            buildTotalQuantity(),
            const SizedBox(height: 20),
            buildTotalAmountRow(),
            const SizedBox(height: 20),
            buildOwnerRow(),
            // const SizedBox(height: 20),
            // buildOriginRow(),
            // const SizedBox(height: 20),
            // buildStatusRow(),
            const SizedBox(height: 20),
            buildStatusPayment(),
            const SizedBox(height: 20),
          ],
        ));
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
        ));
  }

  Widget buildNameRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Người đặt',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.name}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildPhoneRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Số điện thoại',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.phone}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildOwnerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Người bán',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.products.first.owner}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildOriginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Xuất xứ',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.products.first.origin}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Tình trạng',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.products.last.status}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildAddressRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Địa chỉ',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20, left: 40),
            child: Text(
              '${widget.order.address}',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNameProductRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Tên sản phẩm',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text("Số lượng x giá",
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildTotalAmountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Tổng thanh toán',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.amount}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildTotalQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Tổng số lượng',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.totalQuantity}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  Widget buildStatusPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: const Text(
              'Hình thức',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text('${widget.order.payResult}',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }

  // Widget buildPayRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Container(
  //           padding: EdgeInsets.only(left: 20),
  //           child: Text(
  //             'Giá vé',
  //             style: TextStyle(
  //               color: Colors.black54,
  //               fontSize: 20,
  //             ),
  //           )),
  //       Container(
  //         alignment: Alignment.centerRight,
  //         padding: EdgeInsets.only(right: 20),
  //         child: Text(
  //             NumberFormat.currency(locale: "vi_VN", symbol: "đ")
  //                 .format(widget.order.tiketPrice),
  //             style: TextStyle(fontSize: 16, color: Colors.black)),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildSeatQuantityRow(){
  //   return
  //   Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Container(
  //           padding: EdgeInsets.only(left: 20),
  //           child: Text(
  //             'Số lượng ghế',
  //             style: TextStyle(
  //               color: Colors.black54,
  //               fontSize: 20,
  //             ),
  //           )),
  //       Container(
  //         alignment: Alignment.centerRight,
  //         padding: EdgeInsets.only(right: 20),
  //         child: Text(
  //             widget.order.seats.length.toString(),
  //             style: TextStyle(fontSize: 16, color: Colors.black)),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildTotalRow(){

  //   return
  //   Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Container(
  //           padding: EdgeInsets.only(left: 20),
  //           child: Text(
  //             'Tổng thanh toán',
  //             style: TextStyle(
  //               color: Colors.black54,
  //               fontSize: 20,
  //             ),
  //           )),
  //       Container(
  //         alignment: Alignment.centerRight,
  //         padding: EdgeInsets.only(right: 20),
  //         child: Text(NumberFormat.currency(locale: "vi_VN",symbol: "đ").format(widget.order.total),
  //             style: TextStyle(fontSize: 16, color: Colors.black)),
  //       ),
  //     ],
  //   );
  // }
}
