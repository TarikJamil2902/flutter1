import 'package:flutter/material.dart';

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

      // home: Practice3(),
      initialRoute: "/page1",
      routes: {
        "/page1": (context) => Practice1(),
        "/page2": (context) => Practice2(),
        "/page3": (context) => Practice3(),
        "/page4": (context) => Practice4(),
        "/page5": (context) => Practice5(),
        "/home": (context) => Homepage(),
      },
    );
  }
}

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  MyAppbar({required this.title});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Inventory Management"),
      titleSpacing: 10,
      toolbarHeight: 80,
      centerTitle: true,
      toolbarOpacity: 1,
      elevation: 10,
      backgroundColor: Colors.grey,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: Icon(Icons.home),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/page5');
          },
          icon: Icon(Icons.pageview),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/page1');
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/page4');
          },
          icon: Icon(Icons.cyclone),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/page2');
          },
          icon: Icon(Icons.login),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/page3');
          },
          icon: Icon(Icons.logout),
        ),

        SizedBox(width: 10),
      ],
    );
  }
}

class Practice1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Practice1"),
      body: Center(
        child: Container(
          height: double.infinity,
          width: 200.00,
          color: const Color.fromARGB(255, 160, 167, 170),
          child: Center(child: Text("Hello", style: TextStyle(fontSize: 40))),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                children: const [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    ),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Flutter",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.pageview),
              title: const Text("Practice1"),
              onTap: () {
                Navigator.pushNamed(context, '/page1');
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Practice2"),
              onTap: () {
                Navigator.pushNamed(context, '/page2');
              },
            ),
            ListTile(
              leading: const Icon(Icons.pageview),
              title: const Text("Practice3"),
              onTap: () {
                Navigator.pushNamed(context, '/page3');
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Practice4"),
              onTap: () {
                Navigator.pushNamed(context, '/page4');
              },
            ),
            ListTile(
              leading: const Icon(Icons.pageview),
              title: const Text("Practice5"),
              onTap: () {
                Navigator.pushNamed(context, '/page5');
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.pageview),
              title: const Text("Pageview"),
              onTap: () {
                Navigator.pushNamed(context, '/page5');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Practice2 extends StatelessWidget {
  const Practice2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Practice2"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 198, 209, 228),
              child: Center(child: Text("Welcome")),
            ),
            Container(
              height: 150.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 180, 199, 233),
              child: Center(child: Text("To My")),
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 126, 139, 160),
              child: Center(child: Text("Homepage")),
            ),
            Container(
              height: 100.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 198, 209, 228),
              child: Center(child: Text("Welcome")),
            ),
            Container(
              height: 150.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 180, 199, 233),
              child: Center(child: Text("To My")),
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 126, 139, 160),
              child: Center(child: Text("Homepage")),
            ),
            Container(
              height: 100.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 198, 209, 228),
              child: Center(child: Text("Welcome")),
            ),
            Container(
              height: 150.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 180, 199, 233),
              child: Center(child: Text("To My")),
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 126, 139, 160),
              child: Center(child: Text("Homepage")),
            ),
          ],
        ),
      ),
    );
  }
}

class Practice3 extends StatelessWidget {
  const Practice3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Practice3"),

      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 100.0,
              color: const Color.fromARGB(255, 198, 209, 228),
              child: Center(child: Text("Welcome")),
            ),
            Container(
              height: double.infinity,
              width: 150.0,
              color: const Color.fromARGB(255, 180, 199, 233),
              child: Center(child: Text("To My")),
            ),
            Container(
              height: double.infinity,
              width: 200.0,
              color: const Color.fromARGB(255, 126, 139, 160),
              child: Center(child: Text("Homepage")),
            ),
          ],
        ),
      ),
    );
  }
}

class Practice4 extends StatelessWidget {
  const Practice4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Practice4"),

      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,

              color: const Color.fromARGB(255, 198, 209, 228),
              child: Center(child: Text("Welcome")),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: double.infinity,

              color: const Color.fromARGB(255, 180, 199, 233),
              child: Center(child: Text("To My")),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: double.infinity,

              color: const Color.fromARGB(255, 126, 139, 160),
              child: Center(child: Text("Homepage")),
            ),
          ),
        ],
      ),
    );
  }
}

class Practice5 extends StatelessWidget {
  const Practice5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Practice5"),

      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 100.0,
                width: double.infinity,
                color: const Color.fromARGB(255, 198, 209, 228),
                child: Center(child: Text("Welcome")),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                height: 150.0,
                width: double.infinity,
                color: const Color.fromARGB(255, 180, 199, 233),
                child: Center(child: Text("To My")),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                height: 200.0,
                width: double.infinity,
                color: const Color.fromARGB(255, 126, 139, 160),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        "Homepage",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 13, 13, 14),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_to_drive),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.record_voice_over),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.alarm)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                height: 100.0,
                width: double.infinity,
                color: const Color.fromARGB(255, 198, 209, 228),
                child: Center(child: Text("Welcome")),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 150.0,
                width: double.infinity,
                color: const Color.fromARGB(255, 180, 199, 233),
                child: Center(child: Text("To My")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "homepage"),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 198, 209, 228),
              child: Center(child: Text("Welcome")),
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 180, 199, 233),
              child: Center(child: Text("To My")),
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 126, 139, 160),
              child: Center(child: Text("Homepage")),
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 198, 209, 228),
              child: Center(child: Text("Welcome")),
            ),
            Container(
              height: 200.0,
              width: double.infinity,
              color: const Color.fromARGB(255, 180, 199, 233),
              child: Center(child: Text("To My")),
            ),
          ],
        ),
      ),
    );
  }
}
