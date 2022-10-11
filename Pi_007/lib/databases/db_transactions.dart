import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbTrans_Manager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "trans.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE trans(id INTEGER PRIMARY KEY AUTOINCREMENT, spendings TEXT, category TEXT, name TEXT, amount REAL, note TEXT, timestamp TEXT)');
      } );
    }
  }

  Future<int> insertTransaction(Transaction transaction) async {
    await openDb();
    return await _database.insert('trans', transaction.toMap());
  }

  Future<List<Transaction>> getTransactionList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('trans');
    return List.generate(maps.length, (i) {
      return Transaction(
          id: maps[i]['id'],
          spendings:maps[i]['spendings'],
          category:maps[i]['category'],
          name: maps[i]['name'],
          amount: maps[i]['amount'],
          note: maps[i]['note'],
          timestamp: maps[i]['timestamp']);
    });
  }

  Future<int> updateTransaction(Transaction transaction) async {
    await openDb();
    return await _database.update('trans', transaction.toMap(),
        where: "id = ?", whereArgs: [transaction.id]);
  }

  Future<void> deleteTransaction(int id) async {
    await openDb();
    await _database.delete(
        'trans',
        where: "id = ?", whereArgs: [id]
    );
  }
}

class Transaction {
  int id;
  int spendings;
  String category;
  String name;
  double amount;
  String note;
  String timestamp;

  Transaction({ this.id,@required this.spendings, @required this.category, @required this.name, @required this.amount, this.note,@required this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      'spendings':spendings,
      'category':category,
      'name': name,
      'amount':amount,
      'timestamp': timestamp};
  }
}

