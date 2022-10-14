import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//import 'package:pi_007/databases/db_budget.dart';
//budget manager
class dbBudget_manager {
  Database budgetDB;
  // final budgetFields = [
  //   'id',
  //   'name',
  //   'limitBudget',
  //   'remainingBudget',
  //   'startBudget',
  //   'endBudget'
  // ];
  //open/create budgetDB on page open
  Future openDb() async {
    budgetDB ??= await openDatabase(join(await getDatabasesPath(), "budget.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE budget(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL, startTime TEXT, endTime TEXT)');
    });
  }

  Future<List<Budget>> getBudgetList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await budgetDB.query('budget');
    return List.generate(maps.length, (i) {
      return Budget(
          id: maps[i]['id'],
          name: maps[i]['name'],
          // limitBudget:maps[i]['limitBudget'],
          amount: maps[i]['amount'],
          startTime: maps[i]['startTime'],
          endTime: maps[i]['endTime']);
    });
  }

  //insert budget
  Future<int> insertBudget(Budget budget) async {
    await openDb();
    return await budgetDB.insert('budget', budget.toJson());
  }

  Future<int> updateBudgetDB(Budget budget) async {
    await openDb();
    return await budgetDB.update('budget', budget.toJson(),
        where: "id = ?", whereArgs: [budget.id]);
  }

  Future<void> deleteAllBudget() async {
    await openDb();
    await budgetDB.rawDelete('DELETE FROM budget');
    print("Deleted all records from budget table");
  }

  // Future<void> drop() async {
  //   await budgetDB.rawQuery('DELETE FROM budget');
  //   await budgetDB.rawQuery('DROP TABLE IF EXISTS budget');
  // }
}

class Budget {
  int id;
  String name;
  double amount;
  // double remainingBudget;
  String startTime;
  String endTime;

  Budget(
      {this.id,
      @required this.name,
      @required this.amount,
      // this.remainingBudget,
      @required this.startTime,
      @required this.endTime});

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'amount': amount,
      // 'remainingBudget': remainingBudget,
      'startTime': startTime,
      'endTime': endTime
    };
  }
}
