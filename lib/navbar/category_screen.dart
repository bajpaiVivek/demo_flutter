import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/categories/category_listing.dart';
import '../providers/categories/new_category.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: categoryProvider.fetchCategoryListing(authProvider.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: categoryProvider.categoryList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categoryProvider.categoryList[index]!.name),
                  subtitle: Text(categoryProvider.categoryList[index]!.desc),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateCategory()),
          );
        },
        tooltip: 'Add Category',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateCategory extends StatelessWidget {
  const CreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final cat = Provider.of<NewCategoryProvider>(context);

    final TextEditingController catnameController = TextEditingController();
    final TextEditingController catdescController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: catnameController,
              decoration: InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: Text('Name'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: catdescController,
              decoration: InputDecoration(
                hintText: 'Category Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: Text('Description'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  final token = authProvider.token;

                  if (token != null) {
                    await cat.createCategory(
                      token,
                      catnameController.text,
                      catdescController.text,
                    );

                    if (cat.createcategory != null) {
                      print('Category created successfully.');
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    } else {
                      throw Exception('Error creating category');
                    }
                  } else {
                    print('Token is null.');
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
