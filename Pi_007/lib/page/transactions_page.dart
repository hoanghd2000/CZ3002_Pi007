import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/page/add_transaction.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'dart:convert';

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

  static const action_button = Color(0xFFF8C8DC); //pink

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Text("Transactions list here", style: TextStyle(fontSize: 40)),

          /************* debug code BEGIN ************/
          TextButton(
            onPressed: () => dbmanager.deleteAllTransaction('transactions'),
            child: Text("delete all txn"),
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
                distinctTimestampList =
                    txnList.map((txn) => txn.timestamp).toSet().toList();
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
                  child: Text("No data found."),
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
                            ElevatedButton(
                              onPressed: () {
                                //add page for image recognition here
                              },
                              child: Text('Add image of receipt'),
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

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => addTransactionPage()));
  }

  // void _addTransaction(bool spendings) {

  //   dbmanager.insertTransaction(spendings ? t1 : t2);
  // }

  Widget _displayCard(String timestamp) {
    //TODO use .map to wrap each txn data into a row widget, then display according to their dates
    // filter out txn of that date
    int numTxn = timestampMap[timestamp];
    print(timestamp);
    // List txnListOfDate = txnList.map((txn) {
    //   if (txn.timestamp == timestamp) return txn;
    // });

    var txnListOfDate =
        txnList.where((txn) => txn.timestamp == timestamp).toList();
    // print(txnListOfDate);

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                // header
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(timestamp, style: TextStyle(fontSize: 16))),
                  Expanded(
                      flex: 1,
                      child: Text("\$ total", // TODO
                          style: TextStyle(fontSize: 16, color: Colors.red))),
                  Expanded(
                      flex: 1,
                      child: Text("\$ total", // TODO
                          style: TextStyle(fontSize: 16, color: Colors.blue))),
                ],
              ),
              ListView.builder(
                // primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: numTxn,
                itemBuilder: (context, index) {
                  // sort here, or in SQL
                  return _displayCardItem(txnListOfDate[index]);
                },
              )
            ],
          )),
    );
  }

  Widget _displayCardItem(Transaction txn) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Text((txn.category ?? ""), style: TextStyle(fontSize: 16))),
      Expanded(flex: 1, child: Text(txn.name, style: TextStyle(fontSize: 16))),
      Expanded(
          flex: 1,
          child: (txn.spendings == 1)
              ? Text("- \$ ${txn.amount}",
                  style: TextStyle(fontSize: 16, color: Colors.red))
              : SizedBox.shrink()),
      Expanded(
          flex: 1,
          child: (txn.spendings == 0)
              ? Text("+ \$ ${txn.amount}",
                  style: TextStyle(fontSize: 16, color: Colors.blue))
              : SizedBox.shrink()),
    ]);
  }

  void printObject(Object object) {
    // Encode your object and then decode your object to Map variable
    Map jsonMapped = json.decode(json.encode(object));

    // Using JsonEncoder for spacing
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');

    // encode it to string
    String prettyPrint = encoder.convert(jsonMapped);

    // print or debugPrint your object
    print(prettyPrint);
  }
}