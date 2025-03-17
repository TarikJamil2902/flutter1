class Item {
  int? id;
  String name;
  int quantity;
  double price;
  bool inStock;
  DateTime expirationDate;
  String description;
  String category; // Added category field

  Item({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.inStock,
    required this.expirationDate,
    required this.description,
    required this.category, // Include category in constructor
  });

  // Convert Item object to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'inStock': inStock ? 1 : 0, // SQLite uses 1 and 0 for boolean
      'expirationDate': expirationDate.toIso8601String(),
      'description': description,
      'category': category, // Save category to the map
    };
  }


  // Convert Map to Item object
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      inStock: map['inStock'] == 1,
      expirationDate: DateTime.parse(map['expirationDate']),
      description: map['description'],
      category: map['category'], // Read category from the map
    );
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, quantity: $quantity, price: $price, inStock: $inStock, expirationDate: $expirationDate, description: $description, category: $category}';
  }

}

