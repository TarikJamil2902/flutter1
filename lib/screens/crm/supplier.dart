import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class Supplier {
  int? id;
  String name;
  String code;
  String email;
  String phone;
  String address;

  Supplier({
    this.id,
    required this.name,
    required this.code,
    required this.email,
    required this.phone,
    required this.address,
  });
}

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  List<Supplier> suppliers = [];
  bool isEditing = false;
  int? editingId;

  void saveSupplier() {
    if (_formKey.currentState!.validate()) {
      Supplier supplier = Supplier(
        id: isEditing ? editingId : DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        code: codeController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
      );

      setState(() {
        if (isEditing) {
          final index = suppliers.indexWhere((s) => s.id == editingId);
          if (index != -1) suppliers[index] = supplier;
        } else {
          suppliers.add(supplier);
        }
        clearForm();
      });
    }
  }

  void editSupplier(Supplier s) {
    setState(() {
      nameController.text = s.name;
      codeController.text = s.code;
      emailController.text = s.email;
      phoneController.text = s.phone;
      addressController.text = s.address;
      isEditing = true;
      editingId = s.id;
    });
  }

  void deleteSupplier(Supplier s) {
    setState(() {
      suppliers.removeWhere((sup) => sup.id == s.id);
    });
  }

  void clearForm() {
    nameController.clear();
    codeController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    isEditing = false;
    editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier Manager'),
        backgroundColor: Colors.green.shade600,
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
                        isEditing ? "Edit Supplier" : "Add Supplier",
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
                                labelText: 'Supplier Code',
                              ),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter code' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter email' : null,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(labelText: 'Phone'),
                              validator:
                                  (value) =>
                                      value!.isEmpty ? 'Enter phone' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(labelText: 'Address'),
                        validator:
                            (value) => value!.isEmpty ? 'Enter address' : null,
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: saveSupplier,
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
              "Supplier List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Actions')),
                ],
                rows:
                    suppliers.map((s) {
                      return DataRow(
                        cells: [
                          DataCell(Text(s.name)),
                          DataCell(Text(s.code)),
                          DataCell(Text(s.email)),
                          DataCell(Text(s.phone)),
                          DataCell(Text(s.address)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => editSupplier(s),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteSupplier(s),
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
