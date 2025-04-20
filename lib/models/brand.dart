import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// ================= Model =================
class Brand {
  int? id;
  String name;
  String code;
  String description;
  String category;
  String subcategory;

  Brand({
    this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.category,
    required this.subcategory,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      category: json['category'],
      subcategory: json['subcategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'category': category,
      'subcategory': subcategory,
    };
  }
}

// ================ Service ================
class BrandService {
  final String apiBase = 'http://192.168.0.101:8080';

  Future<List<Brand>> getBrands() async {
    final url = Uri.parse('$apiBase/brand/getAll');
    print('[BrandService] Fetching brands from: ' + url.toString());
    try {
      final response = await http.get(url);
      print('[BrandService] Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((json) => Brand.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load brands');
      }
    } catch (e) {
      print('❌ Error fetching brands: $e');
      throw Exception('Error fetching brands');
    }
  }

  Future<Brand> createBrand(Brand brand) async {
    final url = Uri.parse('$apiBase/brand/save');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(brand.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Brand.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create brand');
      }
    } catch (e) {
      print('❌ Error creating brand: $e');
      throw Exception('Error creating brand');
    }
  }

  Future<bool> deleteBrand(int brandId) async {
    final url = Uri.parse('$apiBase/brand/delete/$brandId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print('✅ Brand deleted successfully.');
        return true;
      } else {
        print('❌ Failed to delete brand: ${response.statusCode}');
        print('Response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('❌ Error deleting brand: $e');
      return false;
    }
  }

  Future<Brand> updateBrand(Brand brand) async {
    final url = Uri.parse('$apiBase/brand/update/${brand.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(brand.toJson()),
    );
    if (response.statusCode == 200) {
      return Brand.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update brand');
    }
  }
}

// ================ Provider ================
class BrandProvider with ChangeNotifier {
  final BrandService _brandService = BrandService();
  List<Brand> _brands = [];

  List<Brand> get brands => _brands;

  Future<void> fetchBrands() async {
    print('[BrandProvider] Calling fetchBrands...');
    try {
      _brands = await _brandService.getBrands();
      notifyListeners();
    } catch (e) {
      print('[BrandProvider] Error fetching brands: $e');
    }
  }

  Future<void> addBrand(Brand brand) async {
    try {
      Brand newBrand = await _brandService.createBrand(brand);
      _brands.add(newBrand);
      notifyListeners();
    } catch (e) {
      print('Error adding brand: $e');
    }
  }

  Future<void> deleteBrand(int brandId) async {
    bool success = await _brandService.deleteBrand(brandId);
    if (success) {
      _brands.removeWhere((brand) => brand.id == brandId);
      notifyListeners();
    }
  }

  Future<void> updateBrand(Brand brand) async {
    final updatedBrand = await _brandService.updateBrand(brand);
    final index = _brands.indexWhere((b) => b.id == brand.id);
    if (index != -1) {
      _brands[index] = updatedBrand;
      notifyListeners();
    }
  }
}
