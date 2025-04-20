import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AllPaymentsScreen extends StatefulWidget {
  const AllPaymentsScreen({super.key});

  @override
  State<AllPaymentsScreen> createState() => _AllPaymentsScreenState();
}

class _AllPaymentsScreenState extends State<AllPaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Payments',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Payment ${index + 1}',
              style: GoogleFonts.roboto(fontSize: 18),
            ),
            subtitle: Text(
              DateFormat('dd MMM yyyy').format(DateTime.now()),
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            trailing: Text('Rs. 1000', style: GoogleFonts.roboto(fontSize: 16)),
          );
        },
      ),
    );
  }
}

class RecentPayments extends StatelessWidget {
  const RecentPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Payments', style: GoogleFonts.poppins()),
      ),
      body: Center(
        child: Text('Recent Payments', style: GoogleFonts.poppins()),
      ),
    );
  }
}
