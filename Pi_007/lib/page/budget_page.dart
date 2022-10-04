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

  // sample hard coded data - to be extracted from database
  // idk what format it will be extracted as though - json / string / ???
  List<String> budget = [
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
      body:
      ListView(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
          left: 10,
          right: 10
        ),
        children: <Widget>[
          Card(child:ListTile(
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text("15th Aug 2022 - 15th Sep 2022 (Budget Name)\n\nBudget: 500"),
              ),
            tileColor: list_color,
             ),
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          elevation:5,
          // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0))),
          Card(child:ListTile(
            title: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text("15th Jul 2022 - 15th Aug 2022 (Budget Name)\n\nBudget: 500"),
            ),
            tileColor: list_color,
          ),
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          elevation:5,
          // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0))),
          Card(child:ListTile(
            title: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text("15th May 2022 - 15th Jun 2022 (Budget Name)\n\nBudget: 500"),
            ),
            tileColor: list_color,
          ),
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          elevation:5,
          // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0))),
        ],
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

class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  }
}