// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(AdminDashboardApp());
// }

// class AdminDashboardApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Admin Panel',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.grey[200],
//       ),
//       home: AdminDashboard(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class AdminDashboard extends StatelessWidget {
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Admin Panel"),
//         actions: [
//           CircleAvatar(
//             backgroundImage: AssetImage('assets/user.png'), // Add your image
//           ),
//           SizedBox(width: 10),
//           Center(child: Text("Test User")),
//           SizedBox(width: 20),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               child: Text("Admin Panel", style: TextStyle(fontSize: 20)),
//               decoration: BoxDecoration(color: Colors.blue),
//             ),
//             _buildDrawerItem(Icons.dashboard, "Dashboard"),
//             ExpansionTile(
//               leading: Icon(Icons.inventory),
//               title: Text("Stocks"),
//               children: [
//                 _buildDrawerItem(Icons.report, "Stock Report 1"),
//                 _buildDrawerItem(Icons.report, "Stock Report 2"),
//                 _buildDrawerItem(Icons.add_box, "Stock In"),
//                 _buildDrawerItem(Icons.outbox, "Stock Out"),
//                 _buildDrawerItem(Icons.pending_actions, "Stock In Pending"),
//                 _buildDrawerItem(Icons.receipt, "Stock In Invoice"),
//               ],
//             ),
//             ExpansionTile(
//               leading: Icon(Icons.category),
//               title: Text("Products"),
//               children: [
//                 _buildDrawerItem(Icons.report, "Product List"),
//                 _buildDrawerItem(Icons.report, "Category List"),
//                 _buildDrawerItem(Icons.add_box, "Brand List"),
//               ],
//             ),
//             ExpansionTile(
//               leading: Icon(Icons.point_of_sale),
//               title: Text("Sales"),
//               children: [
//                 _buildDrawerItem(Icons.report, "Sales"),
//                 _buildDrawerItem(Icons.report, "Sales List"),
//                 _buildDrawerItem(Icons.add_box, "Sales Return List"),
//                 _buildDrawerItem(Icons.outbox, "Daily Sales"),
//                 _buildDrawerItem(Icons.pending_actions, "Sales Invoice"),
//               ],
//             ),
//             _buildDrawerItem(Icons.receipt_long, "Due Report"),
//             ExpansionTile(
//               leading: Icon(Icons.payment),
//               title: Text("Payments"),
//               children: [
//                 _buildDrawerItem(Icons.report, "All Payment "),
//                 _buildDrawerItem(Icons.report, "Recent Payment"),
//               ],
//             ),
//             ExpansionTile(
//               leading: Icon(Icons.supervisor_account),
//               title: Text("CRM"),
//               children: [
//                 _buildDrawerItem(Icons.report, "Customer List"),
//                 _buildDrawerItem(Icons.report, "Supplier List"),
//                 _buildDrawerItem(Icons.add_box, "Staff List"),
//               ],
//             ),
//             ExpansionTile(
//               leading: Icon(Icons.people),
//               title: Text("Users"),
//               children: [_buildDrawerItem(Icons.report, "Login Registers")],
//             ),
//             ExpansionTile(
//               leading: Icon(Icons.settings),
//               title: Text("Settings"),
//               children: [
//                 _buildDrawerItem(Icons.report, "Warehouse List"),
//                 _buildDrawerItem(Icons.report, "Distributor List"),
//               ],
//             ),

//             _buildDrawerItem(Icons.logout, "Logout"),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BarChart(
//           BarChartData(
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value, meta) {
//                     final index = value.toInt();
//                     if (index >= 0 && index < dates.length) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text(
//                           dates[index].substring(5), // Show just MM-DD
//                           style: TextStyle(fontSize: 10),
//                         ),
//                       );
//                     }
//                     return Container();
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//               topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//             ),
//             barGroups: List.generate(dates.length, (index) {
//               return BarChartGroupData(
//                 x: index,
//                 barRods: [
//                   BarChartRodData(
//                     toY: sales[index],
//                     color: Colors.blue,
//                     width: 8,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   BarChartRodData(
//                     toY: profits[index],
//                     color: Colors.green,
//                     width: 8,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ],
//               );
//             }),
//             barTouchData: BarTouchData(enabled: true),
//             gridData: FlGridData(show: true),
//             borderData: FlBorderData(show: false),
//           ),
//         ),
//       ),
//     );
//   }

//   ListTile _buildDrawerItem(IconData icon, String title) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: () {}, // Add navigation logic if needed
//     );
//   }
// }
