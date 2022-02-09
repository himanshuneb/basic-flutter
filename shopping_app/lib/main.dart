import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
//For ChangeNotifierProvider
//It helps to register a class to which it can listen in the child widgets and whenever that class updates, the widgets which are listening (not all widgets in the file of ChangeNotifierProvider) will rebuild.

// 1) If context needed, provider < 4.0.0
// return ChangeNotifierProvider(
//     create: (ctx) => Products(),
//     child: ,
// );

// 2) If context needed, provider > 4.0.0
// return ChangeNotifierProvider(
//     create: (ctx) => Products(),
//     child: ,
// );

// 3) If context not needed (can also use _ instead of ctx in above cases)
// return ChangeNotifierProvider.value(
//     value: Products(),
//     child ,
// );

// Difference to keep in mind [ref. 198. Exploring alternative Provider syntaxes] :
// .value approach is the right approach you should use if you for example, use a provider on something that's part of a list or a grid.
// Using the create or builder method is beneficial in the cases when you create a new object based on a class to provide that object to the change notifier provider you should use the create method for efficiency and to avoid bugs. Whenever we use an existing object, like we do in our products_grid widget, its better to use .value approach.
//
//Also imp, difference between "Consumer" and "Provider.of" [199.]
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'Shop',
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.amber,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
          }),
    );
  }
}
