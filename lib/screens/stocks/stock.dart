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
