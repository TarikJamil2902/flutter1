import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:new_flutter_app/screens/stocks/brand_sc.dart';
import 'category_sc.dart';

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

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code, 'description': description};
  }
}

class Product {
  int? product_id;
  String product_code;
  String product_name;
  String product_unit;
  String product_brand;
  int product_quantity;
  int purchase_rate;
  int wirehouse_rate;
  int distributor_rate;
  int retail_rate;
  int mrp;
  String product_category;
  int total_quantity;
  bool status;

  Product({
    this.product_id,
    required this.product_code,
    required this.product_name,
    required this.product_unit,
    required this.product_brand,
    required this.product_quantity,
    required this.purchase_rate,
    required this.wirehouse_rate,
    required this.distributor_rate,
    required this.retail_rate,
    required this.mrp,
    required this.product_category,
    required this.total_quantity,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_id: json['product_id'],
      product_code: json['product_code'],
      product_name: json['product_name'],
      product_unit: json['product_unit'],
      product_brand: json['product_brand'] ?? '',
      product_category: json['product_category'] ?? '',
      product_quantity: json['product_quantity'],
      purchase_rate: json['purchase_rate'],
      wirehouse_rate: json['wirehouse_rate'],
      distributor_rate: json['distributor_rate'],
      retail_rate: json['retail_rate'],
      mrp: json['mrp'],
      total_quantity: json['total_quantity'],
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'product_code': product_code,
      'product_name': product_name,
      'product_unit': product_unit,
      'product_brand': product_brand,
      'product_quantity': product_quantity,
      'purchase_rate': purchase_rate,
      'wirehouse_rate': wirehouse_rate,
      'distributor_rate': distributor_rate,
      'retail_rate': retail_rate,
      'mrp': mrp,
      'product_category': product_category,
      'total_quantity': total_quantity,
      'status': status,
    };
  }
}

class ProductService {
  final String baseUrl = 'http://localhost:8080/product';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/getAll'));
    if (response.statusCode == 200) {
      List body = json.decode(response.body);
      return body.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save product');
    }
  }

  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final service = ProductService();

  List<Brand> brands = [];
  Brand? selectedBrand;

  List<Category> categories = [];
  Category? selectedCategory;

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final unitController = TextEditingController();
  final quantityController = TextEditingController();
  final purchaseRateController = TextEditingController();
  final warehouseRateController = TextEditingController();
  final distributorRateController = TextEditingController();
  final retailRateController = TextEditingController();
  final mrpController = TextEditingController();
  final totalQuantityController = TextEditingController();

  List<Product> products = [];
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadBrands();
    loadCategories();
  }

  void loadProducts() async {
    final list = await service.fetchProducts();
    setState(() => products = list);
  }

  void loadBrands() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/brand/getAll'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        brands = data.map((e) => Brand.fromJson(e)).toList();
      });
    }
  }

  void loadCategories() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/categories/getAll'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        categories = data.map((e) => Category.fromJson(e)).toList();
      });
    }
  }

  void clearForm() {
    codeController.clear();
    nameController.clear();
    unitController.clear();
    quantityController.clear();
    purchaseRateController.clear();
    warehouseRateController.clear();
    distributorRateController.clear();
    retailRateController.clear();
    mrpController.clear();
    totalQuantityController.clear();
    selectedBrand = null;
    selectedCategory = null;
    editingId = null;
    isEditing = false;
  }

  void saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        product_id: isEditing ? editingId : null,
        product_code: codeController.text,
        product_name: nameController.text,
        product_unit: unitController.text,
        product_brand: selectedBrand?.name ?? '',
        product_quantity: int.parse(quantityController.text),
        purchase_rate: int.parse(purchaseRateController.text),
        wirehouse_rate: int.parse(warehouseRateController.text),
        distributor_rate: int.parse(distributorRateController.text),
        retail_rate: int.parse(retailRateController.text),
        mrp: int.parse(mrpController.text),
        product_category: selectedCategory?.name ?? '',
        total_quantity: int.parse(totalQuantityController.text),
        status: true,
      );
      if (isEditing) {
        await service.updateProduct(product);
      } else {
        await service.addProduct(product);
      }
      loadProducts();
      clearForm();
    }
  }

  void editProduct(Product p) {
    setState(() {
      editingId = p.product_id;
      codeController.text = p.product_code;
      nameController.text = p.product_name;
      unitController.text = p.product_unit;
      quantityController.text = p.product_quantity.toString();
      purchaseRateController.text = p.purchase_rate.toString();
      warehouseRateController.text = p.wirehouse_rate.toString();
      distributorRateController.text = p.distributor_rate.toString();
      retailRateController.text = p.retail_rate.toString();
      mrpController.text = p.mrp.toString();
      totalQuantityController.text = p.total_quantity.toString();
      try {
        selectedBrand = brands.firstWhere((b) => b.name == p.product_brand);
      } catch (e) {
        selectedBrand = null; // Handle case where no matching brand is found
      }
      try {
        selectedCategory = categories.firstWhere(
          (c) => c.name == p.product_category,
        );
      } catch (e) {
        selectedCategory =
            null; // Handle case where no matching category is found
      }
      isEditing = true;
    });
  }

  void deleteProduct(int id) async {
    await service.deleteProduct(id);
    loadProducts();
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          validator: (value) => value!.isEmpty ? 'Required' : null,
        ),
      ),
    );
  }

  Widget buildDropdown<T>(
    String label,
    List<T> items,
    T? selectedItem,
    Function(T?) onChanged,
    String Function(T) getLabel,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: DropdownButtonFormField<T>(
          value: selectedItem,
          hint: Text("Select $label"),
          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(getLabel(item)),
                );
              }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
          validator: (val) => val == null ? 'Required' : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Manager")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildTextField("Name", nameController),
                        buildTextField("Code", codeController),
                        buildTextField("Unit", unitController),
                      ],
                    ),
                    Row(
                      children: [
                        buildDropdown<Brand>(
                          "Brand",
                          brands,
                          selectedBrand,
                          (value) => setState(() => selectedBrand = value),
                          (brand) => brand.name,
                        ),
                        buildDropdown<Category>(
                          "Category",
                          categories,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                          (category) => category.name,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buildTextField("Quantity", quantityController),
                        buildTextField("Purchase Rate", purchaseRateController),
                      ],
                    ),
                    Row(
                      children: [
                        buildTextField(
                          "Warehouse Rate",
                          warehouseRateController,
                        ),
                        buildTextField(
                          "Distributor Rate",
                          distributorRateController,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buildTextField("Retail Rate", retailRateController),
                        buildTextField("MRP", mrpController),
                      ],
                    ),
                    Row(
                      children: [
                        buildTextField(
                          "Total Quantity",
                          totalQuantityController,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: saveProduct,
                      child: Text(isEditing ? "Update Product" : "Add Product"),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text("Name")),
                              DataColumn(label: Text("Code")),
                              DataColumn(label: Text("Brand")),
                              DataColumn(label: Text("Quantity")),
                              DataColumn(label: Text("Purchase Rate")),
                              DataColumn(label: Text("Actions")),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text(product.product_name)),
                                  DataCell(Text(product.product_code)),
                                  DataCell(Text(product.product_brand)),
                                  DataCell(
                                    Text(product.product_quantity.toString()),
                                  ),
                                  DataCell(
                                    Text(product.purchase_rate.toString()),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () => editProduct(product),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed:
                                              () => deleteProduct(
                                                product.product_id!,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
