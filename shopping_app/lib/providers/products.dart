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

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
