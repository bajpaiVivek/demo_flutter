import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://products-jts0.onrender.com';
  String? authToken;

  Future<Map<String, String>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {'email': email, 'password': password},
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

  Future<Map<String, dynamic>> getProfile(String? token) async {
    if (token == authToken) {
      throw Exception('No authentication token available');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> profile = json.decode(response.body);
      print(profile);
      return {
        'id': profile['id'],
        'username': profile['username'],
        'roles': profile['roles']
      };
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<Map<String, dynamic>> getCategoryListing(String token) async {
    if (token == authToken) {
      throw Exception('No authentication token available');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/categories/listing'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> categoryList = json.decode(response.body);
      return {'categories': categoryList};
    } else {
      throw Exception('Failed to fetch category listing');
    }
  }

  Future<Map<String, dynamic>> getProductListing(String token) async {
    if (token == authToken) {
      throw Exception('No authentication token available');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/products/listing'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> productList = json.decode(response.body);
      return {'products': productList};
    } else {
      throw Exception('Failed to fetch category listing');
    }
  }
}
