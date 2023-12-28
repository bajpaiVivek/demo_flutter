import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../providers/categories/category_listing.dart';
import '../providers/categories/new_category.dart';
import '../providers/products/product_listing.dart';
import '../api/api.dart';
import '../pages/login_screen.dart';
import '../pages/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider(ApiService())),
        ChangeNotifierProvider(create: (_) => CategoryProvider(ApiService())),
        ChangeNotifierProvider(create: (_) => ProductProvider(ApiService())),
        ChangeNotifierProvider(
            create: (_) => NewCategoryProvider(ApiService())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoggedIn) {
            return const HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
