import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://products-9q0g.onrender.com';
  String? authToken;

  Future<Map<String, String>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      authToken = data['access_token'];
      print(authToken);
      return {'token': data['access_token']};
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    if (authToken == null) {
      throw Exception('No authentication token available');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch profile');
    }
  }
}
