
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  CartModel._();

  static final CartModel instance = CartModel._();

  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items =>
      List.unmodifiable(_items);

  int get itemTotal => _items.fold<int>(
    0,
        (sum, item) =>
    sum +
        ((item['price'] as num).toInt() *
            (item['quantity'] as int)),
  );

  int get deliveryFee => _items.isEmpty ? 0 : 40;

  int get platformFee => _items.isEmpty ? 0 : 10;

  int get total => itemTotal + deliveryFee + platformFee;

  int get totalQuantity => _items.fold<int>(
    0,
        (sum, item) => sum + (item['quantity'] as int),
  );

  void addItem(
      Map<String, dynamic> food, {
        int quantity = 1,
        String instructions = '',
      }) {
    final name = food['name'] as String;
    final price = (food['price'] as num).toInt();
    final image = food['image'] as String? ?? '';

    // Same food with the same instructions shares one cart entry.
    final index = _items.indexWhere(
          (item) =>
      item['name'] == name &&
          item['instructions'] == instructions,
    );

    if (index != -1) {
      _items[index]['quantity'] =
          (_items[index]['quantity'] as int) + quantity;
    } else {
      _items.add({
        'name': name,
        'price': price,
        'image': image,
        'quantity': quantity,
        'instructions': instructions,
      });
    }

    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (index < 0 || index >= _items.length) return;

    if (quantity <= 0) {
      removeItem(index);
      return;
    }

    _items[index]['quantity'] = quantity;
    notifyListeners();
  }

  void removeItem(int index) {
    if (index < 0 || index >= _items.length) return;

    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
