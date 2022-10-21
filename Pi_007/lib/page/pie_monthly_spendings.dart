import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:pie_chart/pie_chart.dart';

class pieMonthlySpendings extends StatelessWidget {
  final DbTrans_Manager dbmanager = new DbTrans_Manager();
  Future<List<Transaction>> txnData;

  @override
  Widget build(BuildContext context) {
  
    return FutureBuilder(
      future: dbmanager.getSpendingCurrentYearOrderBy('timestamp ASC'),
      builder:
          (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
        if (snapshot.hasData) {
          final txnData = snapshot.data;
          //uncategorised 
          txnData.forEach((txn) {
            if (txn.category == ""){
              txn.category = "Uncategorised";
            }
          });
          final totalSpendingMap =
              <String, double>{}; // {key : pair} = {category : totalSpending}

          // find total spending amount for every category as a mapping
          txnData.forEach((txn) =>
              totalSpendingMap[txn.category] =
                  !totalSpendingMap.containsKey(txn.category)
                      ? (txn.amount)
                      : (totalSpendingMap[txn.category] +
                          txn.amount));

          // final legend = <String, String>{"Category": "Total Monthly Spending"};
          
        
          // // convert mapping into a list of TS instances
          // List<TotalSpending> monthlySpendingList = [];
          // totalSpendingMap.forEach(((key, value) =>
          //     monthlySpendingList.add(TotalSpending(key, value))));

          // final TotalSpendingValue = snapshot.data[1];

          final colorList = <Color>[
            Color.fromARGB(255, 203, 114, 219),
            Color.fromARGB(255, 155, 205, 225),
            Color.fromARGB(255, 248, 200, 220),
            Color.fromARGB(255, 180, 236, 180),
            Color.fromARGB(255, 255, 234, 209),
            Color.fromARGB(255, 236, 236, 236)
          ];
          

          return Container(
              height: 400,
              padding: EdgeInsets.all(20),
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: <Widget>[
                        Text(
                          "Monthly Spending Composition",
                          style: Theme.of(context).textTheme.bodyText1,
                        ), //to change
                        Expanded(
                          child: PieChart(
                            dataMap: totalSpendingMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 30,
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            colorList: colorList,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 40,
                            centerText: "Categories",
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.bottom,
                              showLegends: true,
                              // legendShape: _BoxShape.circle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true,
                              decimalPlaces: 1,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          ),
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
          return new CircularProgressIndicator();
        }
      },
    );
  }
}

class TotalSpending {
  String category;
  double totalAmount;

  TotalSpending(this.category, this.totalAmount);
}
