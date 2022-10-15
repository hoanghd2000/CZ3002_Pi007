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

  // Bill bill;
  // List<Bill> billList;

  // sample hard coded data
  final billList = List.generate(
    8,
        (i) => Bill(
        'Bill $i',
        50.00,
        DateTime.parse("2022-10-0${i+1}")),
  );

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
  const IconData create_sharp = IconData(0xe89b, fontFamily: 'MaterialIcons');

  return Card(
    child:
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('yyyy-MM-dd').format(bill.date), style: TextStyle(fontSize: 16)),
            Text(bill.name, style: TextStyle(fontSize: 16)),
            Text("\$" + (bill.amount).toStringAsFixed(2), style: TextStyle(fontSize: 16, color: Colors.red)),
            IconButton(
                icon: const Icon(create_sharp),
                color: Colors.black,
                onPressed: () async {

                }
            ),
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