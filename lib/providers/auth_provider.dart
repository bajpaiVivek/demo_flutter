import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? get token => _token;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  Future<void> login(
      String email, String password, ApiService apiService) async {
    try {
      final tokenMap = await apiService.login(email, password);
      final authToken = tokenMap['token'];

      if (authToken != null) {
        apiService.authToken = authToken;
        setToken(authToken);
        _isLoggedIn = true;
      } else {
        print('Login failed: Null authToken received from the API');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', _isLoggedIn);
      notifyListeners();
    } catch (e) {
      print('Login failed: $e');
    }
  }
}
