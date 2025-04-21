import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter_app/screens/crm/distributor.dart';
import 'package:new_flutter_app/screens/crm/warehouselist.dart';
import 'package:new_flutter_app/screens/stocks/products_sc.dart';

class Sale {
  final int? sale_id;
  final String date;
  final String status;

  final int distributor_id;
  final int warehouse_id;
  final String customer_name;

  final int grand_total;

  Sale({
    this.sale_id,
    required this.date,
    required this.status,

    required this.distributor_id,
    required this.warehouse_id,
    required this.customer_name,

    required this.grand_total,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      sale_id: json['sale_id'],
      date: json['date'],
      status: json['status'],

      distributor_id: json['distributor_id'],
      warehouse_id: json['warehouse_id'],
      customer_name: json['customer_name'],

      grand_total: json['grand_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sale_id': sale_id,
      'date': date,
      'status': status,

      'distributor_id': distributor_id,
      'warehouse_id': warehouse_id,
      'customer_name': customer_name,

      'grand_total': grand_total,
    };
  }
}

class ProductService {
  static const String baseUrl = 'http://localhost:8080/product';

  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/getAll'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/get/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<Product>> getProductsByBrand(String brandName) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getproduct/$brandName'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products by brand');
    }
  }

  Future<int> getNextProductId() async {
    final response = await http.get(Uri.parse('$baseUrl/getNextValue'));
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to fetch next product ID');
    }
  }

  Future<void> saveProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 200) {
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

  Future<void> updateProductStock(
    int productId,
    int quantity,
    int newTotal,
  ) async {
    final uri = Uri.parse('$baseUrl/updateStock/$productId').replace(
      queryParameters: {
        'quantity': quantity.toString(),
        'newtotal': newTotal.toString(),
      },
    );
    final response = await http.put(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to update product stock');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}

class SaleService {
  final String baseUrl = 'http://localhost:8080/sale';

  Future<List<Sale>> fetchSales() async {
    final response = await http.get(Uri.parse('$baseUrl/getAll'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Sale.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load sales');
    }
  }

  Future<void> addSale(Sale sale) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(sale.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save sale');
    }
  }

  Future<void> updateSale(Sale sale) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(sale.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update sale');
    }
  }

  Future<void> deleteSale(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete sale');
    }
  }

  Future<Sale> getSaleById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/get/$id'));
    if (response.statusCode == 200) {
      return Sale.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch sale');
    }
  }
}

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController totalController = TextEditingController(
    text: '0',
  );

  List<Brand> brands = [];
  Brand? selectedBrand;

  List<Category> categories = [];
  Category? selectedCategory;

  List<Product> products = [];
  Product? selectedProduct;

  String? selectedDistributor;
  String? selectedWarehouse;
  String? selectedPaymentMethod;
  DateTime? selectedDate;

  List<Map<String, dynamic>> addedProducts = [];
  double grandTotal = 0;

  void calculateTotal() {
    final price = double.tryParse(priceController.text) ?? 0;
    final quantity = double.tryParse(quantityController.text) ?? 0;
    final total = price * quantity;
    totalController.text = total.toStringAsFixed(2);
  }

  void addProduct() {
    final product = {
      'id': addedProducts.length + 1,
      'productId': 'P${addedProducts.length + 1}',
      'name': selectedProduct ?? 'Product',
      'brand': selectedBrand ?? 'Brand',
      'price': double.tryParse(priceController.text) ?? 0,
      'quantity': double.tryParse(quantityController.text) ?? 0,
      'total': double.tryParse(totalController.text) ?? 0,
    };

    setState(() {
      addedProducts.add(product);
      grandTotal += product['total'] as double;

      priceController.clear();
      quantityController.clear();
      totalController.text = '0';
    });
  }

  void pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  Widget buildDropdown(
    String label,
    String? value,
    Function(String?) onChanged,
  ) {
    return SizedBox(
      width: 150,
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(label),
        items:
            ['One', 'Two', 'Three'].map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget buildTextInput(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return SizedBox(
      width: 150,
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label),
        onChanged: (_) => calculateTotal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(title: Text('Stock Out'), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildDropdown(
                  'Brand',
                  selectedBrand as String?,
                  (val) => setState(() => selectedBrand = val as Brand?),
                ),
                buildDropdown(
                  'Product',
                  selectedProduct as String?,
                  (val) => setState(() => selectedProduct = val as Product?),
                ),
                buildDropdown(
                  'Distributor',
                  selectedDistributor,
                  (val) => setState(() => selectedDistributor = val),
                ),
                buildDropdown(
                  'Warehouse',
                  selectedWarehouse,
                  (val) => setState(() => selectedWarehouse = val),
                ),
                ElevatedButton(
                  onPressed: pickDate,
                  child: Text(
                    selectedDate == null
                        ? 'Pick Date'
                        : selectedDate.toString().split(' ')[0],
                  ),
                ),
                buildDropdown(
                  'Payment Method',
                  selectedPaymentMethod,
                  (val) => setState(() => selectedPaymentMethod = val),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Add Product:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildTextInput('Product Name', TextEditingController()),
                buildTextInput('Brand', TextEditingController()),
                buildTextInput('Available Stock', TextEditingController()),
                buildTextInput('Unit', TextEditingController()),
                buildTextInput('Price', priceController, isNumber: true),
                buildTextInput('Quantity', quantityController, isNumber: true),
                buildTextInput('Total', totalController, isNumber: true),
                ElevatedButton(onPressed: addProduct, child: Text('Add')),
              ],
            ),
            SizedBox(height: 20),
            DataTable(
              columns: const [
                DataColumn(label: Text('Serial')),
                DataColumn(label: Text('Product Id')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Brand')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Total')),
              ],
              rows:
                  addedProducts.map((product) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${product['id']}')),
                        DataCell(Text(product['productId'])),
                        DataCell(Text(product['name'])),
                        DataCell(Text(product['brand'])),
                        DataCell(Text(product['price'].toString())),
                        DataCell(Text(product['quantity'].toString())),
                        DataCell(Text(product['total'].toString())),
                      ],
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Total: ', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white,
                  child: Text(
                    grandTotal.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save logic
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text('Save'),
              ),
            ),
            SizedBox(height: 20),
            Text("Sale List", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
