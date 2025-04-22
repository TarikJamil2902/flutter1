import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellInvoiceScreen extends StatefulWidget {
  const SellInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<SellInvoiceScreen> createState() => _SellInvoiceScreenState();
}

class _SellInvoiceScreenState extends State<SellInvoiceScreen> {
  final TextEditingController dateController =
      TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController customerController = TextEditingController();

  String? selectedSeller;
  String? selectedDistributor;

  List<String> sellers = ['Rakib', 'Tarik', 'Shakib'];
  List<String> distributors = ['Distributor A', 'Distributor B'];

  List<Map<String, dynamic>> saleDetails = [];

  double grandTotal = 0.0;

  @override
  void initState() {
    super.initState();
    addNewSaleDetail();
  }

  void addNewSaleDetail() {
    setState(() {
      saleDetails.add({
        'brand': null,
        'category': null,
        'product': null,
        'productsList': [],
        'price': 0.0,
        'quantity': 1,
        'total': 0.0,
      });
    });
  }

  void updateTotal(int index) {
    final detail = saleDetails[index];
    double quantity = detail['quantity'] ?? 1;
    double price = detail['price'] ?? 0;
    double total = quantity * price;

    setState(() {
      saleDetails[index]['total'] = total;
      calculateGrandTotal();
    });
  }

  void calculateGrandTotal() {
    grandTotal = saleDetails.fold(0.0, (sum, item) => sum + (item['total'] ?? 0));
  }

  void removeSaleDetail(int index) {
    setState(() {
      saleDetails.removeAt(index);
      calculateGrandTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sell Invoice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Date'),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                }
              },
            ),
            TextField(
              controller: referenceController,
              decoration: const InputDecoration(labelText: 'Reference No.'),
            ),
            TextField(
              controller: customerController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            DropdownButtonFormField<String>(
              value: selectedDistributor,
              decoration: const InputDecoration(labelText: 'Distributor'),
              items: distributors.map((dist) {
                return DropdownMenuItem(value: dist, child: Text(dist));
              }).toList(),
              onChanged: (val) => setState(() => selectedDistributor = val),
            ),
            DropdownButtonFormField<String>(
              value: selectedSeller,
              decoration: const InputDecoration(labelText: 'Seller'),
              items: sellers.map((seller) {
                return DropdownMenuItem(value: seller, child: Text(seller));
              }).toList(),
              onChanged: (val) => setState(() => selectedSeller = val),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Sale Details', style: TextStyle(fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: saleDetails.length,
              itemBuilder: (context, index) {
                final detail = saleDetails[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: detail['brand'],
                          decoration: const InputDecoration(labelText: 'Brand'),
                          items: ['Brand A', 'Brand B']
                              .map((brand) => DropdownMenuItem(value: brand, child: Text(brand)))
                              .toList(),
                          onChanged: (val) {
                            setState(() => detail['brand'] = val);
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: detail['category'],
                          decoration: const InputDecoration(labelText: 'Category'),
                          items: ['Cat A', 'Cat B']
                              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                              .toList(),
                          onChanged: (val) {
                            setState(() => detail['category'] = val);
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: detail['product'],
                          decoration: const InputDecoration(labelText: 'Product'),
                          items: ['Prod 1', 'Prod 2']
                              .map((prod) => DropdownMenuItem(value: prod, child: Text(prod)))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              detail['product'] = val;
                              detail['price'] = 100.0; // Simulated unit price
                              updateTotal(index);
                            });
                          },
                        ),
                        TextFormField(
                          initialValue: detail['quantity'].toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Quantity'),
                          onChanged: (val) {
                            detail['quantity'] = int.tryParse(val) ?? 1;
                            updateTotal(index);
                          },
                        ),
                        Text('Unit Price: ${detail['price']}'),
                        Text('Total: ${detail['total']}'),
                        TextButton.icon(
                          onPressed: () => removeSaleDetail(index),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text('Remove', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ElevatedButton.icon(
              onPressed: addNewSaleDetail,
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            ),
            const SizedBox(height: 20),
            Text('Grand Total: $grandTotal',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Add API submission logic here
              },
              child: const Text('Submit Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}
