import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  //const OrdersScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(itemBuilder: (ctx, i) => ,
      itemCount: orderData.orders.length,
      ),
    );
  }
}
