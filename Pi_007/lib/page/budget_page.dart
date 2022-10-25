import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pi_007/databases/db_budget.dart';
import 'package:pi_007/page/add_budget.dart';
import 'package:pi_007/page/edit_budget.dart';
import 'package:pi_007/static_data/budget.dart';

/*class Budget extends StatelessWidget {
  const Budget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: BudgetPage(),
    );
  }

}*/

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey

  static const IconData pencil = IconData(0xf37e);
  static const IconData create_sharp =
      IconData(0xe89b, fontFamily: 'MaterialIcons');

  dbBudget_manager budgetDBM = dbBudget_manager();
  Budget budget;
  List<Budget> budgetList;
  // List<Budget> budgetList = [Budget(name: 'test1', amount: 12.0, startTime: '2022-12-01', endTime: '2022-12-31')];
  // sample hard coded data - to be extracted from database
  // idk what format it will be extracted as though - json / string / ???
  // currently this sample is a class
  /*final budgetList = List.generate(
    1,
        (i) => Budget(
      'Budget $i',
      '500',
      DateTime(start: DateTime.parse("2022-0${i+1}-01"), end: DateTime.parse("2022-0${i+1}-28"))
    ),
  );
*/

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: <Widget>[
            // Text("Budget list here", style: TextStyle(fontSize: 40)),

            /************* debug code BEGIN ************/
            // TextButton(
            //   onPressed: () => budgetDBM.insertBudget(Budget(
            //       name: 'test1',
            //       amount: 12.0,
            //       startTime: '2022-12-01',
            //       endTime: '2022-12-31')),
            //   child: Text("add budget"),
            // ),
            // TextButton(
            //   onPressed: () => budgetDBM.deleteAllBudget(),
            //   child: Text("delete all budget"),
            // ),
            // TextButton(
            //   onPressed: () => _generate2022data(),
            //   child: Text("generate data"),
            // ),
            /************* debug code END ************/
            FutureBuilder(
              future: budgetDBM.getBudgetList(),
              // future: dbmanager.getTransactionByYear(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Budget>> snapshot) {
                if (snapshot.data != null && snapshot.data.isNotEmpty) {
                  budgetList = snapshot.data;
                  // budgetList.forEach((e) {
                  //   print("budget page");
                  //   print(e.id);
                  //   print(e.name);
                  //   print(e.amount);
                  //   print(e.startTime);
                  //   print(e.endTime);
                  // });
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: budgetList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(children: [
                                        Text(budgetList[index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22))
                                      ])),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Column(children: [
                                      IconButton(
                                          icon: const Icon(create_sharp),
                                          color: Colors.black,
                                          onPressed: () async {
                                            final edittedresult =
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditBudget(budgetList[
                                                                index]))).then(
                                                    (value) =>
                                                        (context as Element)
                                                            .reassemble());
                                            // print(edittedresult);

                                            // if (edittedresult == "Delete") {
                                            //   budgetList
                                            //       .remove(budgetList[index]);
                                            //   print(budgetList);
                                            //   (context as Element).reassemble();
                                            //   (context as Element).reassemble();
                                            // } else {
                                            //   // budgetList[index] = Budget(edittedresult[3], edittedresult[2], DateTimeRange(start: edittedresult[0], end: edittedresult[1]));
                                            //   print(budgetList);
                                            //   (context as Element).reassemble();
                                            // }
                                          }),
                                    ]),
                                  ),
                                ]),
                            Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15),
                                  child: Column(children: [
                                    Text(budgetList[index].startTime +
                                        " to " +
                                        budgetList[index].endTime),
                                  ])),
                            ]),
                            Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15),
                                  child: Column(children: [
                                    Text("Total budget: \$" +
                                        budgetList[index].amount.toString())
                                  ])),
                            ]),
                          ]),
                          elevation: 5,
                          // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Color(0xFFF7F7F7),
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ));
                    },
                  );
                } else {
                  return SizedBox(
                      height: 500,
                      child: Center(
                        child: Text("Create a new budget."),
                      ));
                }
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: action_button,
            foregroundColor: Colors.black,
            onPressed: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBudget()));
              // print(result);
              // budgetList.add(Budget(result[3], result[2], DateTimeRange(start: result[0], end: result[1])));
              // print(budgetList);
              (context as Element).reassemble();
            }),
      );

  // void _generate2022data() {
  //   var data = get2022data();
  //   for (var i = 0; i < data.length; i++) {
  //     budgetDBM.insertBudget(data[i]);
  //   }
  // }
}

// class EditScreen extends StatelessWidget {
//   // In the constructor, require a Todo.
//   // const EditScreen({super.key, required this.budget});
//   EditScreen(this.budget);
//
//   // Declare a field that holds the Todo.
//   final Budget budget;
//
//   @override
//   Widget build(BuildContext context) {
//     // Use the Todo to create the UI.
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(budget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text(budget.amount),
//       ),
//     );
//   }
//
// }
/*
class Budget {
  final String title;
  final String amount;
  final DateTimeRange dateRange;

  const Budget(this.title, this.amount, this.dateRange);
}*/