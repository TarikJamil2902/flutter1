import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Category {
  int? id;
  String name;
  String code;
  String description;

  Category({
    this.id,
    required this.name,
    required this.code,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
    );
  }

  get productCount => null;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code, 'description': description};
  }
}

class CategoryService {
  final String apiBase = 'http://192.168.0.101:8080/categories';

  Future<List<Category>> getCategories() async {
    final url = Uri.parse('$apiBase/getAll');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('❌ Error fetching categories: $e');
      throw Exception('Error fetching categories');
    }
  }

  Future<Category> createCategory(Category category) async {
    final url = Uri.parse('$apiBase/save');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(category.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Category.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create category');
      }
    } catch (e) {
      print('❌ Error creating category: $e');
      throw Exception('Error creating category');
    }
  }

  Future<bool> deleteCategory(int categoryId) async {
    final url = Uri.parse('$apiBase/delete/$categoryId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('❌ Failed to delete category: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('❌ Error deleting category: $e');
      return false;
    }
  }

  Future<Category> updateCategory(Category category) async {
    final url = Uri.parse('$apiBase/update/${category.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(category.toJson()),
    );
    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update category');
    }
  }
}

class CategoryProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      _categories = await _categoryService.getCategories();
      notifyListeners();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      Category newCategory = await _categoryService.createCategory(category);
      _categories.add(newCategory);
      notifyListeners();
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    bool success = await _categoryService.deleteCategory(categoryId);
    if (success) {
      _categories.removeWhere((category) => category.id == categoryId);
      notifyListeners();
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      Category updatedCategory = await _categoryService.updateCategory(
        category,
      );
      final index = _categories.indexWhere((c) => c.id == category.id);
      if (index != -1) {
        _categories[index] = updatedCategory;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating category: $e');
    }
  }
}
