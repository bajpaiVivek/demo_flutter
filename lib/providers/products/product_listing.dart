import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Product?> _productList = [];
  List<Product?> get productList => _productList;

  ProductProvider(this.apiService);

  Future<void> fetchProductListing(String token) async {
    try {
      final product = await apiService.getProductListing(token);
      _productList = (product['products'] as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList();
      print(_productList);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch product listing: $e');
    }
  }
}
