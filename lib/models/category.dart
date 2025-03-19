class Category {
  final int id;
  final String name;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.productCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'productCount': productCount,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      productCount: map['productCount'],
    );
  }
}
