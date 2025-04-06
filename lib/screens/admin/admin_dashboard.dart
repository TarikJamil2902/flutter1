import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_flutter_app/screens/stocks/drawer.dart';
import 'package:new_flutter_app/screens/stocks/stock.dart';
import '../dashboard/dashboard_screen.dart';
import '../stocks/product_list_screen.dart';
import '../stocks/category_screen.dart';
import '../sales/order_screen.dart';
import '../crm/customer_screen.dart';
import '../reports/report_screen.dart';
import '../settings/settings_screen.dart';

void main() {
  runApp(MyProject());
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/adminDashboard',
      routes: {
        // '/login': (context) => const LoginScreen(),
        '/adminDashboard': (context) => AdminDash2(),
        '/dashboard': (context) => DashboardScreen(),
        '/products': (context) => ProductListScreen(),
        '/categories': (context) => CategoryScreen(),
        '/orders': (context) => OrderScreen(),
        '/customers': (context) => CustomerScreen(),
        '/stocks': (context) => MainStockScreen(),
        '/reports': (context) => ReportScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

class AdminDash2 extends StatefulWidget {
  const AdminDash2({super.key});

  @override
  State<AdminDash2> createState() => _AdminDash2State();
}

class _AdminDash2State extends State<AdminDash2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      drawer: Drawer(child: DreawerWidget()),
      body: const DashboardScreen(),
    );
  }

  // Widget _buildDrawerItem({
  //   required IconData icon,
  //   required String title,
  //   VoidCallback? onTap,
  //   required String path,
  // }) {
  //   return ListTile(
  //     leading: Icon(icon),
  //     title: Text(title, style: GoogleFonts.poppins()),
  //     onTap: () {
  //       Navigator.pushNamed(context, path);

  // if (path != null) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Navigator.of(context, rootNavigator: true).pushNamed(path);
  //   });
  // }
}

// class AdminDashboard extends StatefulWidget {
//   const AdminDashboard({super.key});

//   @override
//   State<AdminDashboard> createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const DashboardScreen(),
//     const ProductListScreen(),
//     const CategoryScreen(),
//     const OrderScreen(),
//     const CustomerScreen(),
//     const ReportScreen(),
//     const SettingsScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         // '/login': (context) => const LoginScreen(),
//         '/dashboard': (context) => const DashboardScreen(),
//         '/products': (context) => const ProductListScreen(),
//         '/categories': (context) => const CategoryScreen(),
//         '/orders': (context) => const OrderScreen(),
//         '/customers': (context) => const CustomerScreen(),
//         '/reports': (context) => const ReportScreen(),
//         '/settings': (context) => const SettingsScreen(),
//       },
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Admin Dashboard',
//             style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//           ),
//         ),
//         drawer: Drawer(
//           child: DreawerWidget(),
//         ),
//         body:
//             _selectedIndex < _pages.length
//                 ? _pages[_selectedIndex]
//                 : const DashboardScreen(),
//       ),
//     );
//   }
