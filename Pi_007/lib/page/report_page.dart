import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:pi_007/databases/db_budget.dart';
import 'package:pi_007/page/bar_monthly_spendings.dart';
import 'package:pi_007/page/bar_yearly_spendings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pi_007/page/pie_monthly_spendings.dart';
import 'package:pi_007/page/pie_yearly_spendings.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({Key key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  bool viewType = false;
  final DbTrans_Manager dbmanager = new DbTrans_Manager();
  final dbBudget_manager budgetDBM = new dbBudget_manager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      // Text('Report', style: TextStyle(fontSize: 40)),
      SizedBox(height: 15),
      Text('   Select Time Interval:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(width: 80),
            ElevatedButton(
              // ignore: sdk_version_set_literal
              onPressed: () {
                setState(() {
                  viewType = false;
                });
              },
              child: Text('View Monthly'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                primary: action_button, //background
                onPrimary: Colors.black, //foreground
              ),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {
                //display yearly report
                setState(() {
                  viewType = true;
                });
              },
              child: Text('View Yearly'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                primary: action_button, //background
                onPrimary: Colors.black, //foreground
              ),
            ),
          ],
        ),
      ),
      //SizedBox(height: 240),

      //add chart here
      viewType ? barYearlySpendings() : barMonthlySpendings(),
      viewType ? pieYearlySpendings() : pieMonthlySpendings(),

      Text('   Budget for current month:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      FutureBuilder(
          // future: dbmanager.getSpendingCurrentMonth('timestamp'),
          future: Future.wait([
            dbmanager.getSpendingCurrentMonth('timestamp'),
            budgetDBM.getCurrentMonthBudget()
          ]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Widget> children;
                final currentMonthTotalSpending = snapshot.data[0];
                final currentMonthTotalSpendingWhole =
                    snapshot.data[0].toStringAsFixed(0);
                final currentMonthBudget = snapshot.data[1];
                final currentMonthBudgetWhole =
                    snapshot.data[1].toStringAsFixed(0);
                final percentage =
                    (currentMonthTotalSpending / currentMonthBudget)
                        .toStringAsFixed(1);
                final percent100 =
                    (currentMonthTotalSpending / currentMonthBudget * 100)
                        .toStringAsFixed(1);
                final exceededBudgetWhole =
                    (currentMonthTotalSpending - currentMonthBudget)
                        .toStringAsFixed(0);
                if (currentMonthTotalSpending > currentMonthBudget) {
                  return Text(
                      "   Budget exceeded by \$$exceededBudgetWhole for this month.",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold));
                } else {
                  return new LinearPercentIndicator(
                    width: 260.0,
                    lineHeight: 25.0,
                    animation: true,
                    animationDuration: 1000,
                    trailing: new Text(
                        "\$$currentMonthTotalSpendingWhole of \$$currentMonthBudgetWhole used."),
                    percent: double.parse(percentage),
                    center: Text(
                      "$percent100%",
                      style: new TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: Colors.grey,
                    progressColor: Color.fromARGB(255, 155, 205, 225),
                  );
                }
              } else {
                // Text('no data');
                return Text("   There are no transactions found.");
              }
            }
          }),
      SizedBox(height: 20),

      Row(children: <Widget>[
        SizedBox(width: 150),
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('Report saved successfully.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ));
          },
          child: Text('Save Report'),
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              color: Colors.black,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            primary: confirm_button, //background
            onPrimary: Colors.black, //foreground
          ),
        ),
      ])
    ]));
  }
}
