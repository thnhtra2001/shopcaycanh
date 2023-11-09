import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../orders/order_manager.dart';
import '../../models/order_item.dart';

class OrderDetailScreen extends StatefulWidget {
  static const routeName = 'order-detail-screen';
  final OrderItem order;

  const OrderDetailScreen(this.order, {super.key});

  @override
  State<OrderDetailScreen> createState() => OrderDetailScreenState();
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử đơn hàng'),
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
                      child: Text(
                        'Ngày đặt',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 5),
                    child: Text(DateFormat('dd/MM/yyyy hh:mm')
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
            const SizedBox(height: 20),
            buildNameProductRow(),
            const SizedBox(height: 20),
            buildTotalQuantity(),
            const SizedBox(height: 20),
            buildTotalAmountRow(),
            const SizedBox(height: 20),
            buildStatusPayment(),
            const SizedBox(height: 20),
          ],
        ));
  }

  Widget buildNameRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Họ và tên',
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
            child: Text(
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

  Widget buildAddressRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
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
            child: Text(
              'Tên sản phẩm',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text(widget.order.products.first.title,
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
            child: Text(
              'Tổng tiền',
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
            child: Text(
              'Số lượng',
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
            child: Text(
              'Trạng thái',
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
