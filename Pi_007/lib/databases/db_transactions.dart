import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbTrans_Manager {
  Database _database;
  final txnFields = [
    'id',
    'spendings',
    'category',
    'name',
    'amount',
    'note',
    'timestamp'
  ];

  Future openDb() async {
    // _database = await openDatabase(join(await getDatabasesPath(), "trans.db"),
    //     version: 1, onCreate: (Database db, int version) async {
    //     await db.execute(
    //       'DROP TABLE IF EXISTS trans');
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "transactions.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, spendings INTEGER, category TEXT, name TEXT, amount REAL, note TEXT, timestamp TEXT)');
      });
    }
  }

  Future<int> insertTransaction(Transaction transaction) async {
    await openDb();
    return await _database.insert('transactions', transaction.toJson());
  }

  Future<List<Transaction>> getAllTransaction() async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.query('transactions');
    return List.generate(maps.length, (i) {
      return Transaction(
          id: maps[i]['id'],
          spendings: maps[i]['spendings'],
          category: maps[i]['category'],
          name: maps[i]['name'],
          amount: maps[i]['amount'],
          note: maps[i]['note'],
          timestamp: maps[i]['timestamp']);
    });
  }

  Future<List<Transaction>> getAllTransactionOrderBy(String sqlOrderBy) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query(
      'transactions',
      columns: null,
      orderBy: sqlOrderBy,
    );
    return List.generate(maps.length, (i) {
      return Transaction(
          id: maps[i]['id'],
          spendings: maps[i]['spendings'],
          category: maps[i]['category'],
          name: maps[i]['name'],
          amount: maps[i]['amount'],
          note: maps[i]['note'],
          timestamp: maps[i]['timestamp']);
    });
  }

  Future<List<Transaction>> test() async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.rawQuery('SELECT * FROM ');
  }

  Future<int> updateTransaction(Transaction transaction) async {
    await openDb();
    return await _database.update('transactions', transaction.toJson(),
        where: "id = ?", whereArgs: [transaction.id]);
  }

  Future<void> deleteTransaction(int id) async {
    await openDb();
    await _database.delete('transactions', where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAllTransaction(String table) async {
    await openDb();
    await _database.rawDelete('DELETE FROM transactions');
    print("Deleted all records from transactions table");
  }

  // read from db
  static List<Transaction> fromJson(Map<String, dynamic> maps) {
    return List.generate(maps.length, (i) {
      return Transaction(
          id: maps[i]['id'],
          spendings: maps[i]['spendings'],
          category: maps[i]['category'],
          name: maps[i]['name'],
          amount: maps[i]['amount'],
          note: maps[i]['note'],
          timestamp: maps[i]['timestamp']);
    });
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

  Transaction(
      {this.id,
      @required this.spendings,
      @required this.category,
      @required this.name,
      @required this.amount,
      this.note,
      @required this.timestamp});

  // write to db
  Map<String, dynamic> toJson() => {
        'spendings': spendings,
        'category': category,
        'name': name,
        'amount': amount,
        'timestamp': timestamp
      };
}
