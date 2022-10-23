import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class barMonthlySpendings extends StatelessWidget {
  final DbTrans_Manager dbmanager = new DbTrans_Manager();
  Future<List<Transaction>> txnData;
  TooltipBehavior tooltip;
  final existingMonthsList = <String>{};
  final allMonthsList = <String>{'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'};

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
          final totalSpendingMap =
              <String, double>{}; // {key : pair} = {month : totalSpending}

          // find total spending amount for every month as a mapping
          txnData.forEach((txn) {
            existingMonthsList.add(txn.timestamp.substring(5, 7));
            totalSpendingMap[txn.timestamp.substring(5, 7)] =
                !totalSpendingMap.containsKey(txn.timestamp.substring(5, 7))
                    ? (txn.amount)
                    : (totalSpendingMap[txn.timestamp.substring(5, 7)] +
                        txn.amount);
          });

          //find missing months if any and add them into map
          final monthsDifference = allMonthsList.difference(existingMonthsList);
          print('Missing months: $monthsDifference');
          for (int i=0; i<monthsDifference.length; i++){
            if (monthsDifference.elementAt(i) == '01'){
              totalSpendingMap['01'] = null;
            }
            else if (monthsDifference.elementAt(i) == '02'){
              totalSpendingMap['02'] = null;
            }
            else if (monthsDifference.elementAt(i) == '03'){
              totalSpendingMap['03'] = null;
            }
            else if (monthsDifference.elementAt(i) == '04'){
              totalSpendingMap['04'] = null;
            }
            else if (monthsDifference.elementAt(i) == '05'){
              totalSpendingMap['05'] = null;
            }
            else if (monthsDifference.elementAt(i) == '06'){
              totalSpendingMap['06'] = null;
            }
            else if (monthsDifference.elementAt(i) == '07'){
              totalSpendingMap['07'] = null;
            }
            else if (monthsDifference.elementAt(i) == '08'){
              totalSpendingMap['08'] = null;
            }
            else if (monthsDifference.elementAt(i) == '09'){
              totalSpendingMap['09'] = null;
            }
            else if (monthsDifference.elementAt(i) == '10'){
              totalSpendingMap['10'] = null;
            }
            else if (monthsDifference.elementAt(i) == '11'){
              totalSpendingMap['11'] = null;
            }
            else if (monthsDifference.elementAt(i) == '12'){
              totalSpendingMap['12'] = null;
            }
            else {
              print('No missing months');
            }
          }
          //sorting map
          final sortedTotalSpendingMap = Map.fromEntries(totalSpendingMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

          // convert mapping into a list of TS instances
          List<TotalSpending> monthlySpendingList = [];
          sortedTotalSpendingMap.forEach(((key, value) =>
              monthlySpendingList.add(TotalSpending(key, value))));
          

          // return Container(
          //     height: 400,
          //     padding: EdgeInsets.all(20),
          //     child: Card(
          //         child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(children: <Widget>[
          //               Text(
          //                 "Monthly Spending Report",
          //                 style: Theme.of(context).textTheme.bodyText1,
          //               ), //to change
          //               Expanded(
          //                 child: charts.BarChart([
          //                   charts.Series<TotalSpending, String>(
          //                       id: "Spendings",
          //                       data: monthlySpendingList,
          //                       fillColorFn: (TotalSpending ts, _) =>
          //                           charts.ColorUtil.fromDartColor(
          //                               Color.fromARGB(255, 203, 114, 219)),
          //                       domainFn: (TotalSpending ts, _) => ts.month,
          //                       measureFn: (TotalSpending ts, _) =>
          //                           ts.totalAmount)
          //                 ], animate: true),
          //               )
          //             ]))));

          return Container(
              height: 400,
              padding: EdgeInsets.all(10),
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: <Widget>[
                        Text(
                          "Monthly Spending Report",
                          style: Theme.of(context).textTheme.bodyText1,
                        ), //to change
                        Expanded(
                          child: SfCartesianChart(
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              // shouldAlwaysShow: true,
                              duration: 7000,
                              canShowMarker: false,
                              format: 'point.y'
                              ),
                              onTooltipRender: (TooltipArgs args){
                                if(args.pointIndex == 0) {
                                  //Tooltip with customized header
                                  args.header = 'Jan';

                                }
                                if(args.pointIndex == 1) {
                                  //Tooltip with customized header
                                  args.header = 'Feb';
                                }
                                if(args.pointIndex == 2) {
                                  //Tooltip with customized header
                                  args.header = 'Mar';
                                }
                                 if(args.pointIndex == 3) {
                                  //Tooltip with customized header
                                  args.header = 'Apr';
                                }
                                 if(args.pointIndex == 4) {
                                  //Tooltip with customized header
                                  args.header = 'May';
                                }
                                 if(args.pointIndex == 5) {
                                  //Tooltip with customized header
                                  args.header = 'Jun';
                                }
                                 if(args.pointIndex == 6) {
                                  //Tooltip with customized header
                                  args.header = 'Jul';
                                }
                                 if(args.pointIndex == 7) {
                                  //Tooltip with customized header
                                  args.header = 'Aug';
                                }
                                 if(args.pointIndex == 8) {
                                  //Tooltip with customized header
                                  args.header = 'Sep';
                                }
                                 if(args.pointIndex == 9) {
                                  //Tooltip with customized header
                                  args.header = 'Oct';
                                }
                                 if(args.pointIndex == 10) {
                                  //Tooltip with customized header
                                  args.header = 'Nov';
                                }
                                 if(args.pointIndex == 11) {
                                  //Tooltip with customized header
                                  args.header = 'Dec';
                                }
                              },
                            primaryXAxis: CategoryAxis(interval: 1, majorGridLines: MajorGridLines(
                                width: 0), title: AxisTitle(text: "Month")),
                            primaryYAxis: NumericAxis(labelFormat:'\${value}'),
                            // tooltipBehavior: _tooltip,
                            series: <ChartSeries<TotalSpending, String>>[
                              ColumnSeries<TotalSpending, String>(
                                  animationDuration: 1000,
                                  dataSource: monthlySpendingList,
                                  xValueMapper: (TotalSpending ts, _) => ts.month,
                                  yValueMapper: (TotalSpending ts, _) => ts.totalAmount,
                                  width: 0.8,
                                  color: Color.fromARGB(255, 192, 132, 246),
                                  dataLabelSettings: DataLabelSettings(isVisible: false, labelPosition: ChartDataLabelPosition.outside))
                            ]))
                      ]))));         
        } else {
         return new CircularProgressIndicator();
        }
      },
    );
  }
}

class TotalSpending {
  String month;
  double totalAmount;

  TotalSpending(this.month, this.totalAmount);
}
