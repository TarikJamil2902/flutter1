import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DreawerWidget extends StatelessWidget {
  const DreawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerItem({
      required IconData icon,
      required String title,
      VoidCallback? onTap,
      String? path,
    }) {
      return ListTile(
        leading: Icon(icon),
        title: Text(title, style: GoogleFonts.poppins()),
        onTap: () {
          if (path != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context, rootNavigator: true).pushNamed(path);
            });
          }
        },
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
          path: '/adminDashboard',
        ),
        ExpansionTile(
          title: Text('Stocks', style: GoogleFonts.poppins()),
          leading: Icon(Icons.inventory),
          children: [
            _buildDrawerItem(
              icon: Icons.report,
              title: 'Main Stock',
              path: '/stocks',
            ),

            _buildDrawerItem(
              icon: Icons.pending_actions,
              title: "Stock In Pending",
              path: '/pendingStock',
            ),
            _buildDrawerItem(
              icon: Icons.receipt,
              title: "Stock In Invoice",
              path: '/stockInvoice',
            ),
            _buildDrawerItem(
              icon: Icons.list,
              title: 'Brand list',
              path: '/brands',
            ),
            _buildDrawerItem(
              icon: Icons.list,
              title: 'Category list',
              path: '/wastage',
            ),
            _buildDrawerItem(
              icon: Icons.list,
              title: 'Wastage list',
              path: '/wastage',
            ),
            _buildDrawerItem(
              icon: Icons.list,
              title: 'Received Stock',
              path: '/recieved',
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Sales', style: GoogleFonts.poppins()),
          leading: Icon(Icons.shopping_cart),
          children: [
            _buildDrawerItem(icon: Icons.add, title: 'Sales', path: '/reports'),
            _buildDrawerItem(
              icon: Icons.bar_chart,
              title: 'Sales List',
              path: '/reports',
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart,
              title: 'Sales Return List',
              path: '/reports',
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart,
              title: 'Daily Sales',
              path: '/reports',
            ),
            _buildDrawerItem(
              icon: Icons.receipt,
              title: 'Sales Invoice',
              path: '/invoice',
            ),
          ],
        ),
        _buildDrawerItem(
          icon: Icons.report,
          title: 'Reports',
          path: '/reports',
        ),
        ExpansionTile(
          title: Text('Payments', style: GoogleFonts.poppins()),
          leading: Icon(Icons.payment),
          children: [
            _buildDrawerItem(
              icon: Icons.payment,
              title: 'All Payment',
              path: '/allPayments',
            ),
            _buildDrawerItem(
              icon: Icons.history,
              title: 'Recent Payment',
              path: '/recentPayments',
            ),
          ],
        ),
        ExpansionTile(
          title: Text('CRM', style: GoogleFonts.poppins()),
          leading: Icon(Icons.supervisor_account),
          children: [
            _buildDrawerItem(
              icon: Icons.group,
              title: 'Customer List',
              path: '/customers',
            ),
            _buildDrawerItem(
              icon: Icons.group,
              title: 'Supplier List',
              path: '/supplierList',
            ),
            _buildDrawerItem(
              icon: Icons.group,
              title: 'Staff List',
              path: '/staff',
            ),
            _buildDrawerItem(
              icon: Icons.group,
              title: 'Distributor List',
              path: '/distributorList',
            ),
            _buildDrawerItem(
              icon: Icons.group,
              title: 'Warehouse List',
              path: '/wareHouse',
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Users', style: GoogleFonts.poppins()),
          leading: Icon(Icons.people),
          children: [
            _buildDrawerItem(
              icon: Icons.group,
              title: 'Login Registers',
              path: '/customers',
            ),
          ],
        ),
        _buildDrawerItem(
          icon: Icons.settings,
          title: 'Settings',
          path: '/settings',
        ),
        _buildDrawerItem(
          icon: Icons.logout,
          title: 'Logout',
          path: '/login',
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
