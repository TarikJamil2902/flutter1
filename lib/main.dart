import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_flutter_app/screens/crm/distributor.dart';
import 'package:new_flutter_app/screens/crm/staff.dart';
import 'package:new_flutter_app/screens/crm/supplier.dart';
import 'package:new_flutter_app/screens/crm/warehouselist.dart';
import 'package:new_flutter_app/screens/payments/allpayments.dart';
import 'package:new_flutter_app/screens/stocks/brand_screen.dart';
import 'package:new_flutter_app/screens/stocks/stock.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/category_provider.dart';
import 'providers/supplier_provider.dart';
import 'models/brand.dart';
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
        ChangeNotifierProvider(create: (_) => BrandProvider()),
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
          '/adminDashboard': (context) => AdminDash2(),
          '/dashboard': (context) => DashboardScreen(),
          '/products': (context) => ProductListScreen(),
          '/categories': (context) => CategoryScreen(),
          '/orders': (context) => OrderScreen(),
          '/customers': (context) => CustomerScreen(),
          '/stocks': (context) => MainStockScreen(),
          '/pendingStock': (context) => StockInPendingScreen(),
          '/stockInvoice': (context) => InvoiceListScreen(),
          '/wastage': (context) => WastageListScreen(),
          '/recieved': (context) => RecievedListScreen(),
          '/addProduct': (context) => StockInScreen(),
          '/reports': (context) => ReportScreen(),
          '/allPayments': (context) => AllPaymentsScreen(),
          '/recentPayments': (context) => RecentPayments(),
          '/distributorList': (context) => DistributorListPage(),
          '/supplierList': (context) => SupplierPage(),
          '/wareHouse': (context) => WarehouseScreen(),
          '/staff': (context) => AddStaffForm(),
          '/settings': (context) => SettingsScreen(),
          '/addBrand': (context) => AddBrandForm(),
          '/brands': (context) => BrandScreen(),
        },
      ),
    );
  }
}
