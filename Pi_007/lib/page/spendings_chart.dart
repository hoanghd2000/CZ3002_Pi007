import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pi_007/databases/db_transactions.dart';

class spendingsChart extends StatelessWidget {

  final DbTrans_Manager dbmanager = new DbTrans_Manager();
  Future<List<Transaction>> txnData;
  //constructor
  spendingsChart({Key key, @required this.txnData}) : super(key: key){
    txnData = dbmanager.getTransactionByYear();
  }

  // List<Transaction> convertToList() async {
  //   Future<List<Transaction>> _futureList = _getList();
  //   List txnDataList = await _futureList;
  //   return txnDataList;
  // }

  Future<List> _getList(){
    return txnData = dbmanager.getTransactionByYear();
  }

  @override
  Widget build(BuildContext context) {
    


    List<charts.Series<Transaction, String>> series = [
    charts.Series(
      id: "Spendings",
      // data: txnData,
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
}

