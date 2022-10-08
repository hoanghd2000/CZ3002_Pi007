import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:pi_007/page/add_budget.dart';
import 'package:pi_007/page/edit_budget.dart';

class BudgetPage extends StatelessWidget{

  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const main_section =  Color(0xFFC9C5F9);   //purple
  static const action_button =  Color(0xFFF8C8DC);  //pink
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const secondary_section =  Color(0xFFC5E0F9); //blue
  static const list_color =  Color(0xFFECECEC);  //grey

  static const IconData pencil = IconData(0xf37e);
  static const IconData create_sharp = IconData(0xe89b, fontFamily: 'MaterialIcons');

  // sample hard coded data - to be extracted from database
  // idk what format it will be extracted as though - json / string / ???
  final budgetList = List.generate(
    20,
        (i) => budget(
      'Budget $i',
      'Budget Amount \$500',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body:
      ListView.builder(
        itemCount: budgetList.length,
        itemBuilder: (context, index) {
          return  Card(child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: 15
                      ),
                      child: Column(children: [
                        Text(budgetList[index].title),
                      ])
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 5
                    ),
                    child: Column(children: [
                      // Icon(create_sharp),
                      IconButton(
                          icon: const Icon(create_sharp),
                          color: Colors.black,
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditBudget()));
                          }
                      ),
                    ]),
                  ),
                ]),
            Row(children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 15
                  ),
                  child: Column(children: [
                    Text(budgetList[index].amount)
                  ])
              ),
            ]),
          ]),
              elevation:5,
              // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: list_color,
              margin: const EdgeInsets.only(
                bottom: 20,
              ));
        },
        padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 10,
            right: 10
        ),
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

class budget {
  final String title;
  final String amount;

  const budget(this.title, this.amount);
}