// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Distributor {
//   final int id;
//   final String name;

//   Distributor({required this.id, required this.name});

//   factory Distributor.fromJson(Map<String, dynamic> json) {
//     return Distributor(id: json['id'], name: json['name']);
//   }
// }

// class Product {
//   final int id;
//   final String name;

//   Product({required this.id, required this.name});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(id: json['id'], name: json['name']);
//   }
// }

// class DistributorProduct {
//   final int? id;
//   final int distributorId;
//   final int productId;
//   final int totalQuantity;
//   final int currentQuantity;
//   final int mrp;
//   final int retailRate;

//   DistributorProduct({
//     this.id,
//     required this.distributorId,
//     required this.productId,
//     required this.totalQuantity,
//     required this.currentQuantity,
//     required this.mrp,
//     required this.retailRate,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'distributor_id': distributorId,
//       'product_id': productId,
//       'total_quantity': totalQuantity,
//       'current_quantity': currentQuantity,
//       'mrp': mrp,
//       'retail_rate': retailRate,
//     };
//   }
// }

// class DistributorProductScreen extends StatefulWidget {
//   @override
//   _DistributorProductScreenState createState() => _DistributorProductScreenState();
// }

// class _DistributorProductScreenState extends State<DistributorProductScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<Distributor> distributors = [];
//   List<Product> products = [];
//   List<dynamic> assignedProducts = [];

//   int? selectedDistributorId;
//   int? selectedProductId;
//   final TextEditingController totalQtyController = TextEditingController();
//   final TextEditingController currentQtyController = TextEditingController();
//   final TextEditingController mrpController = TextEditingController();
//   final TextEditingController retailRateController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     fetchDistributors();
//     fetchProducts();
//   }

//   Future<void> fetchDistributors() async {
//     final response = await http.get(Uri.parse('http://localhost:8080/distributor/getAll'));
//     if (response.statusCode == 200) {
//       setState(() {
//         distributors = List.from(json.decode(response.body)).map((e) => Distributor.fromJson(e)).toList();
//       });
//     }
//   }

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse('http://localhost:8080/product/getAll'));
//     if (response.statusCode == 200) {
//       setState(() {
//         products = List.from(json.decode(response.body)).map((e) => Product.fromJson(e)).toList();
//       });
//     }
//   }

//   Future<void> fetchAssignedProducts() async {
//     if (selectedDistributorId == null) return;
//     final response = await http.get(Uri.parse('http://localhost:8080/distributorProducts/getByDistributor/$selectedDistributorId'));
//     if (response.statusCode == 200) {
//       setState(() {
//         assignedProducts = json.decode(response.body);
//       });
//     }
//   }

//   Future<void> assignProduct() async {
//     final dp = DistributorProduct(
//       distributorId: selectedDistributorId!,
//       productId: selectedProductId!,
//       totalQuantity: int.parse(totalQtyController.text),
//       currentQuantity: int.parse(currentQtyController.text),
//       mrp: int.parse(mrpController.text),
//       retailRate: int.parse(retailRateController.text),
//     );

//     final response = await http.post(
//       Uri.parse('http://localhost:8080/distributorProducts/save'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(dp.toJson()),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Assigned successfully!")));
//       totalQtyController.clear();
//       currentQtyController.clear();
//       mrpController.clear();
//       retailRateController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Distributor Product Management"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: "Assign Product"),
//             Tab(text: "Assigned Products"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 DropdownButtonFormField(
//                   value: selectedDistributorId,
//                   hint: Text("Select Distributor"),
//                   items: distributors.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
//                   onChanged: (value) => setState(() => selectedDistributorId = value as int?),
//                 ),
//                 DropdownButtonFormField(
//                   value: selectedProductId,
//                   hint: Text("Select Product"),
//                   items: products.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
//                   onChanged: (value) => setState(() => selectedProductId = value as int?),
//                 ),
//                 TextField(controller: totalQtyController, decoration: InputDecoration(labelText: "Total Quantity"), keyboardType: TextInputType.number),
//                 TextField(controller: currentQtyController, decoration: InputDecoration(labelText: "Current Quantity"), keyboardType: TextInputType.number),
//                 TextField(controller: mrpController, decoration: InputDecoration(labelText: "MRP"), keyboardType: TextInputType.number),
//                 TextField(controller: retailRateController, decoration: InputDecoration(labelText: "Retail Rate"), keyboardType: TextInputType.number),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: assignProduct,
//                   child: Text("Assign Product"),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 DropdownButtonFormField(
//                   value: selectedDistributorId,
//                   hint: Text("Select Distributor"),
//                   items: distributors.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
//                   onChanged: (value) async {
//                     setState(() => selectedDistributorId = value as int?);
//                     await fetchAssignedProducts();
//                   },
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: assignedProducts.length,
//                     itemBuilder: (context, index) {
//                       final item = assignedProducts[index];
//                       return ListTile(
//                         title: Text(item['product_name'] ?? 'N/A'),
//                         subtitle: Text("Qty: ${item['current_quantity']} / ${item['total_quantity']}"),
//                         trailing: Text("MRP: ${item['mrp']}, Retail: ${item['retail_rate']}"),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
