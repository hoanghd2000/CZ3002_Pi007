import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditBudget extends StatelessWidget{

  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const main_section =  Color(0xFFC9C5F9);   //purple
  static const action_button =  Color(0xFFF8C8DC);  //pink
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const secondary_section =  Color(0xFFC5E0F9); //blue
  static const list_color =  Color(0xFFECECEC);  //grey
  static const cancel_button = Color(0xFFFA7979);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Edit Budget'),
      backgroundColor: navigation_bar,
      foregroundColor: Colors.black,
    ),

    body: Form(
        key: _formKey,
        child: Column(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Month"
                  ),
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 5.0),
                  child: TextButton(onPressed: (){
                    showAlertDialog(context);
                  }, child: Text("Delete"), style: TextButton.styleFrom(
                    backgroundColor: cancel_button,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(
                        left: 30,
                        right: 30
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),),
                ),
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Done"), style: TextButton.styleFrom(
                  backgroundColor: confirm_button,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.only(
                      left: 30,
                      right: 30
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),)
              ],),
            ]
        )
    ),


  );
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Budget Deleted"),
      ));
    },
  );

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 10.0,
            top: 5.0,
            bottom: 5.0
          ),
          child: Icon(Icons.delete),
        ),
        Text("Delete Budget"),
      ],
    ),
    content: Text("Are you sure you want to delete this Budget?"),
    actions: [
      cancelButton, okButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}