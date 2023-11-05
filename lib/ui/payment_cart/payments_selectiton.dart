import 'package:flutter/material.dart';

final List<String> paymentList = <String>[
  'Thanh toán bằng tiền mặt',
  'Thanh toán qua VNPay',
  'Thanh toán qua Momo',
];

class PaymentSelectionDropdown extends StatefulWidget {
  const PaymentSelectionDropdown({super.key});

  @override
  State<PaymentSelectionDropdown> createState() =>
      _PaymentSelectionDropdownState();
}

class _PaymentSelectionDropdownState extends State<PaymentSelectionDropdown> {
  String dropdownValue = paymentList.first;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 210,
        height: 40,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.blueGrey, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(
            color: Colors.black,
          ),
          underline: Container(height: 1, color: Colors.black),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: paymentList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )));
  }
}
