import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:pi_007/databases/db_budget.dart';
//budget manager
class dbBudget_manager {
  Database budgetDB;

  //open budgetDB on page open, else create budgetDB
  //Future
  Future openDb() async {
    budgetDB ??= await openDatabase(
        join(await getDatabasesPath(), "DB_budget.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE budget(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, limitBudget TEXT, remainingBudget TEXT, startBudget TEXT, endBudget TEXT)');
      } );
  }

  //get Budget list from db
  //Future<List<Budget>>
  Future<List<Budget>> getBudgetList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await budgetDB.query('budget');
    return List.generate(maps.length, (i) {
      return Budget(
          id: maps[i]['id'],
          name: maps[i]['name'],
          limitBudget:maps[i]['limitBudget'],
          remainingBudget:maps[i]['remainingBudget'],
          startBudget:maps[i]['startBudget'],
          endBudget: maps[i]['endBudget']);
    });
  }

  //new budget upon click on add budget
  //Future<int>
  Future<int> newBudget(Budget budget) async {
    await openDb();
    return await budgetDB.insert('budget', budget.toMap());
  }

  //update/edit budgets upon clicking on specific budget
  //update Budget, date and time to db
  //Future<int>
  Future<int> updateBudgetDB(Budget budget) async {
    await openDb();
    return await budgetDB.update('budget', budget.toMap(),
        where: "id = ?", whereArgs: [budget.id]);
  }
  //set budgets for transactions
}

class Budget {
  int id;
  String name;
  double limitBudget;
  double remainingBudget;
  String startBudget;
  String endBudget;

  Budget({ this.id,
           this.name,
    @required this.limitBudget,
              this.remainingBudget,
    @required this.startBudget,
    @required this.endBudget
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name' : name,
      'limitBudget': limitBudget,
      'remainingBudget': remainingBudget,
      'startBudget' : startBudget,
      'endBudget': endBudget
    };
  }
}