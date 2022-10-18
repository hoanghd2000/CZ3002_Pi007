import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pi_007/databases/db_transactions.dart';

class yearlySpendingsChart extends StatelessWidget {
  final DbTrans_Manager dbmanager = new DbTrans_Manager();
  Future<List<Transaction>> txnData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbmanager.getAllSpendingOrderBy('timestamp ASC'),
      builder:
          (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
        if (snapshot.hasData) {
          final txnData = snapshot.data;
          final totalSpendingMap =
              <String, double>{}; // {key : pair} = {year : totalSpending}

          // find total spending amount for every year as a mapping
          txnData.forEach((txn) =>
              totalSpendingMap[txn.timestamp.substring(0, 3)] =
                  !totalSpendingMap.containsKey(txn.timestamp.substring(0, 3))
                      ? (txn.amount)
                      : (totalSpendingMap[txn.timestamp.substring(0, 3)] +
                          txn.amount));

          // convert mapping into a list of TS instances
          List<TotalSpending> yearlySpendingList = [];
          totalSpendingMap.forEach(((key, value) =>
              yearlySpendingList.add(TotalSpending(key, value))));

          return Container(
              height: 400,
              padding: EdgeInsets.all(20),
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: <Widget>[
                        Text(
                          "Monthly Spending Report",
                          style: Theme.of(context).textTheme.bodyText1,
                        ), //to change
                        Expanded(
                          child: charts.BarChart([
                            charts.Series<TotalSpending, String>(
                                id: "Spendings",
                                data: yearlySpendingList,
                                domainFn: (TotalSpending ts, _) => ts.year,
                                measureFn: (TotalSpending ts, _) =>
                                    ts.totalAmount)
                          ], animate: true),
                        )
                      ]))));
        } else {
          return const Center(
            child: Text("No data found."),
          );
        }
      },
    );
  }
}

class TotalSpending {
  String year;
  double totalAmount;

  TotalSpending(this.year, this.totalAmount);
}
