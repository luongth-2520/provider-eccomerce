import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_ecommerce/data/store.dart';
import 'package:provider_ecommerce/screens/home/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Store>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product list',
          style: TextStyle(color: Colors.black45),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.black45,
            ),
          ),
          Badge(
            position: const BadgePosition(top: 0, end: 2),
            badgeContent: const Text(
              '8',
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black45,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Just for you',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View all',
                      style: TextStyle(color: Colors.greenAccent),
                    ))
              ],
            ),
          ),
          ...store.products.map(
            (item) => GestureDetector(
              onTap: () {},
              child: ProductItem(product: item),
            ),
          ),
        ],
      ),
    );
  }
}
