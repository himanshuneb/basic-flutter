import 'package:flutter/foundation.dart';

// this class is just a blueprint for a normal dart object
// it is not to be used as a widget to be rendered

class Transaction {
  //final as they are runtime constant, they get their value when the transaction
  //is created but the values thereafter never changes.

  String id;
  String title;
  double amount;
  DateTime date;

  // Adding constructor to conviniently create such transaction
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
