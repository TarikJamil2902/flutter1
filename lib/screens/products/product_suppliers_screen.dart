import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/supplier_provider.dart';
import '../../models/supplier.dart';

class ProductSuppliersScreen extends StatelessWidget {
  const ProductSuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SupplierProvider>(
        builder: (context, supplierProvider, child) {
          final suppliers = supplierProvider.suppliers;

          if (suppliers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No suppliers yet',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showAddEditSupplierDialog(context);
                    },
                    child: const Text('Add Supplier'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              return Card(
                child: ExpansionTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(supplier.name),
                  subtitle: Text('Products: ${supplier.productCount}'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            icon: Icons.email,
                            label: 'Email',
                            value: supplier.email,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            icon: Icons.phone,
                            label: 'Phone',
                            value: supplier.phone,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            icon: Icons.location_on,
                            label: 'Address',
                            value: supplier.address,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit'),
                                onPressed: () {
                                  _showAddEditSupplierDialog(
                                    context,
                                    supplier: supplier,
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              TextButton.icon(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  _showDeleteDialog(context, supplier);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditSupplierDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(value),
          ],
        ),
      ],
    );
  }

  void _showAddEditSupplierDialog(BuildContext context, {Supplier? supplier}) {
    final nameController = TextEditingController(text: supplier?.name);
    final emailController = TextEditingController(text: supplier?.email);
    final phoneController = TextEditingController(text: supplier?.phone);
    final addressController = TextEditingController(text: supplier?.address);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(supplier == null ? 'Add Supplier' : 'Edit Supplier'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newSupplier = Supplier(
                  id: supplier?.id ?? DateTime.now().millisecondsSinceEpoch,
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  productCount: supplier?.productCount ?? 0,
                  createdAt: supplier?.createdAt ?? DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                if (supplier != null) {
                  Provider.of<SupplierProvider>(context, listen: false)
                      .updateSupplier(newSupplier);
                } else {
                  Provider.of<SupplierProvider>(context, listen: false)
                      .addSupplier(newSupplier);
                }

                Navigator.pop(context);
              }
            },
            child: Text(supplier == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Supplier supplier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Supplier'),
        content: Text(
          'Are you sure you want to delete "${supplier.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<SupplierProvider>(context, listen: false)
                  .deleteSupplier(supplier.id);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
