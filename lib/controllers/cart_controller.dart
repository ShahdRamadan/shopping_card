import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/cart_item_model.dart';

class CartController extends ChangeNotifier {
  final List<ProductModel> _availableProducts = [
    ProductModel(
      id: 'p1',
      name: 'Wireless Headphones',
      description:
          'High quality noise-canceling over-ear wireless headphones with 30 hours battery life.',
      price: 199.99,
      icon: Icons.headphones,
      color: Colors.blueAccent,
    ),
    ProductModel(
      id: 'p2',
      name: 'Smart Watch',
      description:
          'Fitness tracker with heart rate monitor, GPS, and water resistance up to 50 meters.',
      price: 149.50,
      icon: Icons.watch,
      color: Colors.teal,
    ),
    ProductModel(
      id: 'p3',
      name: 'Mechanical Keyboard',
      description:
          'RGB backlit mechanical gaming keyboard with tactile blue switches and aluminum frame.',
      price: 89.99,
      icon: Icons.keyboard,
      color: Colors.deepOrangeAccent,
    ),
    ProductModel(
      id: 'p4',
      name: 'Gaming Mouse',
      description:
          'Ergonomic ultra-lightweight wireless gaming mouse with high precision optical sensor.',
      price: 59.99,
      icon: Icons.mouse,
      color: Colors.purpleAccent,
    ),
    ProductModel(
      id: 'p5',
      name: 'Laptop Stand',
      description:
          'Adjustable aluminum ergonomic laptop riser compatible with all notebooks up to 17 inches.',
      price: 34.00,
      icon: Icons.laptop_mac,
      color: Colors.indigoAccent,
    ),
    ProductModel(
      id: 'p6',
      name: 'Bluetooth Speaker',
      description:
          'Portable waterproof speaker with 360-degree surround sound and deep bass.',
      price: 75.25,
      icon: Icons.speaker,
      color: Colors.redAccent,
    ),
  ];

  final Map<String, CartItemModel> _items = {};

  List<ProductModel> get availableProducts => [..._availableProducts];

  Map<String, CartItemModel> get items => {..._items};

  int get totalItemsCount {
    int count = 0;
    _items.forEach((key, cartItem) {
      count += cartItem.quantity;
    });
    return count;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.totalPrice;
    });
    return total;
  }

  bool isInCart(String productId) {
    return _items.containsKey(productId);
  }

  void addItem(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItemModel(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItemModel(product: product, quantity: 1),
      );
    }
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingItem) => CartItemModel(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
