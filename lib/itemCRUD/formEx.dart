import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:new_flutter_app/db/database_helper.dart';
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
  final Item? item;
  const FormPage({required this.title, this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ItemForm(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemForm(item: item)),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemListPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemForm extends StatefulWidget {
  final Item? item;
  const ItemForm({super.key, this.item});

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
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _priceController.text = widget.item!.price.toString();
      _quantityController.text = widget.item!.quantity.toString();
      _inStock = widget.item!.inStock;
      _expirationDate = widget.item!.expirationDate;
      _selectedCategory = widget.item!.category;
      _descriptionController.text = widget.item!.description;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expirationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _expirationDate) {
      setState(() {
        _expirationDate = picked;
      });
    }
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
        await DatabaseHelper2().insertItem(item);
      } else {
        await DatabaseHelper2().updateItem(item);
      }

      // Navigator.pop(context, true); // Return to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                validator:
                    (value) => value == null ? 'Select a category' : null,
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
        ),
      ),
    );
  }
}

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  late Future<List<Item>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = DatabaseHelper2().getAllItems();
    print(_itemsFuture.toString()); // Fetch items from DB
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item List')),
      body: FutureBuilder<List<Item>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found'));
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text(
                  'Category: ${item.category}, Price: \$${item.price}',
                ),
                onTap: () {
                  // Navigate to form for editing
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              FormPage(title: "Add Student", item: item),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper2().deleteItem(item.id);
                    setState(() {
                      _itemsFuture = DatabaseHelper2().getAllItems();
                    });
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(title: "Add Student"),
            ),
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Add')));
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add), // You can use different icons or custom widgets
      ),
    );
  }
}
