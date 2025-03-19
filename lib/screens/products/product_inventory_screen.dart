import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../models/product.dart';

class ProductInventoryScreen extends StatelessWidget {
  const ProductInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final products = productProvider.products;

          if (products.isEmpty) {
            return const Center(
              child: Text(
                'No products in inventory',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'SKU: ${product.sku}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildStockStatus(product.quantity),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Stock: ${product.quantity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  _showAdjustStockDialog(
                                    context,
                                    product,
                                    isIncrement: false,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  _showAdjustStockDialog(
                                    context,
                                    product,
                                    isIncrement: true,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStockStatus(int quantity) {
    late final Color color;
    late final String text;

    if (quantity <= 0) {
      color = Colors.red;
      text = 'Out of Stock';
    } else if (quantity < 10) {
      color = Colors.orange;
      text = 'Low Stock';
    } else {
      color = Colors.green;
      text = 'In Stock';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showAdjustStockDialog(
    BuildContext context,
    Product product, {
    required bool isIncrement,
  }) {
    final quantityController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isIncrement ? 'Add Stock' : 'Remove Stock',
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: quantityController,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quantity';
              }
              final quantity = int.tryParse(value);
              if (quantity == null || quantity <= 0) {
                return 'Please enter a valid quantity';
              }
              if (!isIncrement && quantity > product.quantity) {
                return 'Not enough stock available';
              }
              return null;
            },
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
                final quantity = int.parse(quantityController.text);
                final updatedProduct = Product(
                  id: product.id,
                  name: product.name,
                  sku: product.sku,
                  price: product.price,
                  quantity: isIncrement
                      ? product.quantity + quantity
                      : product.quantity - quantity,
                  category: product.category,
                  description: product.description,
                  createdAt: product.createdAt,
                  updatedAt: DateTime.now(),
                );
                Provider.of<ProductProvider>(context, listen: false)
                    .updateProduct(updatedProduct);
                Navigator.pop(context);
              }
            },
            child: Text(isIncrement ? 'Add' : 'Remove'),
          ),
        ],
      ),
    );
  }
}
