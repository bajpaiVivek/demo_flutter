class User {
  final int id;
  final String username;
  final List<String> roles;

  User({required this.id, required this.username, required this.roles});
  factory User.fromJson(Map<String, dynamic> json) {
    List<String> rolesList = [];
    if (json['roles'] != null) {
      rolesList = List<String>.from(json['roles']);
    }
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      roles: rolesList,
    );
  }
}
