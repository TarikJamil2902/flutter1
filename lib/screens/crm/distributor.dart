import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class DistributorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distributor List'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Distributor $index'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DistributorDetailPage(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DistributorDetailPage extends StatelessWidget {
  final int distributorIndex;

  DistributorDetailPage(this.distributorIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distributor Details'),
      ),
      body: Center(
        child: Text(
          'Details for Distributor $distributorIndex',
          style: GoogleFonts.poppins(fontSize: 18),
        ),
      ),
    );
  }

}
