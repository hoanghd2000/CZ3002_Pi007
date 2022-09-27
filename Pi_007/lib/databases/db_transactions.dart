import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbTrans_Manager {
  late Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "transaction.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE transaction("
              "id INTEGER PRIMARY KEY autoincrement, spendings BOOLEAN, category TEXT, name TEXT, amount DOUBLE, note TEXT)",
        );
      } );
    }
  }

  Future<int> insertStudent(Transaction transaction) async {
    await openDb();
    return await _database.insert('transaction', transaction.toMap());
  }

  Future<List<Transaction>> getTransactionList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('transaction');
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

  Future<int> updateStudent(Transaction transaction) async {
    await openDb();
    return await _database.update('transaction', transaction.toMap(),
        where: "id = ?", whereArgs: [transaction.id]);
  }

  Future<void> deleteTransaction(int id) async {
    await openDb();
    await _database.delete(
        'transaction',
        where: "id = ?", whereArgs: [id]
    );
  }
}

class Transaction {
  int id;
  bool spendings;
  String category;
  String name;
  double amount;
  String note;
  String timestamp;

  Transaction({required this.id,required this.spendings, required this.category, required this.name, required this.amount, required this.note,required this.timestamp});
  Map<String, dynamic> toMap() {
    return {'spendings':spendings,'category':category,'name': name, 'amount':amount,'note':note,'timestamp': timestamp};
  }
}

