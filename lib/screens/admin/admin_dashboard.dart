import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard/dashboard_screen.dart';
import '../products/product_list_screen.dart';
import '../categories/category_screen.dart';
import '../orders/order_screen.dart';
import '../customers/customer_screen.dart';
import '../reports/report_screen.dart';
import '../settings/settings_screen.dart';

void main() {
  runApp(AdminDashboard());
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const ProductListScreen(),
    const CategoryScreen(),
    const OrderScreen(),
    const CustomerScreen(),
    const ReportScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/products': (context) => const ProductListScreen(),
        '/categories': (context) => const CategoryScreen(),
        '/orders': (context) => const OrderScreen(),
        '/customers': (context) => const CustomerScreen(),
        '/reports': (context) => const ReportScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Dashboard',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 35),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Admin Panel',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                title: Text('Dashboard', style: GoogleFonts.poppins()),
                leading: Icon(Icons.dashboard),
                children: [
                  _buildDrawerItem(
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    index: 0,
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Stocks', style: GoogleFonts.poppins()),
                leading: Icon(Icons.inventory),
                children: [
                  _buildDrawerItem(
                    icon: Icons.report,
                    title: 'Stock Report 1',
                    index: 1,
                  ),
                  _buildDrawerItem(
                    icon: Icons.report,
                    title: 'Stock Report 2',
                    index: 2,
                  ),
                  _buildDrawerItem(
                    icon: Icons.add_box,
                    title: 'Stock In',
                    index: 3,
                  ),
                  _buildDrawerItem(
                    icon: Icons.outbox,
                    title: 'Stock Out',
                    index: 4,
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Products', style: GoogleFonts.poppins()),
                leading: Icon(Icons.category),
                children: [
                  _buildDrawerItem(
                    icon: Icons.list,
                    title: 'Products List',
                    index: 5,
                    path: "/products",
                  ),
                  _buildDrawerItem(
                    icon: Icons.add,
                    title: 'Add Product',
                    index: 6,
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Sales', style: GoogleFonts.poppins()),
                leading: Icon(Icons.shopping_cart),
                children: [
                  _buildDrawerItem(
                    icon: Icons.bar_chart,
                    title: 'Sales Report',
                    index: 7,
                  ),
                  _buildDrawerItem(
                    icon: Icons.receipt,
                    title: 'Invoice',
                    index: 8,
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Due Reports', style: GoogleFonts.poppins()),
                leading: Icon(Icons.people),
                children: [
                  _buildDrawerItem(
                    icon: Icons.report,
                    title: 'Due Report 1',
                    index: 9,
                  ),
                  _buildDrawerItem(
                    icon: Icons.report,
                    title: 'Due Report 2',
                    index: 10,
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Payments', style: GoogleFonts.poppins()),
                leading: Icon(Icons.payment),
                children: [
                  _buildDrawerItem(
                    icon: Icons.payment,
                    title: 'Payments Report',
                    index: 11,
                  ),
                  _buildDrawerItem(
                    icon: Icons.history,
                    title: 'Payment History',
                    index: 12,
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('CRM', style: GoogleFonts.poppins()),
                leading: Icon(Icons.supervisor_account),
                children: [
                  _buildDrawerItem(
                    icon: Icons.group,
                    title: 'Customer Relationships',
                    index: 13,
                  ),
                ],
              ),
              _buildDrawerItem(
                icon: Icons.settings,
                title: 'Settings',
                index: 14,
              ),
              _buildDrawerItem(
                icon: Icons.logout,
                title: 'Logout',
                index: 15,
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        body:
            _selectedIndex < _pages.length
                ? _pages[_selectedIndex]
                : const DashboardScreen(),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
    VoidCallback? onTap,
    String? path,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: GoogleFonts.poppins()),
      selected: _selectedIndex == index,
      onTap: () {
        if (path != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context, rootNavigator: true).pushNamed(path);
          });
        }
      },
    );
  }
}
