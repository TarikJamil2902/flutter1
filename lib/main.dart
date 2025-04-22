import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_flutter_app/screens/auth/login_screen.dart';
import 'package:new_flutter_app/screens/crm/distributor.dart';
import 'package:new_flutter_app/screens/crm/staff.dart';
import 'package:new_flutter_app/screens/crm/supplier.dart';
import 'package:new_flutter_app/screens/crm/warehouselist.dart';
import 'package:new_flutter_app/screens/payments/allpayments.dart';
import 'package:new_flutter_app/screens/sales/sales_sc.dart';
import 'package:new_flutter_app/screens/stocks/brand_sc.dart';
import 'package:new_flutter_app/screens/stocks/category_sc.dart';
import 'package:new_flutter_app/screens/stocks/products_sc.dart';

import 'screens/admin/admin_dashboard.dart';
import 'screens/dashboard/dashboard_screen.dart';
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
    return MaterialApp(
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
      home: LoginScreen(),
      routes: {
        '/adminDashboard': (context) => AdminDash2(),
        '/dashboard': (context) => DashboardScreen(),
        '/product': (context) => ProductScreen(),
        '/categories': (context) => CategoryScreen(),
        '/customers': (context) => CustomerScreen(),
        '/reports': (context) => ReportScreen(),
        '/allPayments': (context) => AllPaymentsScreen(),
        '/recentPayments': (context) => RecentPayments(),
        '/distributorList': (context) => DistributorScreen(),
        '/supplierList': (context) => SupplierScreen(),
        '/wareHouse': (context) => WarehouseScreen(),
        '/staff': (context) => StaffScreen(),
        '/settings': (context) => SettingsScreen(),
        '/brands': (context) => BrandScreen(),
        '/sales': (context) => SellInvoiceScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
