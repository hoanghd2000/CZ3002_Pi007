import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:pi_007/page/add_budget.dart';

class BudgetPage extends StatelessWidget{

  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const main_section =  Color(0xFFC9C5F9);   //purple
  static const action_button =  Color(0xFFF8C8DC);  //pink
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const secondary_section =  Color(0xFFC5E0F9); //blue
  static const list_color =  Color(0xFFECECEC);  //grey

  // hard coded data
  List<String> course = [
    "c",
    "c++",
    "java",
    "kotlin",
    "objective c",
    "swift",
    "php"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body:ListView.builder(
        itemCount: course.length,
        itemBuilder: (context, pos) {
          return Padding(
              padding: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
              child: Card(
                color: list_color,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                  child: Text(course[pos], style: TextStyle(
                    fontSize: 18.0,
                    height: 1.6,
                  ),),
                ),
              )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: action_button,
          foregroundColor: Colors.black,
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBudget()));
          }
      ),
      /*floatingActionButton:FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.save),
        label: Text("Save"),
      ), */
    ),
      debugShowCheckedModeBanner: false,
    );
  }

}