import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter_app/screens/stocks/drawer.dart';

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

  get brandName => null;

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

const String baseUrl =
    'http://localhost:8080/brand'; // Update the URL to point to the Brand API

class ApiService {
  Future<List<Brand>> fetchBrands() async {
    final response = await http.get(Uri.parse('$baseUrl/getAll'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => Brand.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }

  Future<void> addBrand(Brand b) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(b.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save brand');
    }
  }

  Future<void> updateBrand(Brand b) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(b.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update brand');
    }
  }

  Future<void> deleteBrand(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete brand');
    }
  }
}

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  final _formKey = GlobalKey<FormState>();
  final apiService = ApiService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subcategoryController = TextEditingController();

  List<Brand> brands = [];
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    loadBrands();
  }

  Future<void> loadBrands() async {
    try {
      final data = await apiService.fetchBrands();
      setState(() {
        brands = data;
      });
    } catch (e) {
      print('Error loading brands: $e');
    }
  }

  void saveBrand() async {
    if (_formKey.currentState!.validate()) {
      Brand b = Brand(
        id: isEditing ? editingId : null,
        name: nameController.text,
        code: codeController.text,
        description: descriptionController.text,
        category: categoryController.text,
        subcategory: subcategoryController.text,
      );

      try {
        if (isEditing) {
          await apiService.updateBrand(b);
        } else {
          await apiService.addBrand(b);
        }
        await loadBrands();
        clearForm();
      } catch (e) {
        print('Error saving: $e');
      }
    }
  }

  void editBrand(Brand b) {
    setState(() {
      nameController.text = b.name;
      codeController.text = b.code;
      descriptionController.text = b.description;
      categoryController.text = b.category;
      subcategoryController.text = b.subcategory;
      isEditing = true;
      editingId = b.id;
    });
  }

  void deleteBrand(Brand b) async {
    try {
      await apiService.deleteBrand(b.id!);
      await loadBrands();
    } catch (e) {
      print('Error deleting: $e');
    }
  }

  void clearForm() {
    nameController.clear();
    codeController.clear();
    descriptionController.clear();
    categoryController.clear();
    subcategoryController.clear();
    isEditing = false;
    editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand Manager'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Add Brand",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(labelText: 'Name'),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter name' : null,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: codeController,
                              decoration: InputDecoration(
                                labelText: 'Brand Code',
                              ),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter code' : null,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                              ),
                              validator:
                                  (value) =>
                                      value!.isEmpty
                                          ? 'Enter description'
                                          : null,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: categoryController,
                              decoration: InputDecoration(
                                labelText: 'Category',
                              ),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter category' : null,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: subcategoryController,
                              decoration: InputDecoration(
                                labelText: 'Subcategory',
                              ),
                              validator:
                                  (value) =>
                                      value!.isEmpty
                                          ? 'Enter subcategory'
                                          : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: saveBrand,
                              child: Text(isEditing ? 'Update' : 'Save'),
                            ),
                            if (isEditing) SizedBox(width: 8),
                            if (isEditing)
                              OutlinedButton(
                                onPressed: clearForm,
                                child: Text("Cancel"),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Brand List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Subcategory')),
                  DataColumn(label: Text('Actions')),
                ],
                rows:
                    brands.map((b) {
                      return DataRow(
                        cells: [
                          DataCell(Text(b.name)),
                          DataCell(Text(b.code)),
                          DataCell(Text(b.description)),
                          DataCell(Text(b.category)),
                          DataCell(Text(b.subcategory)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => editBrand(b),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteBrand(b),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
