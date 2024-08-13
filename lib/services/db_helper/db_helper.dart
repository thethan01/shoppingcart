import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/models/cart_list_model.dart';
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
        db.execute(
            "CREATE TABLE Cart(id INTEGER PRIMARY KEY, name TEXT, path TEXT, size TEXT, length TEXT, isCart INTEGER)");
      },
    );
    return db;
  }

  Future<CartListModel> insert(CartListModel model) async {
    var dbClient = await db;
    dbClient!.insert('Cart', model.toMap()).then((value) {});
    return model;
  }

  Future<int> delete(
    String name,
  ) async {
    var dbClient = await db;
    return await dbClient!
        .delete('Cart', where: 'name = ?', whereArgs: [name]).then((value) {
      // Utils.showSnackBar('Deleted', 'Task is removed successfully', const Icon(Icons.done,color: Colors.white,size: 16,));
      return value;
    });
  }

  Future<dynamic> getData() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('Cart');
    print(queryResult);
    // return queryResult.map((e) {
    //   return CartModel.fromMap(e);
    // });
  }
}
