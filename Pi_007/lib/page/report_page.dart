import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget{

  static const action_button =  Color(0xFFF8C8DC);  //pink

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView(children: <Widget>[
      Text('Report Page',style: TextStyle(fontSize: 40)),
      SizedBox(height:15),
      Text('   Select Time Interval:',style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
      SizedBox(height:10),

      Row(
        children: <Widget>[

          SizedBox(width:15),
          ElevatedButton(
            onPressed: (){
              //display weekly report
            },
            child: Text('View Weekly'),
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              primary: action_button,  //background
              onPrimary: Colors.black, //foreground
            ),
          ),
          SizedBox(width:15),
          ElevatedButton(
            onPressed: (){
              //display monthly report
            },
            child: Text('View Monthly'),
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              primary: action_button,  //background
              onPrimary: Colors.black, //foreground
            ),
          ),
          SizedBox(width:15),
          ElevatedButton(
            onPressed: (){
              //display yearly report
            },
            child: Text('View Yearly'),
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
      SizedBox(height:230),

      Text('   Budget for the month:',style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
      SizedBox(height:10),
      new LinearProgressIndicator(
        minHeight: 14.0,
        value: 0.6,
        backgroundColor: Colors.indigo[100],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[300],),
      ),
      SizedBox(height:15),

      Text('   Budget by category:',style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
      SizedBox(height:10),
      Text('    Food:',style: TextStyle(fontSize:15)),
      SizedBox(height:5),
      new LinearProgressIndicator(
        minHeight: 14.0,
        value: 0.8,
        backgroundColor: Colors.teal[50],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[200],),
      ),
      SizedBox(height:5),
      Text('    Transport:',style: TextStyle(fontSize:15)),
      SizedBox(height:5),
      new LinearProgressIndicator(
        minHeight: 14.0,
        value: 0.8,
        backgroundColor: Colors.deepOrange[50],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange[200],),
      ),





    ]
  )
  );

  }
