class User {
  final int id;
  final String username;
  final String email;
  final List<String> roles;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.roles});

  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int?;
    final username = json['username'] as String?;
    final email = json['email'] as String?;
    final roles = (json['roles'] as List<dynamic>?)?.cast<String>();

    if (id != null && username != null && email != null && roles != null) {
      return User(
        id: id,
        username: username,
        email: email,
        roles: roles,
      );
    } else {
      throw const FormatException('Failed to load user.');
    }
  }
}
