import 'package:pi_007/databases/db_budget.dart';
import 'dart:math';

final _startMonth2022List = [
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

final _endMonth2022List = [
  "2022-01-31",
  "2022-02-28",
  "2022-03-31",
  "2022-04-30",
  "2022-05-31",
  "2022-06-30",
  "2022-07-31",
  "2022-08-31",
  "2022-09-30",
  "2022-10-31",
  "2022-11-30",
  "2022-12-31"
];

// for each month, generate 1 budget, with random amt, then append to data list
List<Budget> get2022data() {
  List<Budget> data = [];
  var rng = Random();

  for (var i = 0; i < 12; i++) {
    data.add(Budget(
        name: "Budget ${i+1}",
        amount: double.parse(((rng.nextInt(100)+1) * 10).toString()),
        startTime: _startMonth2022List[i],
        endTime: _endMonth2022List[i]));
  }
  return data;
}
