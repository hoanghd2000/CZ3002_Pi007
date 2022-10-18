import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/page/add_transaction.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:pi_007/static_data/txn.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../main.dart';
import 'edit_transaction.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final DbTrans_Manager dbmanager = new DbTrans_Manager();

  Transaction txn;
  List<Transaction> txnList;
  // Iterable<String> txnTimestampList;
  List<String> distinctTimestampList;
  Map<String, int> timestampMap;
  int updateIndex;

  // Processing script: return a object with 2 attributes:
  // price_list for list of objects and their price,
  // total for total amt of receipt

  // jsonResult = {"price_list" : {"item1" : "10.00", "ITEM2" : "13.00"}, "totalAmt" : "100.00"}

  Map<String, dynamic> modelOutput = {
    'price_list': {
      'CARRIER BAG': '0.20',
      'TOP CONC LIQ DIG ANTI-BA': '7.45',
      'SOUTH AFRICA HONEY NADO': '3.15',
      'ORION CHOCOLATE PIE': '14.30'
    },
    'total': '14.30'
  };

  static const action_button = Color(0xFFF8C8DC); //pink

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Text("Transactions list here", style: TextStyle(fontSize: 40)),

          /************* debug code BEGIN ************/
          TextButton(
            onPressed: () {
              dbmanager.deleteAllTransaction();
              _navigateBack(context);
            },
            child: Text("delete all txn"),
          ),
          TextButton(
            onPressed: () => _generate2022data(),
            child: Text("generate data"),
          ),

          // TODO: TEXT REC (in txn page)
          // (1) convert json mapping to list of Bill instances
          // (2) fire up edit_transaction page as many times as no. of items (nah)
          // (3) insert into database
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Text(
              modelOutput.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: () => _convertModelResult(context), 
            // {
              // await _convertModelResult(context).then((Future<List<Transaction>> tList) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => editTransactionPage(tList[0])));
              // });
              // await dbmanager.insertTransaction(first);
            //   _convertModelResult(context);              
            // },
            child: Text("edit & add into db"),
          ),

          // TextButton(
          //   onPressed: () => _addTransaction(true),
          //   child: Text("add dummy spending"),
          // ),
          // TextButton(
          //   onPressed: () => _addTransaction(false),
          //   child: Text("add dummy earning"),
          // ),
          // TextButton(
          //   onPressed: () => _getTxnByYear(),
          //   child: Text("get txn by year"),
          // ),
          /************* debug code END ************/

          FutureBuilder(
            future: dbmanager.getAllTransactionOrderBy('timestamp DESC'),
            // future: dbmanager.getTransactionByYear(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Transaction>> snapshot) {
              if (snapshot.hasData) {
                txnList = snapshot.data;

                // find distinct dates
                distinctTimestampList =
                    txnList.map((txn) => txn.timestamp).toSet().toList();

                // finding number of duplicate dates: {timestamp : number of duplicates}
                timestampMap = <String, int>{};
                txnList.forEach((txn) => timestampMap[txn.timestamp] =
                    !timestampMap.containsKey(txn.timestamp)
                        ? (1)
                        : (timestampMap[txn.timestamp] + 1));

                // print(txnList.toString());
                // print(distinctTxnTimestampList);
                // print(timestampMap);

                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: timestampMap.length,
                  itemBuilder: (context, index) {
                    // sort here, or in SQL
                    return _displayCard(distinctTimestampList[index]);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: action_button,
          foregroundColor: Colors.black,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("New Receipt", textAlign: TextAlign.center),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: <Widget>[
                        Column(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                _navigateToNextScreen(context);
                              },
                              child: Text('Add Manually'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: action_button, //background
                                onPrimary: Colors.black, //foreground
                              ),
                            ),

                            // TODO: TEXT REC (in txn page)
                            // (1) convert json mapping to list of Bill instances
                            // (2) fire up edit_transaction page as many times as no. of items
                            // (3) insert into database

                            ElevatedButton(
                              onPressed: () {
                                // result = navigator.push ... (open camera, and to model)
                                // for each item, open the add page and autofill entries (_addMultipleTxn())
                              },
                              child: Text('Add from camera'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: action_button, //background
                                onPrimary: Colors.black, //foreground
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // result = navigator.push ... (open gallery, and to model)
                                // for each item, open the add page and autofill entries (_addMultipleTxn())
                              },
                              child: Text('Add from gallery'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: action_button, //background
                                onPrimary: Colors.black, //foreground
                              ),
                            )
                          ],
                        )
                      ],
                    ));
          }),
    );
  }

  void _convertModelResult(BuildContext context) {
    // Map<String, String> priceMap = modelOutput['price_list'];
    // List total = modelOutput['total'];
    // List<String> itemList = priceMap.keys;

    // List<Transaction> newTxnList = [];

    // method 1: insert into db prematurely, then call edit query, and delete query if needed
    // method 2: dynamically store into the var in edit page for each Transaction instance, then insert

    // method 0.5
    Map<String, String> priceMap = modelOutput['price_list'];
    List<Transaction> newTxnList = [];

    // create txn instances
    priceMap.forEach((item, amt) => newTxnList.add(Transaction(
        spendings: 1,
        category: "",
        name: item,
        amount: double.parse(amt),
        timestamp: DateFormat('yyyy-MM-dd').format(DateTime.now()))));

    // // repeat edit_transaction page for no. of times as no. of items
    newTxnList.forEach((txn) {
      dbmanager.insertTransaction(txn);
    });

    _navigateBack(context);

    // return newTxnList;

    // newTxnList.forEach((txn) => dbmanager.insertTransaction(txn));
    // newTxnList.forEach((txn) => Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => editTransactionPage(txn))));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => addTransactionPage()));
  }

  void _generate2022data() {
    var data = get2022data();
    for (var i = 0; i < data.length; i++) {
      dbmanager.insertTransaction(data[i]);
    }
    _navigateBack(context);
  }

  Widget _displayCard(String timestamp) {
    // filter out txn of that date
    int numTxn = timestampMap[timestamp];
    var dailyTxnList =
        txnList.where((txn) => txn.timestamp == timestamp).toList();
    // print(txnListOfDate);

    // get total spending in a day
    double overallAmount = 0.0;
    dailyTxnList.forEach((txn) =>
        overallAmount += txn.spendings == 1 ? -1 * txn.amount : txn.amount);

    double absAmount = overallAmount >= 0 ? overallAmount : -1 * overallAmount;

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                // header
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(timestamp, style: TextStyle(fontSize: 16))),
                  // Expanded(
                  //     flex: 1,
                  //     child: Text("\$ total",
                  //         style: TextStyle(fontSize: 16, color: Colors.red))),
                  // Expanded(
                  //     flex: 1,
                  //     child: Text("\$ total",
                  //         style: TextStyle(fontSize: 16, color: Colors.blue))),
                  Expanded(
                      flex: 3,
                      child: Text(
                          (overallAmount >= 0 ? "+" : "-") +
                              " \$ ${absAmount.toStringAsFixed(2)}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: SizedBox.shrink()),
                ],
              ),
              // Center(
              //   child: Text(timestamp, style: TextStyle(fontSize: 16)),
              // ),
              ListView.builder(
                // primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: numTxn,
                itemBuilder: (context, index) {
                  // sort here, or in SQL
                  return _displayCardItem(dailyTxnList[index]);
                },
              )
            ],
          )),
    );
  }

  Widget _displayCardItem(Transaction txn) {
    return Row(children: [
      Expanded(
          flex: 2,
          child: Text((txn.category ?? ""), style: TextStyle(fontSize: 16))),
      Expanded(flex: 2, child: Text(txn.name, style: TextStyle(fontSize: 16))),
      Expanded(
          flex: 3,
          child: (txn.spendings == 1)
              ? Text("- \$ ${txn.amount}",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16, color: Colors.red))
              : Text("+ \$ ${txn.amount}",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16, color: Colors.blue))),
      Expanded(flex: 1, child: SizedBox.shrink()),
      Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () async {
                // print("edit transaction ${txn.id}" );
                // how to pass the index of id into txn list
                final edittedresult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => editTransactionPage(txn)));
                // print(edittedresult);
              },
              icon: Icon(Icons.edit))),
    ]);
  }

  // Expanded(flex: 2, child: SizedBox.shrink())
  // Expanded(
  //     flex: 1,
  //     child: (txn.spendings == 0)
  //         ? Text("+ \$ ${txn.amount}",
  //             style: TextStyle(fontSize: 16, color: Colors.blue))
  //         : SizedBox.shrink()),

  // void printObject(Object object) {
  //   // Encode your object and then decode your object to Map variable
  //   Map jsonMapped = json.decode(json.encode(object));

  //   // Using JsonEncoder for spacing
  //   JsonEncoder encoder = new JsonEncoder.withIndent('  ');

  //   // encode it to string
  //   String prettyPrint = encoder.convert(jsonMapped);

  //   // print or debugPrint your object
  //   print(prettyPrint);
  // }

}

void _navigateBack(BuildContext context) {
  // Navigator.pop(context);
  // Navigator.pop(context);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
  // Navigator.pushNamed(
  //   context,
  //   'Transactions',
  //   // arguments: noteId,
  // );
  // // _refreshData();
}
