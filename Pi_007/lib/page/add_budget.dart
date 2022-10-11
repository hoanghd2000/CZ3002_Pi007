import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:intl/intl.dart';

class AddBudget extends StatelessWidget {
  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  const AddBudget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Add Budget'),
      backgroundColor: navigation_bar,
      foregroundColor: Colors.black,
    ),
    body: addBudgetPage(),
  );

}

class addBudgetPage extends StatefulWidget {
  @override
  State<addBudgetPage> createState() => _addBudgetPage();
}


class _addBudgetPage extends State<addBudgetPage>{

  // colors
  static const confirm_button =  Color(0xFFB4ECB4); //green

  final _formKey = GlobalKey<FormState>();
  final _timeController = TextEditingController();
  DateTimeRange _selectedDateRange;

  // This function will be triggered when the floating button is pressed
  // void _show() async {
  //   final DateTimeRange result = await showDateRangePicker(
  //     context: context,
  //     firstDate: DateTime(2022, 1, 1),
  //     lastDate: DateTime(2030, 12, 31),
  //     currentDate: DateTime.now(),
  //     saveText: 'Done',
  //   );
  //
  //   if (result != null) {
  //     // Rebuild the UI
  //     print(result.start.toString());
  //     setState(() {
  //       _selectedDateRange = result;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) => Scaffold(

      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: new InputDecoration(
                  // icon: Icon(Icons.calendar_today_rounded),
                    labelText: 'Date'),
                controller: _timeController,
                validator: (val) => val.isNotEmpty? null:'Date should not be empty',
                onTap: ()async {
                  DateTimeRange pickeddate = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2022, 1, 1),
                    lastDate: DateTime(2030, 12, 31),
                    currentDate: DateTime.now(),
                    saveText: 'Done',
                  );
                  if(pickeddate!=null){
                    setState(() {
                      // _timeController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                      // _selectedDateRange = pickeddate;
                      // _startdate = DateFormat('yyyy-MM-dd').format(pickeddate.start) as TextEditingController;
                      _timeController.text = DateFormat('yyyy-MM-dd').format(pickeddate.start) + " to " + DateFormat('yyyy-MM-dd').format(pickeddate.end);
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Budget"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name"
                ),
              ),
            ),
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Done"), style: TextButton.styleFrom(
              backgroundColor: confirm_button,
              primary: Colors.black,
              padding: EdgeInsets.only(
                left: 30,
                right: 30
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
            ),)
          ]
        )
      ),


  );
}



//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: Text('Add Budget'),
//         backgroundColor: navigation_bar,
//         foregroundColor: Colors.black,
//       ),
//
//       body: children: <Widget>[Container(
//   margin: EdgeInsets.all(10.0),
//   // decoration: BoxDecoration(
//   //     color: Colors.white,
//   //     borderRadius: new BorderRadius.circular(5.0),
//   //     boxShadow: [
//   //       BoxShadow(
//   //         color: Colors.grey,
//   //         offset: Offset(0.0, 1.0), //(x,y)
//   //         blurRadius: 6.0,
//   //       )
//   //     ]),
//   child: Padding(
//   padding: const EdgeInsets.all(5.0),
//   child: TextField(
//   decoration: InputDecoration(
//   border: UnderlineInputBorder(),
//   hintText: 'Enter a search term',
//   labelText: "Month: "
//   ),
//   ),
//
//   ),)]
//
//
//   );
// }
