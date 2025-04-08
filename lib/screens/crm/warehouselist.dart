import 'package:flutter/material.dart';

class Warehouse {
  int id;
  String name;
  String code;
  String mobile;
  String address;

  Warehouse({required this.id, required this.name, required this.code, required this.mobile, required this.address});
}

class WarehouseScreen extends StatefulWidget {
  @override
  _WarehouseScreenState createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  List<Warehouse> warehouses = [];
  bool isEditing = false;
  int? editingId;

  void saveWarehouse() {
    if (_formKey.currentState!.validate()) {
      if (isEditing) {
        setState(() {
          final index = warehouses.indexWhere((w) => w.id == editingId);
          warehouses[index] = Warehouse(
            id: editingId!,
            name: nameController.text,
            code: codeController.text,
            mobile: mobileController.text,
            address: addressController.text,
          );
          clearForm();
        });
      } else {
        setState(() {
          warehouses.add(Warehouse(
            id: DateTime.now().millisecondsSinceEpoch,
            name: nameController.text,
            code: codeController.text,
            mobile: mobileController.text,
            address: addressController.text,
          ));
          clearForm();
        });
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

  void deleteWarehouse(Warehouse w) {
    setState(() {
      warehouses.removeWhere((element) => element.id == w.id);
    });
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
                      Text("Add Warehouse", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(labelText: 'Name'),
                              validator: (value) => value!.isEmpty ? 'Enter name' : null,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: codeController,
                              decoration: InputDecoration(labelText: 'Warehouse Code'),
                              validator: (value) => value!.isEmpty ? 'Enter code' : null,
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
                              validator: (value) => value!.isEmpty ? 'Enter phone' : null,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(labelText: 'Address'),
                              validator: (value) => value!.isEmpty ? 'Enter address' : null,
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
                            if (isEditing)
                              SizedBox(width: 8),
                            if (isEditing)
                              OutlinedButton(
                                onPressed: clearForm,
                                child: Text("Cancel"),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text("Warehouse List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: warehouses.length,
              itemBuilder: (context, index) {
                final w = warehouses[index];
                return Card(
                  child: ListTile(
                    title: Text('${w.name} (${w.code})'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone: ${w.mobile}'),
                        Text('Address: ${w.address}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () => editWarehouse(w)),
                        IconButton(icon: Icon(Icons.delete), onPressed: () => deleteWarehouse(w)),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
