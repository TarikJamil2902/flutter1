import 'package:flutter/material.dart';
import 'package:new_flutter_app/screens/admin/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = 'Admin';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (selectedRole == 'Admin') {
      if (email == 'admin123' && password == 'admin123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDash2()),
        );
      } else {
        _showSnackBar("Invalid Admin credentials");
      }
    } else {
      if (email == 'dis123' && password == 'dis123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDash2()),
        );
      } else {
        _showSnackBar("Invalid Distributor credentials");
      }
    }
  }

  void _autoFill() {
    setState(() {
      if (selectedRole == 'Admin') {
        emailController.text = 'admin123';
        passwordController.text = 'admin123';
      } else {
        emailController.text = 'dis123';
        passwordController.text = 'dis123';
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF1E2D48),
      body: Row(
        children: [
          // Left Section
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                child: RichText(
                  text: const TextSpan(
                    text: "The best offer\n",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: "for your business",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.normal,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Right Section
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Login As",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text("Admin"),
                          selected: selectedRole == 'Admin',
                          onSelected: (_) {
                            setState(() {
                              selectedRole = 'Admin';
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text("Distributor"),
                          selected: selectedRole == 'Distributor',
                          onSelected: (_) {
                            setState(() {
                              selectedRole = 'Distributor';
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email or Phone Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onLongPress: _autoFill,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color.fromARGB(
                              255,
                              188,
                              216,
                              244,
                            ),
                          ),
                          onPressed: _login,
                          child: Text(
                            "$selectedRole Log in",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "Or don't have account : ",
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to register page
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
