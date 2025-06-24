import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:flutter_application_1/models/order.dart';
import 'package:flutter_application_1/models/transaction.dart' as model;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('roti.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price INTEGER NOT NULL,
        stock INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        customer_name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        latitude REAL,
        longitude REAL,
        FOREIGN KEY (product_id) REFERENCES products(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        status TEXT NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders(id)
      )
    ''');

    // Tambahkan produk awal
    await db.insert('products', {
      'name': 'Roti Cokelat',
      'price': 12000,
      'stock': 10,
    });
    await db.insert('products', {
      'name': 'Kue Keju',
      'price': 15000,
      'stock': 5,
    });
  }

  // ❗ Untuk development: hapus database jika struktur berubah
  Future<void> deleteDatabaseManually() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'roti.db');
    await deleteDatabase(path);
  }

  // === PRODUCTS ===
  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<int> insertProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<int> deleteProduct(int id) async {
  final db = await instance.database;
  return await db.delete(
    'products',
    where: 'id = ?',
    whereArgs: [id],
  );
}

  Future<void> decreaseProductStock(int productId, int quantity) async {
    final db = await instance.database;
    await db.rawUpdate('''
      UPDATE products
      SET stock = stock - ?
      WHERE id = ? AND stock >= ?
    ''', [quantity, productId, quantity]);
  }

  // === ORDERS ===
  Future<int> insertOrder(Order order) async {
    final db = await instance.database;
    return await db.insert('orders', order.toMap());
  }

  Future<List<Order>> getOrdersRaw() async {
    final db = await instance.database;
    final result = await db.query('orders');
    return result.map((map) => Order.fromMap(map)).toList();
  }

  Future<List<Map<String, dynamic>>> getOrdersWithProductName() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT orders.id,
            products.name AS product_name,
            orders.customer_name,
            orders.quantity,
            products.price,
            (orders.quantity * products.price) AS total,
            orders.latitude,
            orders.longitude
      FROM orders
      JOIN products ON orders.product_id = products.id
    ''');
  }

  // === TRANSACTIONS ===
  Future<int> insertTransaction(model.Transaction transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<model.Transaction>> getTransactions() async {
    final db = await instance.database;
    final result = await db.query('transactions');
    return result.map((map) => model.Transaction.fromMap(map)).toList();
  }

  Future<List<Map<String, dynamic>>> getTransactionsWithDetails() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT transactions.id, transactions.date, transactions.status,
            orders.customer_name, products.name AS product_name
      FROM transactions
      JOIN orders ON transactions.order_id = orders.id
      JOIN products ON orders.product_id = products.id
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
