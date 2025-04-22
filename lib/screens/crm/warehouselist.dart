import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class Warehouse {
  int? id;
  String name;
  String code;
  String mobile;
  String address;

  Warehouse({
    this.id,
    required this.name,
    required this.code,
    required this.mobile,
    required this.address,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      mobile: json['mobile'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'mobile': mobile,
      'address': address,
    };
  }
}

const String baseUrl = 'http://localhost:8080/warehouse';

class ApiService {
  Future<List<Warehouse>> fetchWarehouses() async {
    final response = await http.get(Uri.parse('$baseUrl/getAll'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => Warehouse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load warehouses');
    }
  }

  Future<void> addWarehouse(Warehouse w) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(w.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save warehouse');
    }
  }

  Future<void> updateWarehouse(Warehouse w) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(w.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update warehouse');
    }
  }

  Future<void> deleteWarehouse(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete warehouse');
    }
  }
}

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  _WarehouseScreenState createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  final _formKey = GlobalKey<FormState>();
  final apiService = ApiService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  List<Warehouse> warehouses = [];
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    loadWarehouses();
  }

  Future<void> loadWarehouses() async {
    try {
      final data = await apiService.fetchWarehouses();
      setState(() {
        warehouses = data;
      });
    } catch (e) {
      print('Error loading warehouses: $e');
    }
  }

  void saveWarehouse() async {
    if (_formKey.currentState!.validate()) {
      Warehouse w = Warehouse(
        id: isEditing ? editingId : null,
        name: nameController.text,
        code: codeController.text,
        mobile: mobileController.text,
        address: addressController.text,
      );

      try {
        if (isEditing) {
          await apiService.updateWarehouse(w);
        } else {
          await apiService.addWarehouse(w);
        }
        await loadWarehouses();
        clearForm();
      } catch (e) {
        print('Error saving: $e');
      }
    }
  }

  void editWarehouse(Warehouse w) {
    setState(() {
      nameController.text = w.name;
      codeController.text = w.code;
      mobileController.text = w.mobile;
      addressController.text = w.address;
      isEditing = true;
      editingId = w.id;
    });
  }

  void deleteWarehouse(Warehouse w) async {
    try {
      await apiService.deleteWarehouse(w.id!);
      await loadWarehouses();
    } catch (e) {
      print('Error deleting: $e');
    }
  }

  void clearForm() {
    nameController.clear();
    codeController.clear();
    mobileController.clear();
    addressController.clear();
    isEditing = false;
    editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse Manager'),
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
                        "Add Warehouse",
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
                                labelText: 'Warehouse Code',
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
                              controller: mobileController,
                              decoration: InputDecoration(labelText: 'Phone'),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter phone' : null,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(labelText: 'Address'),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter address' : null,
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
                              onPressed: saveWarehouse,
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
              "Warehouse List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Actions')),
                ],
                rows:
                    warehouses.map((w) {
                      return DataRow(
                        cells: [
                          DataCell(Text(w.name)),
                          DataCell(Text(w.code)),
                          DataCell(Text(w.mobile)),
                          DataCell(Text(w.address)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => editWarehouse(w),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteWarehouse(w),
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
