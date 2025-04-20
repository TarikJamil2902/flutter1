import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter_app/screens/stocks/drawer.dart';

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

  get categoryName => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
    };
  }
}

const String baseUrl = 'http://localhost:8080/categories';

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/getAll'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> addCategory(Category c) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(c.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save category');
    }
  }

  Future<void> updateCategory(Category c) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(c.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }
}

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final categoryService = CategoryService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<Category> categories = [];
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final data = await categoryService.fetchCategories();
      setState(() {
        categories = data;
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  void saveCategory() async {
    if (_formKey.currentState!.validate()) {
      Category c = Category(
        id: isEditing ? editingId : null,
        name: nameController.text,
        code: codeController.text,
        description: descriptionController.text,
      );

      try {
        if (isEditing) {
          await categoryService.updateCategory(c);
        } else {
          await categoryService.addCategory(c);
        }
        await loadCategories();
        clearForm();
      } catch (e) {
        print('Error saving: $e');
      }
    }
  }

  void editCategory(Category c) {
    setState(() {
      nameController.text = c.name;
      codeController.text = c.code;
      descriptionController.text = c.description;
      isEditing = true;
      editingId = c.id;
    });
  }

  void deleteCategory(Category c) async {
    try {
      await categoryService.deleteCategory(c.id!);
      await loadCategories();
    } catch (e) {
      print('Error deleting: $e');
    }
  }

  void clearForm() {
    nameController.clear();
    codeController.clear();
    descriptionController.clear();
    isEditing = false;
    editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Manager'),
        backgroundColor: Colors.teal,
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
                        "Add Category",
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
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter name' : null,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: codeController,
                              decoration: InputDecoration(labelText: 'Code'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter code' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter description' : null,
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: saveCategory,
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
              "Category List",
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
                  DataColumn(label: Text('Actions')),
                ],
                rows: categories.map((c) {
                  return DataRow(
                    cells: [
                      DataCell(Text(c.name)),
                      DataCell(Text(c.code)),
                      DataCell(Text(c.description)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editCategory(c),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteCategory(c),
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
