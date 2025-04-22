import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class Customer {
  int id;
  String name;
  String phone;
  String address;
  String email;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });
}

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  List<Customer> customers = [];
  bool isEditing = false;
  int? editingId;
  int nextId = 1;

  void saveCustomer() {
    if (_formKey.currentState!.validate()) {
      if (isEditing) {
        int index = customers.indexWhere((c) => c.id == editingId);
        customers[index] = Customer(
          id: editingId!,
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          email: emailController.text,
        );
      } else {
        customers.add(
          Customer(
            id: nextId++,
            name: nameController.text,
            phone: phoneController.text,
            address: addressController.text,
            email: emailController.text,
          ),
        );
      }

      setState(() {});
      clearForm();
    }
  }

  void editCustomer(Customer c) {
    nameController.text = c.name;
    phoneController.text = c.phone;
    addressController.text = c.address;
    emailController.text = c.email;
    setState(() {
      isEditing = true;
      editingId = c.id;
    });
  }

  void deleteCustomer(Customer c) {
    setState(() {
      customers.removeWhere((e) => e.id == c.id);
    });
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    emailController.clear();
    isEditing = false;
    editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Manager"),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        isEditing ? "Edit Customer" : "Add Customer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: "Name"),
                        validator:
                            (value) => value!.isEmpty ? "Enter name" : null,
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(labelText: "Phone"),
                        validator:
                            (value) => value!.isEmpty ? "Enter phone" : null,
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(labelText: "Address"),
                        validator:
                            (value) => value!.isEmpty ? "Enter address" : null,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                        validator:
                            (value) => value!.isEmpty ? "Enter email" : null,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: saveCustomer,
                            child: Text(isEditing ? "Update" : "Save"),
                          ),
                          if (isEditing) SizedBox(width: 8),
                          if (isEditing)
                            OutlinedButton(
                              onPressed: clearForm,
                              child: Text("Cancel"),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Customer List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Phone")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Actions")),
                ],
                rows:
                    customers.map((c) {
                      return DataRow(
                        cells: [
                          DataCell(Text(c.name)),
                          DataCell(Text(c.phone)),
                          DataCell(Text(c.address)),
                          DataCell(Text(c.email)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => editCustomer(c),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteCustomer(c),
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
