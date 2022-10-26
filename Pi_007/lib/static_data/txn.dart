import 'package:pi_007/databases/db_transactions.dart';
import 'dart:math';

final _earningList = ["Allowance", "Salary", "Investment"];
// final _earningList = [""];
final _spendingList = ["Food", "Transport", "Shopping"];
// final _spendingList = [""];

// final _timestamp2022List = [
//   "2022-01-01",
//   "2022-02-01",
//   "2022-03-01",
//   "2022-04-01",
//   "2022-05-01",
//   "2022-06-01",
//   "2022-07-01",
//   "2022-08-01",
//   "2022-09-01",
//   "2022-10-01",
//   "2022-11-01",
//   "2022-12-01",
//   "2021-01-01",
//   "2021-02-01",
//   "2021-03-01",
//   "2021-04-01",
//   "2021-05-01",
//   "2021-06-01",
//   "2021-07-01",
//   "2021-08-01",
//   "2021-09-01",
//   "2021-10-01",
//   "2021-11-01",
//   "2021-12-01"
// ];

// final _timestamp2021List = [
//   "2021-01-01",
//   "2021-02-01",
//   "2021-03-01",
//   "2021-04-01",
//   "2021-05-01",
//   "2021-06-01",
//   "2021-07-01",
//   "2021-08-01",
//   "2021-09-01",
//   "2021-10-01",
//   "2021-11-01",
//   "2021-12-01"
// ];

// for each month, generate 4, with random amt, then append to data list
List<Transaction> _getDataOfYear(String year) {
  // year = '2022'
  List<String> monthList = List.generate(
      12, (index) => '${year}-${(index + 1).toString().padLeft(2, '0')}-01');

  List<String> evenMonthList = List.generate(
      6, (index) => '${year}-${(2 * index + 1).toString().padLeft(2, '0')}-01');

  var timestampList = year == '2022' ? monthList : evenMonthList;

  List<Transaction> data = [];
  var rng = Random();

  String _currentType(bool isSpending) {
    return isSpending
        ? _spendingList[rng.nextInt(3)]
        : _earningList[rng.nextInt(3)];
  }

  for (var i = 0; i < timestampList.length; i++) {
    // oct 2022 has only 1 txn - spending, and is fixed
    if (timestampList[i] == "2022-10-01") {
      data.add(Transaction(
        spendings: 1,
        timestamp: timestampList[i],
        name: "Spending" + (rng.nextInt(10)).toString(),
        amount: 100.0,
        category: "Food",
        note: "",
      ));
      continue;
    }
    // 1st txn is always spending
    data.add(Transaction(
      spendings: 1,
      timestamp: timestampList[i],
      name: "Spending" + (rng.nextInt(9)+1).toString(),
      amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
      category: _currentType(true),
      note: "",
    ));

    // 2nd txn can be either spending or earning
    bool isSpending = rng.nextBool();
    data.add(Transaction(
      spendings: isSpending ? 1 : 0,
      timestamp: timestampList[i],
      name: (isSpending ? "Spending" : "Earning") + (rng.nextInt(10)).toString(),
      amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
      category: _currentType(isSpending),
      note: "",
    ));
  }
  return data;
}

List<Transaction> getRandomTxn() {
  List<Transaction> data = [];
  var rng = Random();
  data.addAll(_getDataOfYear('2022'));
  data.addAll(_getDataOfYear('2021'));
  data.addAll(_getDataOfYear('2020'));
  // data.addAll([
  //   Transaction(
  //     spendings: 1,
  //     timestamp: '2022-10-01',
  //     name: "Entry" + (rng.nextInt(10)).toString(),
  //     amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
  //     category: '',
  //     note: "",
  //   ),
  //   Transaction(
  //     spendings: 1,
  //     timestamp: '2022-10-01',
  //     name: "Entry" + (rng.nextInt(10)).toString(),
  //     amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
  //     category: '',
  //     note: "",
  //   ),
  //   Transaction(
  //     spendings: 1,
  //     timestamp: '2022-10-02',
  //     name: "Entry" + (rng.nextInt(10)).toString(),
  //     amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
  //     category: '',
  //     note: "",
  //   ),
  //   Transaction(
  //     spendings: 1,
  //     timestamp: '2022-09-01',
  //     name: "Entry" + (rng.nextInt(10)).toString(),
  //     amount: num.parse((rng.nextDouble() * 100).toStringAsFixed(2)),
  //     category: '',
  //     note: "",
  //   ),
  // ]);
  return data;
}
