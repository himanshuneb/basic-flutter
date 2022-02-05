import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Product 1',
      description: 'Product 1 description',
      price: 9.99,
      imageUrl:
          'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    ),
    Product(
      id: 'p2',
      title: 'Product 2',
      description: 'Product 2 description',
      price: 19.99,
      imageUrl:
          'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    ),
    Product(
      id: 'p3',
      title: 'Product 3',
      description: 'Product 3 description',
      price: 29.99,
      imageUrl:
          'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    ),
    Product(
      id: 'p4',
      title: 'Product 4',
      description: 'Product 4 description',
      price: 39.99,
      imageUrl:
          'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
