import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pi_007/databases/db_transactions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class barYearlySpendings extends StatelessWidget {
  final DbTrans_Manager dbmanager = new DbTrans_Manager();
  Future<List<Transaction>> txnData;
  TooltipBehavior tooltip;

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
              totalSpendingMap[txn.timestamp.substring(0, 4)] =
                  !totalSpendingMap.containsKey(txn.timestamp.substring(0, 4))
                      ? (txn.amount)
                      : (totalSpendingMap[txn.timestamp.substring(0, 4)] +
                          txn.amount));

          // convert mapping into a list of TS instances
          List<TotalSpending> yearlySpendingList = [];
          totalSpendingMap.forEach(((key, value) =>
              yearlySpendingList.add(TotalSpending(key, value))));

          // return Container(
          //     height: 400,
          //     padding: EdgeInsets.all(20),
          //     child: Card(
          //         child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(children: <Widget>[
          //               Text(
          //                 "Yearly Spending Report",
          //                 style: Theme.of(context).textTheme.bodyText1,
          //               ), //to change
          //               Expanded(
          //                 child: charts.BarChart(
          //                   [
          //                     charts.Series<TotalSpending, String>(
          //                         id: "Spendings",
          //                         data: yearlySpendingList,
          //                         fillColorFn: (TotalSpending ts, _) =>
          //                             charts.ColorUtil.fromDartColor(
          //                                 Color.fromARGB(255, 203, 114, 219)),
          //                         domainFn: (TotalSpending ts, _) => ts.year,
          //                         measureFn: (TotalSpending ts, _) =>
          //                             ts.totalAmount),
          //                   ],
          //                   animate: true,
          //                 ),
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
                          "Yearly Spending Report",
                          style: Theme.of(context).textTheme.bodyText1,
                        ), //to change
                        Expanded(
                          child: SfCartesianChart(
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              // shouldAlwaysShow: true,
                              duration: 7000,
                                canShowMarker: false,
                            ),
                              onTooltipRender: (TooltipArgs args){
                                args.header = '';
                              },
                            primaryXAxis: CategoryAxis(interval: 1, majorGridLines: MajorGridLines(
                                width: 0), title: AxisTitle(text: "Year")),
                            primaryYAxis: NumericAxis(labelFormat:'\${value}'),
                            // tooltipBehavior: _tooltip,
                            series: <ChartSeries<TotalSpending, String>>[
                              ColumnSeries<TotalSpending, String>(
                                  animationDuration: 1000,
                                  dataSource: yearlySpendingList,
                                  xValueMapper: (TotalSpending ts, _) => ts.year,
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
  String year;
  double totalAmount;

  TotalSpending(this.year, this.totalAmount);
}
