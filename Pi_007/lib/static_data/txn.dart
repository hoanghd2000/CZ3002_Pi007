import 'package:pi_007/databases/db_transactions.dart';

Transaction t1 = Transaction(
    spendings: 1,
    category: "Food",
    name: "Mala",
    amount: 55.0,
    timestamp: "2000-11-08");
Transaction t2 = Transaction(
    spendings: 0,
    category: "Allowance",
    name: "Weekly",
    amount: 30.0,
    timestamp: "2022-12-31");

final _spendingBool = [0, 1];

final _categoryList = ["Food", "Allowance", "Transport", ""];

final _timestamp2022List = [
    "2022-01-01", "2022-02-01", "2022-03-01", "2022-04-01", "2022-05-01", "2022-06-01", "2022-07-01", "2022-08-01", "2022-09-01", "2022-10-01", "2022-11-01", "2022-12-01"
];

final _timestamp2021List = [
    "2021-01-01", "2021-02-01", "2021-03-01", "2021-04-01", "2021-05-01", "2021-06-01", "2021-07-01", "2021-08-01", "2021-09-01", "2021-10-01", "2021-11-01", "2021-12-01"
];


var _2022data = [];

// for each month, generate 10, with random amt, then append to _2022data list

// final _2022data = List.generate(100, (index) => {

// });
  
var list = []..addAll(_timestamp2022List)..addAll(_timestamp2022List);

