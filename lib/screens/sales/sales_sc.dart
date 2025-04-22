import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';

class SellInvoiceScreen extends StatefulWidget {
  @override
  _SellInvoiceScreenState createState() => _SellInvoiceScreenState();
}

class _SellInvoiceScreenState extends State<SellInvoiceScreen> {
  final List<Map<String, dynamic>> _products = [];
  double grandTotal = 0;

  int invoiceId = 1; // Simulate auto-increment
  String? selectedCategory;
  String? selectedBrand;
  String? selectedProduct;
  String? selectedDistributor;
  String? paymentMethod;
  DateTime? selectedDate;

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController customerAddressController =
      TextEditingController();
  final TextEditingController customerMobileController =
      TextEditingController();

  double selectedPrice = 0;
  int selectedQuantity = 0;
  double selectedTotal = 0;

  final Map<String, double> productPriceMap = {
    'Classic Blue Denim Pants': 1200,
    'Cotton Round Neck T-Shirt': 800,
    'Formal White Office Shirt': 1800,
    'Winter Knit Sweater': 2500,
    'Floral Print Long Kurti': 1500,
    'Casual Black Hoodie': 1000,
    'Summer Chiffon Saree': 3000,
    'Stylish Ladies Skirt': 2000,
    'Kids Denim Shorts': 500,
    'Elegant Evening Dress': 5000,
  };

  void calculateTotal() {
    selectedQuantity = int.tryParse(quantityController.text) ?? 0;
    selectedTotal = selectedPrice * selectedQuantity;
    setState(() {});
  }

  void addProduct() {
    if (selectedProduct != null && selectedQuantity > 0) {
      _products.add({
        'product': selectedProduct,
        'price': selectedPrice,
        'quantity': selectedQuantity,
        'total': selectedTotal,
      });
      grandTotal += selectedTotal;
      quantityController.clear();
      selectedProduct = null;
      selectedPrice = 0;
      selectedQuantity = 0;
      selectedTotal = 0;
      setState(() {});
    }
  }

  void saveInvoice() {
    double subtotal = _products.fold(0.0, (sum, item) => sum + item['total']);
    double tax = subtotal * 0.05;
    double total = subtotal + tax;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Sales Invoice'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Side: Text Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "T J Company Ltd.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "1234 Arambag,\nDhaka, 1000\nMobile: 0123456789",
                            ),
                          ],
                        ),
                      ),

                      // Right Side: Logo
                      SizedBox(
                        width: 100,
                        child: Image.asset('assets/images/logo.jpeg'),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Bill To",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(customerController.text),
                  Text(customerAddressController.text),
                  Text(customerMobileController.text),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Invoice #: ${invoiceId.toString().padLeft(7, '0')}",
                        style: TextStyle(color: Colors.purple),
                      ),
                      Text(
                        "Date: ${DateTime.now().toLocal().toString().split(' ')[0]}",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "QTY",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Unit Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Amount",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  ..._products.map(
                    (prod) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Text('${prod['quantity']}')),
                          Expanded(flex: 3, child: Text('${prod['product']}')),
                          Expanded(
                            flex: 2,
                            child: Text('${prod['price'].toStringAsFixed(2)}'),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('${prod['total'].toStringAsFixed(2)}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Subtotal: ${subtotal.toStringAsFixed(2)}"),
                          Text("Sales Tax (5%): ${tax.toStringAsFixed(2)}"),
                          Text(
                            "Total (BDT): ${total.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Payment is due in 14 days."),
                  Text("Please make checks payable to: T J Company Ltd."),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Print'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );

    setState(() {
      invoiceId++; // Simulate auto-increment
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Out', textAlign: TextAlign.center),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: invoiceId.toString().padLeft(7, '0'),
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'Invoice ID'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: customerController,
                    decoration: InputDecoration(labelText: 'Customer Name'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: customerAddressController,
                    decoration: InputDecoration(labelText: 'Customer Address'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: customerMobileController,
                    decoration: InputDecoration(labelText: 'Customer Mobile'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(labelText: 'Category'),
                    items:
                        [
                              'T-Shirts',
                              'Shirts',
                              'Pants',
                              'Jeans',
                              'Kurtis',
                              'Sarees',
                              'Jackets',
                              'Sweaters',
                              'Hoodies',
                              'Dresses',
                              'Skirts',
                              'Shorts',
                            ]
                            .map(
                              (b) => DropdownMenuItem(value: b, child: Text(b)),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => selectedCategory = value),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedBrand,
                    decoration: InputDecoration(labelText: 'Brand'),
                    items:
                        [
                              'BEXIMCO',
                              'Yellow',
                              'Aarong',
                              'Ecstasy',
                              'Sailor',
                              'Le Reve',
                              'Cats Eye',
                              'Texmart',
                              'Dorjibari',
                              'Aadi',
                              'Artisti',
                              'Richman',
                            ]
                            .map(
                              (b) => DropdownMenuItem(value: b, child: Text(b)),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => selectedBrand = value),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedProduct,
                    decoration: InputDecoration(labelText: 'Product'),
                    items:
                        productPriceMap.keys
                            .map(
                              (p) => DropdownMenuItem(value: p, child: Text(p)),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProduct = value;
                        selectedPrice = productPriceMap[value!]!;
                        calculateTotal();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedDistributor,
                    decoration: InputDecoration(labelText: 'Distributor'),
                    items:
                        ['Rakib ', 'Nazmul', 'Shakib']
                            .map(
                              (d) => DropdownMenuItem(value: d, child: Text(d)),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => selectedDistributor = value),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text:
                          selectedDate != null
                              ? selectedDate!.toString().split(' ')[0]
                              : '',
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() => selectedDate = date);
                      }
                    },
                  ),
                ),
              ],
            ),
            DropdownButtonFormField<String>(
              value: paymentMethod,
              decoration: InputDecoration(labelText: 'Payment Method'),
              items:
                  ['Cash', 'Card', 'Online']
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
              onChanged: (value) => setState(() => paymentMethod = value),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedPrice.toString(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    onChanged: (_) => calculateTotal(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Total'),
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedTotal.toString(),
                    ),
                  ),
                ),
                IconButton(onPressed: addProduct, icon: Icon(Icons.add)),
              ],
            ),
            Divider(),
            ..._products.asMap().entries.map((entry) {
              int index = entry.key;
              var product = entry.value;
              return ListTile(
                leading: Text((index + 1).toString()),
                title: Text(product['product']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: ${product['category']}'),
                    Text('Quantity: ${product['quantity']}'),
                    Text('Unit: ${product['unit']}'),
                    Text('Price: ${product['price']}'),
                  ],
                ),
                trailing: Text('Total: ${product['total']}'),
              );
            }).toList(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grand Total:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${grandTotal.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveInvoice,
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
