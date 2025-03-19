import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/category_provider.dart';
import 'providers/supplier_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/products/product_list_screen.dart';
import 'screens/products/add_edit_product_screen.dart';
import 'screens/categories/category_screen.dart';
import 'screens/orders/order_screen.dart';
import 'screens/customers/customer_screen.dart';
import 'screens/reports/report_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => SupplierProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const LoginScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/admin': (context) => const AdminDashboard(),
          '/dashboard': (context) => const DashboardScreen(),
          '/products': (context) => const ProductListScreen(),
          '/products/add': (context) => const AddEditProductScreen(),
          '/categories': (context) => const CategoryScreen(),
          '/orders': (context) => const OrderScreen(),
          '/customers': (context) => const CustomerScreen(),
          '/reports': (context) => const ReportScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppbar({super.key, required this.title});

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
            Navigator.pushNamed(context, '/admin');
          },
          icon: Icon(Icons.home),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/products');
          },
          icon: Icon(Icons.pageview),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/products/add');
          },
          icon: Icon(Icons.cyclone),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          icon: Icon(Icons.login),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/admin');
          },
          icon: Icon(Icons.logout),
        ),

        SizedBox(width: 10),
      ],
    );
  }
}

class Practice1 extends StatelessWidget {
  const Practice1({super.key});

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
      drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Tarik Jamil"),
            accountEmail: Text("tj@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/MyPhoto.jpg",
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              // Navigator.pushNamed(context, '/home');

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
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
      drawer: MyDrawer(),
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
      drawer: MyDrawer(),
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
      drawer: MyDrawer(),
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
      drawer: MyDrawer(),
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
      drawer: MyDrawer(),
    );
  }
}
