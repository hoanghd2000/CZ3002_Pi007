import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBudget extends StatelessWidget{

  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const main_section =  Color(0xFFC9C5F9);   //purple
  static const action_button =  Color(0xFFF8C8DC);  //pink
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const secondary_section =  Color(0xFFC5E0F9); //blue
  static const list_color =  Color(0xFFECECEC);  //grey

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Add Budget'),
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
