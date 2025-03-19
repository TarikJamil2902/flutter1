class Product {
  final int? id;
  final String name;
  final String sku;
  final double price;
  final int quantity;
  final String category;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.quantity,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'price': price,
      'quantity': quantity,
      'category': category,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      price: map['price'],
      quantity: map['quantity'],
      category: map['category'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
