import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pi_007/databases/db_transactions.dart';

class spendingsChart extends StatelessWidget {
  final DbTrans_Manager dbmanager = new DbTrans_Manager();
  Future<List<Transaction>> txnData;

  // List<Transaction> convertToList() async {
  //   Future<List<Transaction>> _futureList = _getList();
  //   List txnDataList = await _futureList;
  //   return txnDataList;
  // }

  // Future<List> _getList(){
  //   return txnData = dbmanager.getTransactionByYear();
  // }

  @override
  Widget build(BuildContext context) {
    //   List<charts.Series<Transaction, String>> series = [
    //   charts.Series(
    //     id: "Spendings",
    //     data: txnData,
    //     domainFn: (Transaction txn, _) => txn.timestamp,
    //     measureFn: (Transaction txn, _) => txn.amount
    //   )
    // ];
    return FutureBuilder(
      future: dbmanager.getSpendingCurrentYearOrderBy('timestamp ASC'),
      builder:
          (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
        if (snapshot.hasData) {

          final txnData = snapshot.data;
          final totalSpendingMap = <String, double>{}; // {key : pair} = {month : totalSpending}

          // find total spending amount for every month as a mapping
          txnData.forEach((txn) => totalSpendingMap[txn.timestamp.substring(5, 7)] =
              !totalSpendingMap.containsKey(txn.timestamp.substring(5, 7))
                  ? (txn.amount)
                  : (totalSpendingMap[txn.timestamp.substring(5, 7)] + txn.amount));

          // convert mapping into a list of TS instances
          List<TotalSpending> monthlySpendingList = [];
          totalSpendingMap.forEach(((key, value) => monthlySpendingList.add(TotalSpending(key, value))));

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
                                data: monthlySpendingList,
                                domainFn: (TotalSpending ts, _) => ts.month,
                                measureFn: (TotalSpending ts, _) => ts.totalAmount)
                          ], animate: true),
                        )
                      ]))));

          // ListView.builder(
          //   primary: false,
          //   shrinkWrap: true,
          //   itemCount: timestampMap.length,
          //   itemBuilder: (context, index) {
          //     // sort here, or in SQL
          //     return _displayCard(distinctTimestampList[index]);
          //   },
          // );
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
  String month;
  double totalAmount;  

  TotalSpending(
    this.month,
    this.totalAmount
  );
}
