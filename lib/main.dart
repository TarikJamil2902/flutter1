import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/category_provider.dart';
import 'providers/supplier_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/stocks/product_list_screen.dart';
import 'screens/stocks/add_edit_product_screen.dart';
import 'screens/stocks/category_screen.dart';
import 'screens/sales/order_screen.dart';
import 'screens/crm/customer_screen.dart';
import 'screens/reports/report_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => SupplierProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: AdminDash2(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/admin': (context) => const AdminDash2(),
          '/dashboard': (context) => const DashboardScreen(),
          '/products': (context) => const ProductListScreen(),
          '/products/add': (context) => const AddEditProductScreen(),
          '/categories': (context) => const CategoryScreen(),
          '/orders': (context) => const OrderScreen(),
          '/customers': (context) => const CustomerScreen(),
          '/reports': (context) => const ReportScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
