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
      _user = User.fromJson(profileData);
      notifyListeners();
    } catch (e) {
      print('Failed to fetch profile: $e');
    }
  }
}
