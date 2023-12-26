import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navbar/category_screen.dart';
import '../navbar/product_screen.dart';
import '../navbar/location_screen.dart';
import '../navbar/store_screen.dart';
import '../navbar/warehouse_screen.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Category(),
    const Product(),
    const Location(),
    const Store(),
    const Warehouse(),
  ];
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<UserProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserProfile();
    });
  }

  Future<void> _fetchUserProfile() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await _userProvider.fetchProfile(authProvider.token!);
    } catch (e) {
      print('Failed to fetch user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.token == null) {
      return Scaffold(
        body: Center(
          child: Text('Please log in.'),
        ),
      );
    }
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
        child: FutureBuilder(
          future: _fetchUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildDrawer();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
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
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
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

  Widget _buildDrawer() {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${_userProvider.user!.username}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Role: ${_userProvider.user!.roles.join(', ')}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
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
        // Add more list tiles or other widgets for navigation items
      ],
    );
  }
}
