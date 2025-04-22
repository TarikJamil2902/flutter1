import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class Staff {
  int? id;
  String name;
  String staffId;
  String email;
  String phone;
  String address;
  String designation;
  String department;
  String joiningDate;

  Staff({
    this.id,
    required this.name,
    required this.staffId,
    required this.email,
    required this.phone,
    required this.address,
    required this.designation,
    required this.department,
    required this.joiningDate,
  });
}

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final staffIdController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final designationController = TextEditingController();
  final departmentController = TextEditingController();
  final joiningDateController = TextEditingController();

  List<Staff> staffList = [];
  bool isEditing = false;
  int? editingId;

  void saveStaff() {
    if (_formKey.currentState!.validate()) {
      final staff = Staff(
        id: isEditing ? editingId : DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        staffId: staffIdController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        designation: designationController.text,
        department: departmentController.text,
        joiningDate: joiningDateController.text,
      );

      setState(() {
        if (isEditing) {
          int index = staffList.indexWhere((s) => s.id == editingId);
          if (index != -1) staffList[index] = staff;
        } else {
          staffList.add(staff);
        }
        clearForm();
      });
    }
  }

  void editStaff(Staff s) {
    setState(() {
      nameController.text = s.name;
      staffIdController.text = s.staffId;
      emailController.text = s.email;
      phoneController.text = s.phone;
      addressController.text = s.address;
      designationController.text = s.designation;
      departmentController.text = s.department;
      joiningDateController.text = s.joiningDate;
      isEditing = true;
      editingId = s.id;
    });
  }

  void deleteStaff(Staff s) {
    setState(() {
      staffList.removeWhere((item) => item.id == s.id);
    });
  }

  void clearForm() {
    nameController.clear();
    staffIdController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    designationController.clear();
    departmentController.clear();
    joiningDateController.clear();
    isEditing = false;
    editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Manager'),
        backgroundColor: Colors.deepPurple.shade600,
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
                        isEditing ? "Edit Staff" : "Add Staff",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(labelText: 'Full Name'),
                              validator: (value) => value!.isEmpty ? 'Enter name' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: staffIdController,
                              decoration: InputDecoration(labelText: 'Staff ID'),
                              validator: (value) => value!.isEmpty ? 'Enter staff ID' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) => value!.isEmpty ? 'Enter email' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(labelText: 'Phone'),
                              validator: (value) => value!.isEmpty ? 'Enter phone' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(labelText: 'Address'),
                        validator: (value) => value!.isEmpty ? 'Enter address' : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: designationController,
                              decoration: InputDecoration(labelText: 'Designation'),
                              validator: (value) => value!.isEmpty ? 'Enter designation' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: departmentController,
                              decoration: InputDecoration(labelText: 'Department'),
                              validator: (value) => value!.isEmpty ? 'Enter department' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: joiningDateController,
                        decoration: InputDecoration(labelText: 'Joining Date (YYYY-MM-DD)'),
                        validator: (value) => value!.isEmpty ? 'Enter joining date' : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: saveStaff,
                            child: Text(isEditing ? 'Update' : 'Save'),
                          ),
                          if (isEditing) const SizedBox(width: 8),
                          if (isEditing)
                            OutlinedButton(
                              onPressed: clearForm,
                              child: const Text('Cancel'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Staff List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Designation')),
                  DataColumn(label: Text('Department')),
                  DataColumn(label: Text('Joining Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: staffList.map((staff) {
                  return DataRow(
                    cells: [
                      DataCell(Text(staff.name)),
                      DataCell(Text(staff.staffId)),
                      DataCell(Text(staff.email)),
                      DataCell(Text(staff.phone)),
                      DataCell(Text(staff.designation)),
                      DataCell(Text(staff.department)),
                      DataCell(Text(staff.joiningDate)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editStaff(staff),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteStaff(staff),
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
