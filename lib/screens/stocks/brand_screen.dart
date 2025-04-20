import 'package:flutter/material.dart';
import 'package:new_flutter_app/models/brand.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';
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
                onSuccess: () async {
                  Navigator.of(context).pop();
                  await Provider.of<BrandProvider>(
                    context,
                    listen: false,
                  ).fetchBrands();
                },
              ),
            ),
          ),
    );
  }

  void _showEditBrandDialog(BuildContext context, Brand brand) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AddBrandForm(
                brand: brand,
                onSuccess: () async {
                  Navigator.of(context).pop();
                  await Provider.of<BrandProvider>(
                    context,
                    listen: false,
                  ).fetchBrands();
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
      drawer: Drawer(child: DreawerWidget()), // Replace with your drawer widget
      body: Consumer<BrandProvider>(
        builder: (context, brandProvider, child) {
          final brands = brandProvider.brands;
          if (brands.isEmpty) {
            return const Center(child: Text('No brands found.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Allows horizontal scrolling on small screens
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      columnSpacing: 20,
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Code')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Subcategory')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows:
                          brands.map((brand) {
                            return DataRow(
                              cells: [
                                DataCell(Text(brand.name)),
                                DataCell(Text(brand.code)),
                                DataCell(Text(brand.category)),
                                DataCell(Text(brand.subcategory)),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed:
                                            () => _showEditBrandDialog(
                                              context,
                                              brand,
                                            ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          final confirmed = await showDialog<
                                            bool
                                          >(
                                            context: context,
                                            builder:
                                                (context) => AlertDialog(
                                                  title: const Text(
                                                    'Delete Brand',
                                                  ),
                                                  content: Text(
                                                    'Are you sure you want to delete "${brand.name}"?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            context,
                                                            false,
                                                          ),
                                                      child: const Text(
                                                        'Cancel',
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            context,
                                                            true,
                                                          ),
                                                      child: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          );
                                          if (confirmed == true) {
                                            await Provider.of<BrandProvider>(
                                              context,
                                              listen: false,
                                            ).deleteBrand(brand.id!);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ),
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
  final Brand? brand;
  final VoidCallback? onSuccess;
  const AddBrandForm({this.brand, this.onSuccess, Key? key}) : super(key: key);

  @override
  _AddBrandFormState createState() => _AddBrandFormState();
}

class _AddBrandFormState extends State<AddBrandForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _subcategoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.brand?.name ?? '');
    _codeController = TextEditingController(text: widget.brand?.code ?? '');
    _descriptionController = TextEditingController(
      text: widget.brand?.description ?? '',
    );
    _categoryController = TextEditingController(
      text: widget.brand?.category ?? '',
    );
    _subcategoryController = TextEditingController(
      text: widget.brand?.subcategory ?? '',
    );
  }

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
        id: widget.brand?.id,
        name: _nameController.text,
        code: _codeController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        subcategory: _subcategoryController.text,
      );

      final provider = Provider.of<BrandProvider>(context, listen: false);

      if (widget.brand == null) {
        await provider.addBrand(brand);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Brand added successfully')),
        );
      } else {
        await provider.updateBrand(brand);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Brand updated successfully')),
        );
      }

      if (widget.onSuccess != null) widget.onSuccess!();
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
            decoration: const InputDecoration(labelText: 'Brand Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter brand name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _codeController,
            decoration: const InputDecoration(labelText: 'Brand Code'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter brand code';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextFormField(
            controller: _categoryController,
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          TextFormField(
            controller: _subcategoryController,
            decoration: const InputDecoration(labelText: 'Subcategory'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text(widget.brand == null ? 'Add Brand' : 'Update Brand'),
          ),
        ],
      ),
    );
  }
}
