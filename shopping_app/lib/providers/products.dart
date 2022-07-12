import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Product 1',
    //   description: 'Product 1 description',
    //   price: 9.99,
    //   imageUrl:
    //       'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Product 2',
    //   description: 'Product 2 description',
    //   price: 19.99,
    //   imageUrl:
    //       'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Product 3',
    //   description: 'Product 3 description',
    //   price: 29.99,
    //   imageUrl:
    //       'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Product 4',
    //   description: 'Product 4 description',
    //   price: 39.99,
    //   imageUrl:
    //       'https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png',
    // ),
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

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://shopping-app-6eefa-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try {
      final response = await http.get(url);
      //print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      //prodId, prodData <=> key, value
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavourite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://shopping-app-6eefa-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    //add try block around the code which might fail
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavorite,
        }),
      );
      //then
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
      //then ends
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://shopping-app-6eefa-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://shopping-app-6eefa-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    //removes from the list but still keeps the item in memory, helps in rollback if error
    var existingProduct = _items[existingProductIndex];
    //_items.removeWhere((prod) => prod.id == id);
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      //re-add locally if fail
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      //throw is basically like return
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
