import 'package:new_flutter_app/models/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper2 {
  static const _databaseName = "items.db";
  static const _databaseVersion = 1;

  static const table = 'items';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnQuantity = 'quantity';
  static const columnPrice = 'price';
  static const columnInStock = 'inStock';
  static const columnExpirationDate = 'expirationDate';
  static const columnDescription = 'description';
  static const columnCategory = 'category';

  // Make the DatabaseHelper2 class a singleton
  static final DatabaseHelper2 _instance =
      DatabaseHelper2._privateConstructor();
  static Database? _database;

  DatabaseHelper2._privateConstructor(); // Private named constructor to prevent multiple instances.

  // Factory constructor to return the same instance
  factory DatabaseHelper2() {
    return _instance;
  }

  // Get the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            quantity INTEGER,
            price REAL,
            inStock INTEGER,
            expirationDate TEXT,
            description TEXT,
            category TEXT
          )
          ''');
      },
      version: _databaseVersion,
    );
  }

  // Insert an item into the database
  Future<int> insertItem(Item item) async {
    Database db = await database;
    return await db.insert('items', item.toMap());
  }

  // Update an item in the database
  Future<int> updateItem(Item item) async {
    Database db = await database;
    return await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // Get all items from the database
  Future<List<Item>> getAllItems() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });
  }

  // Get a specific item by ID
  Future<Item?> getItem(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Item.fromMap(maps.first);
    }
    return null;
  }

  // Delete an item by ID
  Future<int> deleteItem(int? id) async {
    Database db = await database;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  // // Insert a new item
  // Future<int> insertItem(Item item) async {
  //   Database db = await database;
  //   return await db.insert(table, item.toMap());
  // }

  // // Get all items
  // Future<List<Item>> getItems() async {
  //   Database db = await instance.database;
  //   var res = await db.query(table);
  //   List<Item> items =
  //       res.isNotEmpty ? res.map((c) => Item.fromMap(c)).toList() : [];
  //   return items;
  // }

  // // Get a specific item by ID
  // Future<Item?> getItem(int id) async {
  //   Database db = await instance.database;
  //   var res = await db.query(table, where: '$columnId = ?', whereArgs: [id]);
  //   return res.isNotEmpty ? Item.fromMap(res.first) : null;
  // }

  // // Update an existing item
  // Future<int> updateItem(Item item) async {
  //   Database db = await instance.database;
  //   return await db.update(
  //     table,
  //     item.toMap(),
  //     where: '$columnId = ?',
  //     whereArgs: [item.id],
  //   );
  // }

  // // Delete an item by ID
  // Future<int> deleteItem(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  // }

  // // Delete all items (optional, can be used for clearing the database)
  // Future<int> deleteAllItems() async {
  //   Database db = await instance.database;
  //   return await db.delete(table);
  // }
}
