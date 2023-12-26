import 'package:flutter/material.dart';
import '../pages/home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../api/api.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text("Email"),
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility),
                  hintText: "password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: const Text("Password"),
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Colors.green[400]),
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Center(
                      child: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 20),
                          Text('Logging in...'),
                        ],
                      ),
                    ),
                  ),
                );
                await authProvider.login(emailController.text,
                    passwordController.text, ApiService());

                if (authProvider.token != null) {
                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Login failed. Please check your credentials.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    const Size(150.0, 50.0)), // Minimum size
                padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                backgroundColor: MaterialStateProperty.all(
                    const Color(0xddf15439)), // Background color
                foregroundColor:
                    MaterialStateProperty.all(Colors.white), // Text color
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                elevation: MaterialStateProperty.all(5.0),
              ),
              child: const Text('Login'))
        ],
      ),
    );
  }
}
