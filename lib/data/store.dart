import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:provider_ecommerce/models/product.dart';

class Store extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> _products = [];
  Product? _active;

  Store() {
    _products = [
      Product(1, "Blue Tee", 2500.00, 0, "blue.png", lipsum.createParagraph()),
      Product(2, "Red Tee", 2500.00, 0, "red.png", lipsum.createParagraph()),
      Product(
          3, "Green Tee", 2500.00, 0, "green.png", lipsum.createParagraph()),
    ];
    notifyListeners();
  }

  List<Product> get products => _products;
  List<Product> get cart => _cart;
  Product? get activeProduct => _active;

  setActiveProduct(Product product) {
    _active = product;
  }

  clearCart() {
    for (Product p in _products) {
      p.quantity = 0;
    }
    _cart.clear();
    notifyListeners();
  }

  addItemToCart(Product product) {
    if (_cart.contains(product)) {
      product.quantity += 1;
    } else {
      _cart.add(product);
      product.quantity += 1;
    }
    notifyListeners();
  }

  removeItemFromCart(Product product) {
    if (_cart.contains(product) && product.quantity == 1) {
      product.quantity = 0;
      _cart.remove(product);
    }
    if (_cart.contains(product) && product.quantity > 1) {
      product.quantity -= 1;
    }
    notifyListeners();
  }

  int getCartQuantity() {
    int total = 0;
    for (Product p in _cart) {
      total += p.quantity;
    }
    return total;
  }

  double getCartTotal() {
    double price = 0;
    for (Product p in _cart) {
      price += (p.price * p.quantity);
    }
    return price;
  }
}
