import 'package:flutter/material.dart';
import 'package:new_flutter_app/models/brand.dart';
import 'package:provider/provider.dart';

class BrandScreen extends StatefulWidget {
  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BrandProvider>(context, listen: false).fetchBrands();
  }

  void _showAddBrandDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AddBrandForm(
                onSuccess: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brands')),
      body: Consumer<BrandProvider>(
        builder: (context, brandProvider, child) {
          final brands = brandProvider.brands;
          if (brands.isEmpty) {
            return const Center(child: Text('No brands found.'));
          }
          return ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return ListTile(
                title: Text(brand.name),
                subtitle: Text(brand.code),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBrandDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Brand'),
      ),
    );
  }
}

class AddBrandForm extends StatefulWidget {
  final VoidCallback? onSuccess;
  const AddBrandForm({this.onSuccess, Key? key}) : super(key: key);
  @override
  _AddBrandFormState createState() => _AddBrandFormState();
}

class _AddBrandFormState extends State<AddBrandForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _subcategoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _subcategoryController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final brand = Brand(
        name: _nameController.text,
        code: _codeController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        subcategory: _subcategoryController.text,
      );
      await Provider.of<BrandProvider>(context, listen: false).addBrand(brand);
      if (widget.onSuccess != null) widget.onSuccess!();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Brand added successfully')));
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Brand Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter brand name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _codeController,
            decoration: InputDecoration(labelText: 'Brand Code'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter brand code';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextFormField(
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Category'),
          ),
          TextFormField(
            controller: _subcategoryController,
            decoration: InputDecoration(labelText: 'Subcategory'),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _submitForm, child: Text('Add Brand')),
        ],
      ),
    );
  }
}
