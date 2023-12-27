import 'package:demo/providers/categories/category_listing.dart';
import 'package:demo/providers/categories/new_category.dart';
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

  // void addProduct() {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (BuildContext context) => CreateCategory()));
  // }

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

// class CreateCategory extends StatelessWidget {
//   final TextEditingController catnameController = TextEditingController();
//   final TextEditingController catdescController = TextEditingController();
//   CreateCategory({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final cat = Provider.of<NewCategoryProvider>(context);
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             TextField(
//                 controller: catnameController,
//                 decoration: InputDecoration(
//                   hintText: "CatrgoryName",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   label: const Text("Name"),
//                 )),
//             SizedBox(height: 20),
//             TextField(
//                 controller: catnameController,
//                 decoration: InputDecoration(
//                   hintText: "CatrgoryDescription",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   label: const Text("Desc"),
//                 )),
//             ElevatedButton(
//               onPressed: () async {
//                 final apiservice =
//                     Provider.of<ApiService>(context, listen: false);
//                 await cat.createCategory(catnameController.text,
//                     catdescController.text, ApiService());
//               },
//               child: Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
