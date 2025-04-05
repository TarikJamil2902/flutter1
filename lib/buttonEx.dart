// ignore: file_names
import 'package:flutter/material.dart';
import 'package:new_flutter_app/Prac2.dart';
import 'package:new_flutter_app/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(primarySwatch: Colors.blueGrey),

      home: Practice7(),
    );
  }
}

class Practice7 extends StatelessWidget {
  const Practice7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Button Example"),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    print("ElevatedButton pressed!");
                  },
                  child: Text("ElevatedButton"),
                ),
              ),
              // TextButton Example
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    print("TextButton pressed!");
                  },
                  child: Text("TextButton"),
                ),
              ),
              // OutlinedButton Example
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    print("OutlinedButton pressed!");
                  },
                  child: Text("OutlinedButton"),
                ),
              ),
              // IconButton Example
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    print("IconButton pressed!");
                  },
                ),
              ),
              // FloatingActionButton Example
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    print("FloatingActionButton pressed!");
                  },
                  child: Icon(Icons.add),
                ),
              ),
              // MaterialButton Example
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    print("MaterialButton pressed!");
                  },
                  child: Text(
                    "MaterialButton",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
