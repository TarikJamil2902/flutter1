import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:new_flutter_app/models/item.dart';

void main() {
  runApp(FormExampleApp());
}

class FormExampleApp extends StatelessWidget {
  const FormExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo Form",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FormPage(title: "Product Add Form"),
    );
  }
}

class FormPage extends StatelessWidget {
  final String title;
  const FormPage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ItemForm(),
      ),
    );
  }
}

class ItemForm extends StatefulWidget {
  final Item? item;
  const ItemForm({this.item});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _inStock = false;
  DateTime _expirationDate = DateTime.now();
  String? _selectedCategory;

  final List<String> _categories = ['Electroics', 'Clothing', 'Groceries'];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expirationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _expirationDate)
      setState(() {
        _expirationDate = picked;
      });
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('MM-dd-yyyy').format(date);
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        id: widget.item?.id,
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        price: double.parse(_priceController.text),
        inStock: _inStock,
        expirationDate: _expirationDate,
        description: _descriptionController.text,
        category:
            _selectedCategory ??
            'Uncategorized', // Default to 'Uncategorized' if not selected
      );
      print(item.toString());

      if (widget.item == null) {
        // await DatabaseHelper2().insertItem(item);
      } else {
        // await DatabaseHelper2().updateItem(item);
      }

      // Navigator.pop(context, true); // Return to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Item Name'),
            validator: (value) => value!.isEmpty ? 'Enter item name' : null,
          ),
          TextFormField(
            controller: _quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? 'Enter quantity' : null,
          ),
          TextFormField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) => value!.isEmpty ? 'Enter price' : null,
          ),
          CheckboxListTile(
            title: Text('In Stock'),
            value: _inStock,
            onChanged: (bool? value) {
              setState(() {
                _inStock = value ?? false;
              });
            },
          ),
          ListTile(
            title: Text(
              'Expiration Date : ${getFormattedDate(_expirationDate)}',
              style: TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.calendar_today),
            onTap: () => _selectDate(context),
          ),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(labelText: 'Category'),
            items:
                _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            validator: (value) => value == null ? 'Select a category' : null,
          ),

          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveItem,
            child: Text(widget.item == null ? 'Add Item' : 'Update Item'),
          ),
        ],
      ),
    );
  }
}
