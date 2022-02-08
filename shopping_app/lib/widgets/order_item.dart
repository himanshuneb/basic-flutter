import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart as ord';

class OrderItem extends StatelessWidget {
  //const OrderItem({ Key? key }) : super(key: key);
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime)),
          ),
        ],
      ),
    );
  }
}
