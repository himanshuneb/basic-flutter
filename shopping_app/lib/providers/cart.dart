import 'package:flutter/foundation.dart';

//structure that will be used in the Cart class
class CartItem {
  final String id;
  final String? title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

//with ChangeNotifier to make Cart class a provider
//there is no widget in this class
class Cart with ChangeNotifier {
  //this contains productId, CartItem
  //the id in CartItem will be having no relation with productId
  Map<String?, CartItem> _items = {};

  Map<String?, CartItem> get items {
    return {..._items};
  }

//getter functions

  int get itemCount {
    // int temp = 0;
    // int i;
    // for (i = 0; i < _items.length; i++) {
    //   temp = temp + _items[i].;
    // }
    // return temp;

    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;

    //return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  //modification functions that call notifyListeners at the end

  void addItem(
    String? productId,
    double price,
    String? title,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String? productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String? productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
