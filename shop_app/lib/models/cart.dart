import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import 'cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => Map.unmodifiable(_items);

  int get itemCount => _items.length;

  Decimal get totalAmount {
    return _items.values.fold(
      Decimal.zero,
      (sum, item) =>
          sum +
          Decimal.parse(item.price) *
              Decimal.parse(item.quantity),
    );
  }

  void addItem(CartItem item) {
    if (_items.containsKey(item.productId)) {
      _items.update(
        item.productId,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity + item.quantity,
          price: existingItem.price + item.price,
        ),
      );
    } else {
      _items.putIfAbsent(item.productId, () => item);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
