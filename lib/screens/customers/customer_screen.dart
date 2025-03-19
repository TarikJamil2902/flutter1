import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> customers = [
      {
        'name': 'John Doe',
        'email': 'john.doe@email.com',
        'phone': '+880 1712345678',
        'orders': 5,
        'totalSpent': 1299.99,
      },
      {
        'name': 'Jane Smith',
        'email': 'jane.smith@email.com',
        'phone': '+880 1812345678',
        'orders': 3,
        'totalSpent': 799.50,
      },
      {
        'name': 'Robert Johnson',
        'email': 'robert.j@email.com',
        'phone': '+880 1912345678',
        'orders': 8,
        'totalSpent': 2499.99,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customers',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement customer search
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // TODO: Add new customer
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return _buildCustomerCard(customer);
        },
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  child: Text(
                    customer['name'].substring(0, 1).toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        customer['email'],
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // TODO: Handle menu item selection
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoColumn(
                  icon: Icons.phone,
                  label: 'Phone',
                  value: customer['phone'],
                ),
                _buildInfoColumn(
                  icon: Icons.shopping_bag,
                  label: 'Orders',
                  value: '${customer['orders']}',
                ),
                _buildInfoColumn(
                  icon: Icons.attach_money,
                  label: 'Total Spent',
                  value: '\$${customer['totalSpent'].toStringAsFixed(2)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
