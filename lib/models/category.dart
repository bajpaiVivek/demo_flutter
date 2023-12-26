class Category {
  final int id;
  final String name;
  final String desc;

  Category({
    required this.id,
    required this.name,
    required this.desc,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
    );
  }
}
