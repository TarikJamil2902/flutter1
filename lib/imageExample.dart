// ignore: file_names
import 'package:flutter/material.dart';
import 'package:new_flutter_app/main.dart';

void main() => runApp(Practice6(loadFromNetwork: false));

class Practice6 extends StatelessWidget {
  final bool loadFromNetwork;
  Practice6({required this.loadFromNetwork});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppbar(title: "Practice6"),
        drawer: MyDrawer(),
        body: Center(
          child:
              loadFromNetwork
                  ? Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSymIX9nnyHCZoUUNG_ZTfxZOSa6GfqGgQDgg&s', // Network image URL
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    'assets/images/img2.jpg', // Asset image path
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
        ),
      ),
    );
  }
}
