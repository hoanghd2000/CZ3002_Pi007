import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SplitBillPage extends StatelessWidget {
  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey

  List<Bill> billList = [
    Bill("Hot pot with JC friends", 103.50, DateTime.parse("2022-09-04")),
  ];

  Map<String, dynamic> modelOutput = {
    'price_list': {
      'Prawns': '20.00',
      'Chicken': '15.50',
      'Mushroom': '12.00',
      'Potato': '8.50',
      'Tofu': '4.00',
    },
    'total': '50.00'
  };

  Map<String, List<String>> itemPayerMap = {
    'Prawns': ['Me', 'John', 'Jimmy', 'Jackson'], // 5 each
    'Chicken': ['Me', 'Jimmy', 'Jackson'], // 5.17 each (round up)
    'Mushroom': ['John', 'Jimmy'], // 6 each
    'Potato': ['Me', 'John'], // 4.25 each
    'Tofu': ['Jackson'], // 4
  };

  // Me = 14.42, john = 15.25, jimmy = 16.17, jackson = 14.17

  Map<String, double> payerAmountMap = {};

  @override
  Widget build(BuildContext context) => Scaffold(
      body: ListView(children: <Widget>[
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: billList.length,
          itemBuilder: (context, index) {
            return _displayCard(billList[index]);
          },
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        ),

        // TODO: TEXT REC (in splitbill page)
        // (1) after text tec, convert json mapping to list of Bill instances
        // (2) [edit_group_spending_page] fire up edit_transaction page as many times as no. of items + assign payers
        // OR splitbill_spendings.dart, to show temp list of transaction saved in a temp db
        // (3) get mapping of spending_item to list of payers
        // (4) calculate amt owed for each payer (convert to mapping of payer to list of spending_item & amount owed)
        // (5) display UI
        // (6) opt: have a button to auto-add your own "ME" spendings to transaction page

        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Text(
            modelOutput.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Text(
            itemPayerMap.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(
          onPressed: () {
            payerAmountMap = {};
            _calcPayerAmt();
          },
          child: Text("calculate amount spent by each payer"),
        ),
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Text(
            payerAmountMap.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: action_button,
          foregroundColor: Colors.black,
          onPressed: () async {}));

  void _calcPayerAmt() {
    // Map<String, dynamic> modelOutput = {
    //   'price_list': {
    //     'Prawns': '20.00',
    //     'Chicken': '15.50',
    //     'Mushroom': '12.00',
    //     'Potato': '8.50',
    //     'Tofu': '4.00',
    //   },
    //   'total': '50.00'
    // };

    // Map<String, List<String>> itemPayerMap = {
    //   'Prawns': ['Me', 'John', 'Jimmy', 'Jackson'],
    //   'Chicken': ['Me', 'Jimmy', 'Jackson'],
    //   'Mushroom': ['John', 'Jimmy'],
    //   'Potato': ['Me', 'John'],
    //   'Tofu': ['Jackson'],
    // };

    // List<String> allPayerList = ['Me', 'John', 'Jimmy', 'Jackson'];

    Map<String, String> itemAmtMap = modelOutput['price_list'];

    // calculate the split amount for each item = item price / no. of payer for that item
    // {'Prawns': 4.00, 'Chicken': 5.17, ...}
    Map<String, double> itemSplitAmtMap = {};
    itemAmtMap.forEach((item, amt) => itemSplitAmtMap[item] = double.parse(
        (double.parse(amt) / itemPayerMap[item].length).toStringAsFixed(2)));

    // Map<String, double> payerAmountMap = {};

    // for each item, then for each payer, accumulate the amount owed
    itemPayerMap.forEach((item, payerList) => payerList.forEach((payer) =>
        payerAmountMap[payer] = payerAmountMap.containsKey(payer)
            ? payerAmountMap[payer] += itemSplitAmtMap[item]
            : itemSplitAmtMap[item]));

    // format the doubles nicely
    payerAmountMap.forEach((payer, amt) =>
        payerAmountMap[payer] = double.parse(amt.toStringAsFixed(2)));
  }
}

class Bill {
  final String name;
  final double amount;
  final DateTime date;

  const Bill(this.name, this.amount, this.date);
}

Widget _displayCard(Bill bill) {
  return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(DateFormat('yyyy-MM-dd').format(bill.date),
              style: TextStyle(fontSize: 16)),
          Text(bill.name, style: TextStyle(fontSize: 16)),
          Text("\$" + (bill.amount).toStringAsFixed(2),
              style: TextStyle(fontSize: 16, color: Colors.red)),
        ]),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color(0xFFF7F7F7),
      margin: const EdgeInsets.only(bottom: 20));
}
