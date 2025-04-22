import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class Distributor {
  int? id;
  String code;
  String name;
  String mobile;
  String address;
  String zone;
  String password2;
  String email;
  String username;
  String usertype;
  String photo;

  Distributor({
    this.id,
    required this.code,
    required this.name,
    required this.mobile,
    required this.address,
    required this.zone,
    required this.password2,
    required this.email,
    required this.username,
    required this.usertype,
    required this.photo,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) {
    return Distributor(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      mobile: json['mobile'],
      address: json['address'],
      zone: json['zone'],
      password2: json['password2'],
      email: json['email'],
      username: json['username'],
      usertype: json['usertype'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'mobile': mobile,
      'address': address,
      'zone': zone,
      'password2': password2,
      'email': email,
      'username': username,
      'usertype': usertype,
      'photo': photo,
    };
  }
}

class DistributorService {
  final String baseUrl = 'http://localhost:8080/distributor';

  Future<List<Distributor>> fetchDistributors() async {
    final response = await http.get(Uri.parse('$baseUrl/getAll'));
    if (response.statusCode == 200) {
      List body = json.decode(response.body);
      return body.map((e) => Distributor.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load distributors');
    }
  }

  Future<void> addDistributor(Distributor distributor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(distributor.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save distributor');
    }
  }

  Future<void> updateDistributor(Distributor distributor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(distributor.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update distributor');
    }
  }

  Future<void> deleteDistributor(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete distributor');
    }
  }
}

class DistributorScreen extends StatefulWidget {
  const DistributorScreen({super.key});

  @override
  State<DistributorScreen> createState() => _DistributorScreenState();
}

class _DistributorScreenState extends State<DistributorScreen> {
  final _formKey = GlobalKey<FormState>();
  final service = DistributorService();

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final zoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final usertypeController = TextEditingController();

  List<Distributor> distributors = [];
  bool isEditing = false;
  int? editingId;

  @override
  void initState() {
    super.initState();
    loadDistributors();
  }

  void loadDistributors() async {
    final list = await service.fetchDistributors();
    setState(() => distributors = list);
  }

  void clearForm() {
    nameController.clear();
    codeController.clear();
    mobileController.clear();
    addressController.clear();
    zoneController.clear();
    passwordController.clear();
    emailController.clear();
    usernameController.clear();
    usertypeController.clear();
    editingId = null;
    isEditing = false;
  }

  void saveDistributor() async {
    if (_formKey.currentState!.validate()) {
      final distributor = Distributor(
        id: isEditing ? editingId : null,
        code: codeController.text,
        name: nameController.text,
        mobile: mobileController.text,
        address: addressController.text,
        zone: zoneController.text,
        password2: passwordController.text,
        email: emailController.text,
        username: usernameController.text,
        usertype: usertypeController.text,
        photo: '',
      );
      if (isEditing) {
        await service.updateDistributor(distributor);
      } else {
        await service.addDistributor(distributor);
      }
      loadDistributors();
      clearForm();
    }
  }

  void editDistributor(Distributor d) {
    setState(() {
      editingId = d.id;
      codeController.text = d.code;
      nameController.text = d.name;
      mobileController.text = d.mobile;
      addressController.text = d.address;
      zoneController.text = d.zone;
      passwordController.text = d.password2;
      emailController.text = d.email;
      usernameController.text = d.username;
      usertypeController.text = d.usertype;
      isEditing = true;
    });
  }

  void deleteDistributor(int id) async {
    await service.deleteDistributor(id);
    loadDistributors();
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Distributor Manager')),
      drawer: Drawer(child: DreawerWidget()),

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
                        buildTextField('Name', nameController),
                        buildTextField('Code', codeController),
                        buildTextField('Mobile', mobileController),
                      ],
                    ),
                    Row(
                      children: [
                        buildTextField('Address', addressController),
                        buildTextField('Zone', zoneController),
                        buildTextField('Password', passwordController),
                      ],
                    ),
                    Row(
                      children: [
                        buildTextField('Email', emailController),
                        buildTextField('Username', usernameController),
                        buildTextField('Usertype', usertypeController),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: saveDistributor,
                          child: Text(isEditing ? "Update" : "Save"),
                        ),
                        const SizedBox(width: 8),
                        if (isEditing)
                          OutlinedButton(
                            onPressed: clearForm,
                            child: const Text("Cancel"),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 12),
              const Text("Distributor List", style: TextStyle(fontSize: 18)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Code')),
                    DataColumn(label: Text('Mobile')),
                    DataColumn(label: Text('Zone')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows:
                      distributors.map((d) {
                        return DataRow(
                          cells: [
                            DataCell(Text(d.name)),
                            DataCell(Text(d.code)),
                            DataCell(Text(d.mobile)),
                            DataCell(Text(d.zone)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () => editDistributor(d),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => deleteDistributor(d.id!),
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
      ),
    );
  }
}
