class Supplier {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final int productCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Supplier({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.productCount,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'productCount': productCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      productCount: map['productCount'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
