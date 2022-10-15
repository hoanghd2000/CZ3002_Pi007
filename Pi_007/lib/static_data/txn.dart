import 'package:pi_007/databases/db_transactions.dart';
import 'dart:math';

final _earningList = ["Allowance", "Stock", "Work", ""];
final _categoryList = ["Food", "Transport", "Shopping", ""];

final _timestamp2022List = [
  "2022-01-01",
  "2022-02-01",
  "2022-03-01",
  "2022-04-01",
  "2022-05-01",
  "2022-06-01",
  "2022-07-01",
  "2022-08-01",
  "2022-09-01",
  "2022-10-01",
  "2022-11-01",
  "2022-12-01"
];

final _timestamp2021List = [
  "2021-01-01",
  "2021-02-01",
  "2021-03-01",
  "2021-04-01",
  "2021-05-01",
  "2021-06-01",
  "2021-07-01",
  "2021-08-01",
  "2021-09-01",
  "2021-10-01",
  "2021-11-01",
  "2021-12-01"
];

// for each month, generate 4, with random amt, then append to data list
List<Transaction> get2022data() {
  List<Transaction> data = [];
  var rng = Random();

  String _currentType(int typeName) {
    String _type2;
    if (typeName == 1) {
      _type2 = _categoryList[rng.nextInt(3)];
    } else {
      _type2 = _earningList[rng.nextInt(3)];
    }
    return _type2;
  }

  for (var i = 0; i < 12; i++) {
    int _type1 = 1;
    var temp = List.generate(2, (index) {
      return Transaction(
        spendings: _type1,
        timestamp: _timestamp2022List[i],
        name: "Txn" + (rng.nextInt(60)).toString(),
        amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
        category: _currentType(_type1),
        note: "",
      );
    });
    int _type3 = rng.nextInt(2);
    var temp2 = List.generate(2, (index) {
      return Transaction(
        spendings: _type3,
        timestamp: _timestamp2022List[i],
        name: "Txn" + (rng.nextInt(60)).toString(),
        amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
        category: _currentType(_type3),
        note: "",
      );
    });
    data.addAll(temp);
    data.addAll(temp2);
  }
  return data;
}
