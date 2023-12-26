import 'package:flutter/material.dart';

import '../api/api.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

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
      } else {
        print('Login failed: Null authToken received from the API');
      }
    } catch (e) {
      print('Login failed: $e');
    }
  }
}
