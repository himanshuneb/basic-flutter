import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transation_item.dart';

class TransactionList extends StatelessWidget {
  //const TransactionList({ Key? key }) : super(key: key);
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    // here we need a widget that can hold multiple widgets
    // Transaction itself is not a widget, each transaction in our list
    // should be mapped into a widget that outputs the data of that transaction
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ]);
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             //color: Colors.black,
                //             color: Theme.of(context).primaryColor,
                //             width: 2,
                //           ),
                //         ),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             //color: Colors.purple,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             transactions[index].title,
                //             // style: TextStyle(
                //             //   fontSize: 16,
                //             //   fontWeight: FontWeight.bold,
                //             // ),
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //           Text(
                //             //DateFormat.yMMMd().format(tx.date),
                //             DateFormat().format(transactions[index].date),
                //             style: TextStyle(
                //               //color: Colors.grey,
                //               color: Theme.of(context).primaryColorDark,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
                return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
              },
              itemCount: transactions.length,
            ),
    );
  }
}