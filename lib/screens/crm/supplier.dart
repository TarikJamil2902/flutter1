import 'package:flutter/material.dart';

class SupplierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Suppliers')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Distributor $index'), onTap: () {});
        },
      ),
    );
  }
}
