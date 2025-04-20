import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class AddStaffForm extends StatefulWidget {
  const AddStaffForm({super.key});

  @override
  State<AddStaffForm> createState() => _AddStaffFormState();
}

class _AddStaffFormState extends State<AddStaffForm> {
  final _formKey = GlobalKey<FormState>();

  String? gender;
  String? department;
  String? designation;
  String? religion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Staff"),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.blue,
                  child: const Text(
                    "ADD STAFF",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField("Name"),
              _buildTextField("Id Code"),
              _buildTextField("Father name"),
              _buildTextField("Mother name"),
              _buildTextField("Phone"),
              _buildTextField(
                "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField("NID number"),
              _buildDateField("Birth Date"),
              _buildDropdown("Gender", [
                "Male",
                "Female",
                "Other",
              ], (val) => setState(() => gender = val)),
              _buildDateField("Join Date"),
              _buildDropdown("Department", [
                "Sales Representative",
                "Distributor",
                "Other",
              ], (val) => setState(() => department = val)),
              _buildDropdown("Designation", [
                "Area Manager",
                "Sales Man",
                "Other",
              ], (val) => setState(() => designation = val)),
              _buildTextField("Education"),
              _buildDropdown("Religion", [
                "Islam",
                "Hindu",
                "Boddo",
              ], (val) => setState(() => religion = val)),
              _buildTextField("Present Address"),
              _buildTextField("Permanent Addr"),
              const SizedBox(height: 12),
              const Text(
                "Picture Upload (not implemented)",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Refresh"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form Submitted')),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildDateField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.datetime,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            // Do something with picked date
          }
        },
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items:
            options
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }
}
