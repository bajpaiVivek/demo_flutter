import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Category?> _categoryList = [];
  List<Category?> get categoryList => _categoryList;

  CategoryProvider(this.apiService);

  Future<void> fetchCategoryListing(String token) async {
    try {
      final categories = await apiService.getCategoryListing(token);
      _categoryList = (categories['categories'] as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList();
      print(_categoryList);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch category listing: $e');
    }
  }
}
