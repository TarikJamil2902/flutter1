
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(FormExampleApp());
}




class FormExampleApp extends StatelessWidget {
  const FormExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(primarySwatch: Colors.blueGrey),

      //  home: ,
     
    );
  }
}


