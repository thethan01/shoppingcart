import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    String path = join(directory!.path, 'db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(""" CREATE TABLE Cart(
                          id TEXT PRIMARY KEY,
                          name TEXT,
                          price INTEGER,
                          image TEXT,
                          quantity INTEGER)""");
      },
    );
    return db;
  }

  Future<List<CartModel>> getCartProducts() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('Cart');

    return List.generate(maps.length, (i) {
      return CartModel(
        product: ProductModel.fromMap(maps[i]),
        quantity: maps[i]['quantity'],
      );
    });
  }

  Future<void> insertProduct(CartModel cartModel) async {
    var dbClient = await db;
    await dbClient!.insert(
      'Cart',
      {
        ...cartModel.product.toMap(),
        'quantity': cartModel.quantity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteProduct(
    String id,
  ) async {
    var dbClient = await db;
    await dbClient!.delete('Cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final dbClient = await db;
    await dbClient!.delete('Cart');
  }
}
