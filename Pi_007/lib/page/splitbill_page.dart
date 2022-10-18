import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SplitBillPage extends StatelessWidget{

  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const main_section =  Color(0xFFC9C5F9);   //purple
  static const action_button =  Color(0xFFF8C8DC);  //pink
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const secondary_section =  Color(0xFFC5E0F9); //blue
  static const list_color =  Color(0xFFECECEC);  //grey

  List<Bill> billList = [
    Bill(
      "Hot pot with JC friends",
      103.50,
      DateTime.parse("2022-09-04")
    ),
  ];


  @override
  Widget build(BuildContext context) => Scaffold(
      body:
        ListView.builder(
          itemCount: billList.length,
          itemBuilder: (context, index) {
            return _displayCard(billList[index]);
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
          onPressed: () async {
            // add route here
          }
      ),
  );
}

class Bill {
  final String name;
  final double amount;
  final DateTime date;

  const Bill(this.name, this.amount, this.date);
}

Widget _displayCard(Bill bill) {
  return Card(
    child:
      Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 20.0,
          bottom: 20.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('yyyy-MM-dd').format(bill.date), style: TextStyle(fontSize: 16)),
            Text(bill.name, style: TextStyle(fontSize: 16)),
            Text("\$" + (bill.amount).toStringAsFixed(2), style: TextStyle(fontSize: 16, color: Colors.red)),
          ]
        ),
      ),
    elevation:5,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)),
    color: Color(0xFFF7F7F7),
    margin: const EdgeInsets.only(bottom: 20)
  );
}