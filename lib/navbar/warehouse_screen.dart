import 'package:flutter/material.dart';

class Warehouse extends StatefulWidget {
  const Warehouse({Key? key}) : super(key: key);

  @override
  State<Warehouse> createState() => _WarehouseState();
}

class _WarehouseState extends State<Warehouse> {
  Future<void> addProduct() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        tooltip: "add warehouse",
        child: const Icon(Icons.add),
      ),
    );
  }
}
