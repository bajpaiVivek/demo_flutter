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
      String username, String password, ApiService apiService) async {
    try {
      final tokenMap = await apiService.login(username, password);
      setToken(tokenMap['token']!);
    } catch (e) {
      print('Login failed: $e');
    }
  }

  // Implement other authentication-related methods
}
