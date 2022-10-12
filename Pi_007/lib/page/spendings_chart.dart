import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pi_007/databases/db_transactions.dart';

class spendingsChart extends StatelessWidget {

  final DbTrans_Manager dbmanager = new DbTrans_Manager();

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
            future: dbmanager.getTransactionByYear(),
            builder: (BuildContext context,
                  AsyncSnapshot<List<Transaction>> snapshot) {
                if (snapshot.hasData) {
                  List<Transaction> txnData = snapshot.data;
                  List<charts.Series<Transaction, String>> series = [
                  charts.Series(
                    id: "Spendings",
                    data: txnData,
                    domainFn: (Transaction txn, _) => txn.timestamp,
                    measureFn: (Transaction txn, _) => txn.amount
                  )
                ];
                  return Container(
                    height: 400,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text("Title",
                            style: Theme.of(context).textTheme.bodyText1,
                            ),//to change
                            Expanded(
                              child: charts.BarChart(series, animate:true),
                            )
                          ]
                        )
                      )
                    )
                  );
                }
              },
            );
  }  
}

