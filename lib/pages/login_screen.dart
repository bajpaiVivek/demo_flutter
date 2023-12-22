import 'package:flutter/material.dart';
import '../pages/home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: const Text("Username"),
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
                  SnackBar(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20),
                        Text('Logging in...'),
                      ],
                    ),
                  ),
                );
                await authProvider.login(usernameController.text, passwordController.text);

                
                if (authProvider.token != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  // Show error message if login fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login failed. Please check your credentials.'),
                      backgroundColor: Colors.red,
                    ),
                  );
          
                },
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(150.0, 50.0)), // Minimum size
                  padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
                  backgroundColor: MaterialStateProperty.all(
                      Color(0xddf15439)), // Background color
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
