import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pi_007/page/add_transaction.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:pi_007/page/camera.dart';
import 'package:pi_007/static_data/txn.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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
            onPressed: () => _generateData(),
            child: Text("generate data"),
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
            // future: dbmanager.getAllSpendingOrderBy('timestamp ASC'),
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
                                _navigateToAddPage(context);
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
                              onPressed: () async {
                                _addImage(context, ImageSource.camera);
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
                              onPressed: () async {
                                _addImage(context, ImageSource.gallery);
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

  void _navigateToAddPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => addTransactionPage()));
  }

  void _generateData() {
    var data = getRandomTxn();
    for (var i = 0; i < data.length; i++) {
      dbmanager.insertTransaction(data[i]);
    }
    _navigateBack(context);
  }

  void _addImage(BuildContext context, ImageSource imgSrc) async {
    // Initialize an ImagePicker
    final ImagePicker _picker = ImagePicker();
    // Pick an image from Gallery
    final XFile image = await _picker.pickImage(source: imgSrc);
    if (image != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://34.173.115.34/textrec'),
      );
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.headers.addAll(<String, String>{"Accept": "application/json"});
      // Send the request to the text rec server
      var response = await request.send();
      var res = await http.Response.fromStream(response);
      // await Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => Scaffold(body: Text(res.body)))
      // );

      // extract output from response
      Map decodedOutput = await jsonDecode(res.body);
      Map priceMap = await decodedOutput['price_list'];

      // example of decodedOutput
      // {"price_list" : {"item1" : "10.00", "ITEM2" : "13.00"}, "totalAmt" : "100.00"}

      // create txn instances
      List<Transaction> newTxnList = [];
      priceMap.forEach((item, amt) => newTxnList.add(Transaction(
          spendings: 1,
          category: "",
          name: item,
          amount: double.parse(double.parse(amt).toStringAsFixed(2)),
          timestamp: DateFormat('yyyy-MM-dd').format(DateTime.now()))));

      // repeat edit_transaction page for no. of times as no. of items
      // nah

      // insert each txn into db
      newTxnList.forEach((txn) => dbmanager.insertTransaction(txn));

      _navigateBack(context);
    }
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
                    //     child: Text("\$ total", // TODO
                    //         style: TextStyle(fontSize: 16, color: Colors.red))),
                    // Expanded(
                    //     flex: 1,
                    //     child: Text("\$ total", // TODO
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
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Color(0xFFF7F7F7),
        margin: const EdgeInsets.only(
          bottom: 8,
        ));
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
              ? Text("- \$ ${txn.amount.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16, color: Colors.red))
              : Text("+ \$ ${txn.amount.toStringAsFixed(2)}",
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
}

void _navigateBack(BuildContext context) {
  // Navigator.pop(context);
  // Navigator.pop(context);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
}
