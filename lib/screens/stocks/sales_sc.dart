class Brand {
  int? id;
  String name;
  String code;
  String description;
  String category;
  String subcategory;

  Brand({
    this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.category,
    required this.subcategory,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      category: json['category'],
      subcategory: json['subcategory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'category': category,
      'subcategory': subcategory,
    };
  }
}

class Category {
  int? id;
  String name;
  String code;
  String description;

  Category({
    this.id,
    required this.name,
    required this.code,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'code': code, 'description': description};
  }
}

class Product {
  int? product_id;
  String product_code;
  String product_name;
  String product_unit;
  String product_brand;
  int product_quantity;
  int purchase_rate;
  int wirehouse_rate;
  int distributor_rate;
  int retail_rate;
  int mrp;
  String product_category;
  int total_quantity;
  bool status;

  Product({
    this.product_id,
    required this.product_code,
    required this.product_name,
    required this.product_unit,
    required this.product_brand,
    required this.product_quantity,
    required this.purchase_rate,
    required this.wirehouse_rate,
    required this.distributor_rate,
    required this.retail_rate,
    required this.mrp,
    required this.product_category,
    required this.total_quantity,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_id: json['product_id'],
      product_code: json['product_code'],
      product_name: json['product_name'],
      product_unit: json['product_unit'],
      product_brand: json['product_brand'] ?? '',
      product_category: json['product_category'] ?? '',
      product_quantity: json['product_quantity'],
      purchase_rate: json['purchase_rate'],
      wirehouse_rate: json['wirehouse_rate'],
      distributor_rate: json['distributor_rate'],
      retail_rate: json['retail_rate'],
      mrp: json['mrp'],
      total_quantity: json['total_quantity'],
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'product_code': product_code,
      'product_name': product_name,
      'product_unit': product_unit,
      'product_brand': product_brand,
      'product_quantity': product_quantity,
      'purchase_rate': purchase_rate,
      'wirehouse_rate': wirehouse_rate,
      'distributor_rate': distributor_rate,
      'retail_rate': retail_rate,
      'mrp': mrp,
      'product_category': product_category,
      'total_quantity': total_quantity,
      'status': status,
    };
  }
}