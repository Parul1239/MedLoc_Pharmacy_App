import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
        @required this.name,
        @required this.image,
        @required this.quantity,
        @required this.price});
}

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid, String image, String name, double price) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
              (existingCartItem) =>
              CartItem(
                  id: DateTime.now().toString(),
                  name: existingCartItem.name,
                  image: existingCartItem.image,
                  quantity: existingCartItem.quantity + 1,
                  price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          pdtid,
              () =>
              CartItem(
                name: name,
                id: DateTime.now().toString(),
                image: image,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }


  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(
          id,
              (existingCartItem) => CartItem(
              id: DateTime.now().toString(),
              name: existingCartItem.name,
              image: existingCartItem.image,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }


}
