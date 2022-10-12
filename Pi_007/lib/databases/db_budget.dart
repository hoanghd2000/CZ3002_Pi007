import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:pi_007/databases/db_budget.dart';
//budget manager
class dbBudget_manager {
  Database budgetDB;
  final budgetFields = [
    'id',
    'name',
    'limitBudget',
    'remainingBudget',
    'startBudget',
    'endBudget'
  ];
  //open/create budgetDB on page open
  Future openDb() async {
    budgetDB ??= await openDatabase(
        join(await getDatabasesPath(), "budgets.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE budgets(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, limitBudget TEXT, remainingBudget TEXT, startBudget TEXT, endBudget TEXT)');
      } );
  }

  Future<List<Budget>> getBudgetList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await budgetDB.query('budgets');
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

  //insert budget
  Future<int> insertBudget(Budget budget) async {
    await openDb();
    return await budgetDB.insert('budgets', budget.toJson());
  }

  Future<int> updateBudgetDB(Budget budget) async {
    await openDb();
    return await budgetDB.update('budgets', budget.toJson(),
        where: "id = ?", whereArgs: [budget.id]);
  }
}

class Budget {
  int id;
  String name;
  double limitBudget;
  double remainingBudget;
  String startBudget;
  String endBudget;

  Budget({ this.id,
    @required this.name,
    @required this.limitBudget,
              this.remainingBudget,
    @required this.startBudget,
    @required this.endBudget
  });

  Map<String, dynamic> toJson() {
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