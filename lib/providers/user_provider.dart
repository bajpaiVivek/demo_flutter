import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final ApiService apiService;
  late User _user;

  User get user => _user;
  UserProvider(this.apiService) {
    _user = User(id: 0, username: '', email: '', roles: []);
  }

  Future<void> fetchProfile(String token) async {
    try {
      final profileData = await apiService.getProfile();
      _user = User(
        id: profileData['id'],
        username: profileData['username'],
        email: profileData['email'],
        roles: List<String>.from(profileData['roles']),
      );
      notifyListeners();
    } catch (e) {
      print('Failed to fetch profile: $e');
    }
  }
}
