import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final List<Category> _categories = [];

  List<Category> get categories => _categories;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  void updateCategory(Category category) {
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index >= 0) {
      _categories[index] = category;
      notifyListeners();
    }
  }

  void deleteCategory(int id) {
    _categories.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  Category? getCategoryById(int id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  void incrementProductCount(int categoryId) {
    final index = _categories.indexWhere((c) => c.id == categoryId);
    if (index >= 0) {
      final category = _categories[index];
      _categories[index] = Category(
        id: category.id,
        name: category.name,
        productCount: category.productCount + 1,
      );
      notifyListeners();
    }
  }

  void decrementProductCount(int categoryId) {
    final index = _categories.indexWhere((c) => c.id == categoryId);
    if (index >= 0) {
      final category = _categories[index];
      if (category.productCount > 0) {
        _categories[index] = Category(
          id: category.id,
          name: category.name,
          productCount: category.productCount - 1,
        );
        notifyListeners();
      }
    }
  }
}
