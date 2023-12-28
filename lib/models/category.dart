class Category {
  final String name;
  final String desc;

  Category({
    required this.name,
    required this.desc,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
    );
  }
}
