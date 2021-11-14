import 'dart:async';

import 'package:db_local/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _db;

  Future<Database?>? get db async {
    if (_db == null) {
      _db = await defineDb();
    }
    else {
      return _db;
    }
  }

  Future<Database?>? defineDb() async {
    String dbPath = join(await getDatabasesPath(), "mydb.db");
    var mydb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return mydb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "create table products( id primary key , name text, decription text, unitPrice integer)");
  }

 Future<List<Product>> getProducts() async {
    var db = await this.db;
    if (db != null) {
      List<Map<String,Object?>> result =  await db.query("products");
      return List.generate (result.length, (index) {
        return Product.fromObj(result[index]);
      });
    }
    throw '';
  }
  Future<int?>? insertProduct(Product product) async {
    var db = await this.db;
    if (db != null) {
      var result = await db.insert("products", product.toMapProduct());
      return result;
    }
  }
  Future<int?>? deleteProduct(int id) async {
    var db = await this.db;
    if (db != null) {
      var result = await db.rawDelete("delete from products where id = $id");
      return result;
    }
  }
  Future<int?>? updateproduct(Product product) async {
    var db = await this.db;
    if (db != null) {
      var result = await db.update("products", product.toMapProduct(),where: "id=?",whereArgs: [product.id]);
      return result;
    }
  }
}



