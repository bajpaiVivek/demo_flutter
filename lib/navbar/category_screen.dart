import 'package:demo/providers/categories/category_listing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late CategoryProvider _categroy;
  @override
  void initState() {
    super.initState();
    _categroy = Provider.of<CategoryProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCategoryListing();
    });
  }

  Future<void> fetchCategoryListing() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await _categroy.fetchCategoryListing(authProvider.token!);
    } catch (e) {
      print('Failed to fetch user profile: $e');
    }
  }

  Future<void> addProduct() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchCategoryListing(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: _categroy.categoryList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_categroy.categoryList[index]!.name),
                  subtitle: Text(_categroy.categoryList[index]!.desc),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        tooltip: "add Category",
        child: const Icon(Icons.add),
      ),
    );
  }
}
