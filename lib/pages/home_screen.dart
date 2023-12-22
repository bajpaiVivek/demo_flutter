import 'package:flutter/material.dart';
import '../navbar/category_screen.dart';
import '../navbar/product_screen.dart';
import '../navbar/location_screen.dart';
import '../navbar/store_screen.dart';
import '../navbar/warehouse_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Category(),
    Product(),
    Location(),
    Store(),
    Warehouse(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('account'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('settings'),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[700],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange[300],
        elevation: 10,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category, size: 28),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 28),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, size: 28),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, size: 28),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage, size: 28),
            label: 'Warehouses',
          ),
        ],
      ),
    );
  }
}
