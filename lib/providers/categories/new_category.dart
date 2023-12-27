import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../models/category.dart';

class NewCategoryProvider extends ChangeNotifier {
  final ApiService apiService;
  Category? _newCategory;
  Category? get createcategory => _newCategory;
  NewCategoryProvider(this.apiService) {
    _newCategory = null;
  }

  Future<void> createCategory(String token, String name, String desc) async {
    try {
      final category = await apiService.createCategory(token, name, desc);
      _newCategory = Category.fromJson(category);
      notifyListeners();
    } catch (e) {
      print('Failed to create: $e');
    }
  }
}
