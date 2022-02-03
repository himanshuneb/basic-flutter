import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  //const ProductsOverviewScreen({ Key? key }) : super(key: key);
  final List<Product> loadedProducts = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ProductItem(
          loadedProducts[i].id,
          loadedProducts[i].title,
          loadedProducts[i].imageUrl,
        ),
      ),
    );
  }
}
