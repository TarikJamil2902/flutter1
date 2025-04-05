import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const StoreHomePage(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Registration Form'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                // Full Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter your name'
                              : null,
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your email';
                    } else if (!RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.length < 6
                              ? 'Min 6 characters'
                              : null,
                ),
                const SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Register Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Success action here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registration Successful'),
                        ),
                      );
                    }
                  },
                  child: const Text('Register', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class StoreHomePage extends StatelessWidget {
  const StoreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('Zeymur Store'),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sale Banner
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/img2.jpg',
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
              ),

              // Category Buttons
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    categoryButton('Accessories', 'assets/images/img2.jpg'),
                    categoryButton('Hoodies', 'assets/images/img2.jpg'),
                    categoryButton('Others', 'assets/images/img2.jpg'),
                  ],
                ),
              ),

              // Featured Items
              sectionHeader('Featured Items'),
              productList(),

              // Popular Items
              sectionHeader('Popular Items'),
              productList(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepOrange,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "My Account",
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String label, String imgPath) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              imgPath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text('Show All', style: TextStyle(color: Colors.deepOrange.shade400)),
        ],
      ),
    );
  }

  Widget productList() {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          productCard('assets/images/img2.jpg', 'Beanie', 18.00),
          productCard('assets/images/img2.jpg', 'V-Neck Knit', 29.00),
        ],
      ),
    );
  }

  Widget productCard(String img, String name, double price) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.asset(
                img,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      Icon(Icons.star_half, size: 16, color: Colors.orange),
                      Icon(Icons.star_border, size: 16, color: Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('\$$price'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Practice11 extends StatelessWidget {
  const Practice11({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material app'),
          backgroundColor: Colors.grey,
        ),
        body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            Container(
              color: Colors.lime,
              height: 250,
              width: 250,
              child: Image.asset("assets/images/img2.jpg"),
            ),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  "Hello",
                  style: TextStyle(
                    fontSize: 40,
                    color: const Color.fromARGB(255, 175, 12, 12),
                  ),
                ),
              ),
            ),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("Clicked");
                  },
                  child: Text("Press Me"),
                ),
              ),
            ),
            Container(
              color: Colors.lime,
              height: 250,
              width: 250,
              child: Image.asset("assets/images/img2.jpg"),
            ),
            Container(
              color: Colors.lime,
              height: 250,
              width: 250,
              child: Image.asset("assets/images/img2.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}

class Practice10 extends StatelessWidget {
  const Practice10({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Layout Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grid View Example'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
            children: List.generate(9, (index) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/images/img2.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Item $index",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // print("Clicked Item $index");
                          displayToastMessage("Item $index clicked");
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Button $index"),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

displayToastMessage(String message) {
  Fluttertoast.showToast(msg: message);
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
          child: Center(
            child: Text(
              "Hello",
              style: TextStyle(fontFamily: 'Vogue', fontSize: 40),
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class Practice20 extends StatelessWidget {
  const Practice20({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material app',
      home: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Clicked");
          },
          child: Icon(Icons.add),
        ),
        body: Center(child: Text('Material app')),
      ),
    );
  }
}

class Practice9 extends StatelessWidget {
  const Practice9({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.grey,
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/MyPhoto.jpg'),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
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
