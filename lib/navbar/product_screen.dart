import 'package:flutter/material.dart';
import 'package:demo/providers/products/product_listing.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late ProductProvider _product;
  @override
  void initState() {
    super.initState();
    _product = Provider.of<ProductProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProductListing();
    });
  }

  Future<void> fetchProductListing() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await _product.fetchProductListing(authProvider.token!);
    } catch (e) {
      print('Failed to fetch user profile: $e');
    }
  }

  Future<void> addProduct() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchProductListing(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: _product.productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_product.productList[index]!.name),
                  subtitle: Text(_product.productList[index]!.price.toString()),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        tooltip: "add Product",
        child: const Icon(Icons.add),
      ),
    );
  }
}
