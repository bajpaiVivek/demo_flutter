// user_provider.dart
import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final ApiService apiService;
  late User _user;

  User get user => _user;

  UserProvider(this.apiService);

  Future<void> fetchProfile(String token) async {
    try {
      final profileData = await apiService.getProfile(token);
      _user = User(
        id: profileData['id'],
        username: profileData['username'],
        email: profileData['email'],
        roles: List<String>.from(profileData['roles']),
      );
      notifyListeners();
    } catch (e) {
      // Handle fetch profile error
      print('Failed to fetch profile: $e');
    }
  }

  // Implement other user-related methods
}
