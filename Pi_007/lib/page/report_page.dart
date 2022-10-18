import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:pi_007/page/monthly_spendings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart' as indicator;

class ReportPage extends StatelessWidget {
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green

  @override
  Widget build(BuildContext context) => Scaffold(
          body: ListView(children: <Widget>[
        Text('Report Page', style: TextStyle(fontSize: 40)),
        SizedBox(height: 15),
        Text('   Select Time Interval:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 4),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Display Weekly Report.'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ));
                },
                child: Text('View Weekly'),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  side: BorderSide(
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  primary: action_button, //foreground
                ),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  //display monthly report
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Display Monthly Report.'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ));
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
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Display Monthly Report.'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ));
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
        // SizedBox(height:240),

        //add chart here
        monthlySpendingsChart(),

        Text('   Budget for the month:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: new LinearProgressIndicator(
              // minHeight: 14.0,
              // value: 0.6, //TO DO: dynamic
              // backgroundColor: Colors.indigo[100],
              // valueColor: AlwaysStoppedAnimation<Color>(
              //   Colors.indigo[300],
              // ),

              // //percentage indicator
              // new LinearPercent
              ),
        ),
        Text('    350 dollars of 500 dollars used',
            style: TextStyle(fontSize: 15, color: Colors.grey)),
        SizedBox(height: 15),

        Text('   Budget by category:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('    Food:', style: TextStyle(fontSize: 18)),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: new LinearProgressIndicator(
            minHeight: 14.0,
            value: 0.8,
            backgroundColor: Colors.teal[50],
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.teal[200],
            ),
          ),
        ),
        Text('    200 dollars of 250 dollars used',
            style: TextStyle(fontSize: 15, color: Colors.grey)),
        SizedBox(height: 5),
        Text('    Transport:', style: TextStyle(fontSize: 18)),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: new LinearProgressIndicator(
            minHeight: 14.0,
            value: 0.9,
            backgroundColor: Colors.deepOrange[50],
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.deepOrange[200],
            ),
          ),
        ),
        Text('    170 dollars of 200 dollars used',
            style: TextStyle(fontSize: 15, color: Colors.grey)),
        SizedBox(height: 15),

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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              primary: confirm_button, //background
              onPrimary: Colors.black, //foreground
            ),
          ),
        ])
      ]));
}
