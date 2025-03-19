import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard/dashboard_screen.dart';
import '../products/product_list_screen.dart';
import '../categories/category_screen.dart';
import '../orders/order_screen.dart';
import '../customers/customer_screen.dart';
import '../reports/report_screen.dart';
import '../settings/settings_screen.dart';
import '../auth/login_screen.dart';

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
    return Scaffold(
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
            _buildDrawerItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              index: 0,
            ),
            _buildDrawerItem(
              icon: Icons.inventory,
              title: 'Products',
              index: 1,
            ),
            _buildDrawerItem(
              icon: Icons.category,
              title: 'Categories',
              index: 2,
            ),
            _buildDrawerItem(
              icon: Icons.shopping_cart,
              title: 'Orders',
              index: 3,
            ),
            _buildDrawerItem(
              icon: Icons.people,
              title: 'Customers',
              index: 4,
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart,
              title: 'Reports',
              index: 5,
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'Settings',
              index: 6,
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              index: 7,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: _selectedIndex < _pages.length
          ? _pages[_selectedIndex]
          : const DashboardScreen(),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: GoogleFonts.poppins(),
      ),
      selected: _selectedIndex == index,
      onTap: onTap ?? () {
        setState(() {
          if (index < _pages.length) {
            _selectedIndex = index;
          }
          Navigator.pop(context); // Close drawer
        });
      },
    );
  }
}
