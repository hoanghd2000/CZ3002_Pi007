import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbCats_Manager {
  Database _database;

  final catFields = [
    'id',
    'name',
    'type',
    'icon'
  ];

  Future openDb() async {
    _database ??= await openDatabase(
        join(await getDatabasesPath(), "categories.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type TEXT, icon TEXT)');
    });
  }

  Future<int> insertCategory(Category category) async {
    await openDb();
    return await _database.insert('categories', category.toJson());
  }

  Future<List<Category>> getAllCategory() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('categories');
    return List.generate(maps.length, (i) {
      return Category(
          id: maps[i]['id'],
          name: maps[i]['name'],
          type: maps[i]['type'],
          icon: maps[i]['icon']);
    });
  }

  Future<void> deleteCategory(int id) async {
    await openDb();
    await _database.delete('categories', where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAllCategory() async {
    await openDb();
    await _database.rawDelete('DELETE FROM categories');
    // print("Deleted all records from transactions table");
  }

  // read from db
  static List<Category> fromJsonList(Map<String, dynamic> maps) {
    return List.generate(maps.length, (i) {
      return Category(
          id: maps[i]['id'],
          name: maps[i]['name'],
          type: maps[i]['type'],
          icon: maps[i]['icon']);
    });
  }
}

class Category {
  int id;
  String name;
  String type;
  String icon;

  Category(
      {this.id,
        @required this.name,
        @required this.type,
        @required this.icon});

  // write to db
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'icon': icon
  };
}