import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final ApiService apiService;

  CategoryProvider(this.apiService);

  List<Category> _categoryList = [];
  List<Category> get categoryList => _categoryList;

  Future<void> fetchCategoryListing(String token) async {
    try {
      final categories = await apiService.getCategoryListing(token);
      final List<dynamic> categoriesList = categories['data'];
      _categoryList = categoriesList
          .map((categoryMap) => Category(
                id: categoryMap['id'],
                name: categoryMap['name'],
                desc: categoryMap['desc'],
              ))
          .toList();

      notifyListeners();
    } catch (e) {
      print('Failed to fetch category listing: $e');
    }
  }
}
