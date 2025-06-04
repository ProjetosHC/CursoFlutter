import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  final List<Product> _favoriteItems = dummyProducts
      .where((product) => product.isFavorite)
      .toList();

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => [..._favoriteItems];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

/*   bool _showFavoritesOnly = false;

  List<Product> get items => _showFavoritesOnly
      ? _items.where((product) => product.isFavorite).toList()
      : [..._items];

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  } */
