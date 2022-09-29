import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView(children: <Widget>[
        Text('Report Page',style: TextStyle(fontSize: 40)),
        SizedBox(height:15),
        Text('Select Time Interval:',style: TextStyle(fontSize:20))

],
    ),
  );
}
