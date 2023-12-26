class Product {
  final int id;
  final String name;
  final int price;
  final int code;
  CategoryCode categoryCode;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.code,
    required this.categoryCode,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      code: json['code'] ?? 0,
      categoryCode: json['categoryCode'] ?? '',
    );
  }
}

class CategoryCode {
  String name;

  CategoryCode({
    required this.name,
  });
}
