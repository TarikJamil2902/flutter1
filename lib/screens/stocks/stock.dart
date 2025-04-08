import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class MainStockScreen extends StatelessWidget {
  const MainStockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Stock"),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/addProduct");
                    // TODO: Navigate to add product screen
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Product"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                const Text(
                  "Brand Wise",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate or show stocks
                  },
                  icon: const Icon(Icons.list),
                  label: const Text("All Stocks"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: Colors.grey.shade300,
              child: const Text(
                "All Product Stocks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    Colors.blue.shade50,
                  ),
                  border: TableBorder.all(color: Colors.blue),
                  columns: const [
                    DataColumn(label: Text("Serial")),
                    DataColumn(label: Text("ID")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Unit")),
                    DataColumn(label: Text("Brand")),
                    DataColumn(label: Text("Total Purchase")),
                    DataColumn(label: Text("Available Stock")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: const [
                    // Sample row
                    DataRow(
                      cells: [
                        DataCell(Text("1")),
                        DataCell(Text("P001")),
                        DataCell(Text("Shirt")),
                        DataCell(Text("pcs")),
                        DataCell(Text("Brand A")),
                        DataCell(Text("100")),
                        DataCell(Text("85")),
                        DataCell(Text("Edit/Delete")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StockInScreen extends StatefulWidget {
  const StockInScreen({super.key});

  @override
  State<StockInScreen> createState() => _StockInScreenState();
}

class _StockInScreenState extends State<StockInScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedBrand;
  String? selectedProduct;
  String? selectedSupplier;
  String? selectedPaymentMethod;
  DateTime? selectedDate;

  TextEditingController dateController = TextEditingController();

  // Table Fields
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController availableStockController =
      TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock In'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Top Dropdown Section
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      "Brand",
                      ["Brand A", "Brand B"],
                      selectedBrand,
                      (val) => setState(() => selectedBrand = val),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdown(
                      "Product",
                      ["Product X", "Product Y"],
                      selectedProduct,
                      (val) => setState(() => selectedProduct = val),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdown(
                      "Supplier",
                      ["Supplier 1", "Supplier 2"],
                      selectedSupplier,
                      (val) => setState(() => selectedSupplier = val),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildDatePicker(context)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdown(
                      "Payment Method",
                      ["Cash", "Card", "Online"],
                      selectedPaymentMethod,
                      (val) => setState(() => selectedPaymentMethod = val),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Table Input Section
              _buildTableInputs(),
              const SizedBox(height: 20),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle Save Logic
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selected,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.blue[50],
      ),
      value: selected,
      onChanged: onChanged,
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Date",
        filled: true,
        fillColor: Colors.blue[50],
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
            dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
          });
        }
      },
    );
  }

  Widget _buildTableInputs() {
    return Column(
      children: [
        _buildTextField("Product Name", productNameController),
        _buildTextField("Brand", brandController),
        _buildTextField(
          "Available Stock",
          availableStockController,
          isNumber: true,
        ),
        _buildTextField("Unit", unitController),
        _buildTextField("Price", priceController, isNumber: true),
        _buildTextField("Quantity", quantityController, isNumber: true),
        _buildTextField("Total", totalController, isNumber: true),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.blue[50],
        ),
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}

class StockInPendingScreen extends StatelessWidget {
  const StockInPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock In Pending"),
        backgroundColor: Colors.lightBlue,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/user_avatar.png',
            ), // Add your image
          ),
          SizedBox(width: 10),
          Center(child: Text("Test User", style: TextStyle(fontSize: 16))),
          SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        // Side menu icon
        child: DreawerWidget(),
      ),
      body: Column(
        children: [
          _buildTopMenu(),
          const Divider(),
          Expanded(child: _buildDataTable()),
        ],
      ),
    );
  }

  Widget _buildTopMenu() {
    final menuItems = [
      "Main Stock",
      "Product List",
      "Category List",
      "Sales Report",
      "Invoice List",
      "Expense List",
      "Link",
    ];
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Wrap(
        spacing: 10,
        children:
            menuItems
                .map(
                  (item) => ElevatedButton(onPressed: () {}, child: Text(item)),
                )
                .toList(),
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Serial')),
          DataColumn(label: Text('Id')),
          DataColumn(label: Text('Product Name')),
          DataColumn(label: Text('Product Id')),
          DataColumn(label: Text('Brand Name')),
          DataColumn(label: Text('Product Unit')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Supplier Name')),
          DataColumn(label: Text('Payment Method')),
          DataColumn(label: Text('Total')),
          DataColumn(label: Text('Action')),
        ],
        rows: const [
          // Example row – can be dynamic
          // DataRow(cells: [
          //   DataCell(Text('1')),
          //   DataCell(Text('101')),
          //   DataCell(Text('Shirt')),
          //   DataCell(Text('PRD1001')),
          //   DataCell(Text('BrandX')),
          //   DataCell(Text('PCS')),
          //   DataCell(Text('500')),
          //   DataCell(Text('10')),
          //   DataCell(Text('Supplier Y')),
          //   DataCell(Text('Cash')),
          //   DataCell(Text('5000')),
          //   DataCell(Row(children: [Icon(Icons.check), Icon(Icons.close)])),
          // ])
        ],
      ),
    );
  }
}

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice List"),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        actions: [
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/user_avatar.png"),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: Text("Test User", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: Column(
        children: [
          _buildTopMenu(),
          const SizedBox(height: 10),
          Expanded(child: _buildInvoiceTable()),
        ],
      ),
    );
  }

  Widget _buildTopMenu() {
    final menuItems = [
      "Main Stock",
      "Product List",
      "Category List",
      "Sales Report",
      "Invoice List",
      "Expense List",
      "Link",
    ];
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Wrap(
        spacing: 8,
        children:
            menuItems
                .map(
                  (item) => ElevatedButton(onPressed: () {}, child: Text(item)),
                )
                .toList(),
      ),
    );
  }

  Widget _buildInvoiceTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Invoice Id')),
          DataColumn(label: Text('Product Name')),
          DataColumn(label: Text('Brand Name')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Supplier Name')),
          DataColumn(label: Text('Payment Method')),
          DataColumn(label: Text('Total')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Action')),
        ],
        rows: const [
          // Example Row
          // DataRow(cells: [
          //   DataCell(Text("2025-04-08")),
          //   DataCell(Text("INV123")),
          //   DataCell(Text("T-Shirt")),
          //   DataCell(Text("BrandX")),
          //   DataCell(Text("500")),
          //   DataCell(Text("20")),
          //   DataCell(Text("ABC Traders")),
          //   DataCell(Text("Cash")),
          //   DataCell(Text("10000")),
          //   DataCell(Text("Pending")),
          //   DataCell(Row(
          //     children: [Icon(Icons.edit), Icon(Icons.delete)],
          //   )),
          // ]),
        ],
      ),
    );
  }
}

class WastageListScreen extends StatelessWidget {
  const WastageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wastage List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/addWastage");
              },
              child: const Text("Add Wastage"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Wastage #$index"),
                    subtitle: const Text("Quantity: 10"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecievedListScreen extends StatelessWidget {
  const RecievedListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recieved List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/addWastage");
              },
              child: const Text("Add Wastage"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Wastage #$index"),
                    subtitle: const Text("Quantity: 10"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
