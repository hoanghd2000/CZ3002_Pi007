
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/page/add_transaction.dart';


class TransactionsPage extends StatelessWidget{

  static const action_button =  Color(0xFFF8C8DC);  //pink

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView(children: <Widget>[
      Text('Transactions Page',style: TextStyle(fontSize: 40)),
      Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: (){
              _navigateToNextScreen(context);
            },
            child: Text('Add Manually'),
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              primary: action_button,  //background
              onPrimary: Colors.black, //foreground
            ),
          ),
          ElevatedButton(
            onPressed: (){
             //add page for image recognition here
            },
            child: Text('Add image of receipt'),
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              primary: action_button,  //background
              onPrimary: Colors.black, //foreground
            ),
          ),
        ],
      ),
  ]
  ,),

  );

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => addTransaction()));

  }
}

