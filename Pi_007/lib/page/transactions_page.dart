import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pi_007/databases/db_categories.dart';
import 'package:pi_007/page/add_transaction.dart';
import 'package:pi_007/databases/db_transactions.dart';
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
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey
  static const cancel_button = Color(0xFFFA7979);

  final DbTrans_Manager dbmanager = DbTrans_Manager();
  final DbCats_Manager dbCats_Manager = DbCats_Manager();

  final Map<String, IconData> myIconCollection = {
    'favorite': Icons.favorite,
    'home': Icons.home,
    'android': Icons.android,
    'album': Icons.album,
    'ac_unit': Icons.ac_unit,
    'access_alarm': Icons.access_alarm,
    'access_time': Icons.access_time,
    'umbrella_sharp': Icons.umbrella_sharp,
    'headphones': Icons.headphones,
    'car_repair': Icons.car_repair,
    'settings': Icons.settings,
    'flight': Icons.flight,
    'run_circle': Icons.run_circle,
    'book': Icons.book,
    'sports_rugby_rounded': Icons.sports_rugby_rounded,
    'alarm': Icons.alarm,
    'call': Icons.call,
    'snowing': Icons.snowing,
    'hearing': Icons.hearing,
    'music_note': Icons.music_note,
    'note': Icons.note,
    'edit': Icons.edit,
    'sunny': Icons.sunny,
    'radar': Icons.radar,
    'wallet': Icons.wallet,
    'food': Icons.fastfood,
    'shopping': Icons.shopping_bag,
    'car': Icons.directions_car,
    'work': Icons.work,
    'dollar_sign': Icons.attach_money,
    'dollar_bill': Icons.money_sharp,
    'savings': Icons.savings,
    'bitcoin': Icons.currency_bitcoin,
    'currency_exchange': Icons.currency_exchange,
  };

  final Map<String, String> monthMap = {
    '01': 'January',
    '02': 'February',
    '03': 'March',
    '04': 'April',
    '05': 'May',
    '06': 'June',
    '07': 'July',
    '08': 'August',
    '09': 'September',
    '10': 'October',
    '11': 'November',
    '12': 'December',
  };

  Transaction txn;
  List<Transaction> txnList;
  Map<String, String> catMap;
  // Iterable<String> txnTimestampList;
  List<String> distinctDayList;
  List<String> distinctMonthList;
  Map<String, int> dayCountMap = {};
  Map<String, int> monthCountMap = {};
  int updateIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Text("Transactions list here", style: TextStyle(fontSize: 40)),

          /************* debug code BEGIN ************/
          // TextButton(
          //   onPressed: () {
          //     dbmanager.deleteAllTransaction();
          //     _navigateBack(context);
          //   },
          //   child: Text("delete all txn"),
          // ),
          // TextButton(
          //   onPressed: () => _generateData(),
          //   child: Text("generate data"),
          // ),
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
            future: Future.wait([
              dbmanager.getAllTransactionOrderBy('timestamp DESC'),
              dbCats_Manager.getCategoriesMap()
            ]),
            // future: dbmanager.getAllSpendingOrderBy('timestamp ASC'),
            builder:
                (BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
              if (snapshot.hasData) {
                txnList = snapshot.data[0];
                catMap = snapshot.data[1];

                // find distinct months
                distinctMonthList = txnList
                    .map((txn) => txn.timestamp.substring(0, 7))
                    .toSet()
                    .toList();

                // find number of duplicate months: {yyyy-MM : number of duplicates}
                txnList.forEach((txn) => monthCountMap[
                        txn.timestamp.substring(0, 7)] =
                    !monthCountMap.containsKey(txn.timestamp.substring(0, 7))
                        ? (1)
                        : (monthCountMap[txn.timestamp.substring(0, 7)] + 1));

                // find distinct dates
                distinctDayList =
                    txnList.map((txn) => txn.timestamp).toSet().toList();

                // finding number of duplicate dates: {yyyy-MM-dd : number of duplicates}
                txnList.forEach((txn) => dayCountMap[txn.timestamp] =
                    !dayCountMap.containsKey(txn.timestamp)
                        ? (1)
                        : (dayCountMap[txn.timestamp] + 1));

                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: distinctMonthList.length,
                  itemBuilder: (context, index) {
                    // sort here, or in SQL
                    return _displayMonthCard(distinctMonthList[index]);
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
                            // spinner here?
                            ElevatedButton(
                              onPressed: () {
                                _navigateToAddPage(context);
                                // dbmanager
                                //     .getAllTransactionOrderBy('timestamp DESC')
                                //     .then((value) =>
                                //         {txnList = value, _setApp()});
                                //(context as Element).reassemble();
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

  void _setApp() {
    setState(() {});
  }

  // void _generateData() {
    // var data = getRandomTxn();
    // for (var i = 0; i < data.length; i++) {
    //   dbmanager.insertTransaction(data[i]);
    // }
    // _navigateBack(context);
  // }

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

  Widget _displayMonthCard(String timestamp) {
    // yyyy-MM
    // filter out txn of that month
    // String monthTimestamp = timestamp.substring(0, 7);
    // int numTxn = monthCountMap[monthTimestamp];
    // List<Transaction> monthlyTxnList = txnList
    //     .where((txn) => txn.timestamp.substring(0, 7) == monthTimestamp)
    //     .toSet()
    //     .toList();

    // int numDistinctDayInAMonth = 0;

    // txnList.forEach((txn) {
    //   if (txn.timestamp.substring(0, 7) == monthTimestamp) {
    //     numMonthlyTxn++;
    //   }
    // });

    // distinctDayList.forEach((date) {
    //   if (date.substring(0, 7) == monthTimestamp) {
    //     numDistinctDayInAMonth++;
    //   }
    // });

    // Map<String, int> distinctDayInAMonthCountMap = {};
    // distinctDayList.forEach((date) {
    //   if (date.substring(0, 7) == monthTimestamp) {
    //     numDistinctDayInAMonth++;
    //   }
    // });

    List<String> distinctDayInAMonthList = [];
    distinctDayList.forEach((date) {
      // next time use .where
      if (date.substring(0, 7) == timestamp) {
        distinctDayInAMonthList.add(date);
      }
    });

    String yyyyMM = timestamp.substring(0, 7);
    String yyyy = yyyyMM.substring(0, 4);
    String mmmm = monthMap[yyyyMM.substring(5, 7)];

    // print(monthTimestamp);
    // print(monthlyTxnList);

    // print(distinctDayInAMonthList[0]);
    // print(DateTime.parse(distinctDayInAMonthList[0]));
    // print(DateFormat.yMMMM(DateTime.parse(distinctDayInAMonthList[0])));

    return Card(
      margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                    color: main_section,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Row(
                  // header
                  children: [
                    Expanded(
                        child: Text(mmmm + ' ' + yyyy,
                            // child: Text((DateFormat.yMMMM(DateTime.parse(distinctDayInAMonthList[0]))).toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center)),
                  ],
                ),
              ),
              // Center(
              //   child: Text(timestamp, style: TextStyle(fontSize: 16)),
              // ),
              ListView.builder(
                // primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: distinctDayInAMonthList.length,
                itemBuilder: (context, index) {
                  // sort here, or in SQL
                  return _displayDayCard(distinctDayInAMonthList[index]);
                },
              )
            ],
          )),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color(0xFFF7F7F7),
    );
  }

  Widget _displayDayCard(String timestamp) {
    // yyyy-MM-dd
    List<Transaction> dailyTxnList =
        txnList.where((txn) => txn.timestamp == timestamp).toList();
    // print(txnListOfDate);

    // get total spending in a day
    double overallAmount = 0.0;
    dailyTxnList.forEach((txn) =>
        overallAmount += txn.spendings == 1 ? -1 * txn.amount : txn.amount);

    double absAmount = overallAmount >= 0 ? overallAmount : -1 * overallAmount;

    String dd = timestamp.substring(8, 10);

    return Card(
      margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                // padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                decoration: const BoxDecoration(
                    color: secondary_section,
                    // border: Border(bottom: BorderSide(color: Colors.black)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Row(
                  // header
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            color: secondary_section,
                            // border: Border.all(color: Colors.black, width: 2),
                            // borderRadius: const BorderRadius.all(Radius.circular(12))),
                          ),
                          child: Text(
                            dd,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )),
                    ),
                    Expanded(flex: 3, child: SizedBox.shrink()),
                    Expanded(
                        flex: 3,
                        child: Text(
                            (overallAmount >= 0 ? "+" : "-") +
                                " \$ ${absAmount.toStringAsFixed(2)}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: SizedBox.shrink()),
                  ],
                ),
              ),
              ListView.builder(
                // primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dailyTxnList.length,
                itemBuilder: (context, index) {
                  // sort here, or in SQL
                  return _displayTxnItem(dailyTxnList[index]);
                },
              )
            ],
          )),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      color: Color(0xFFF7F7F7),
    );
  }

  Widget _displayTxnItem(Transaction txn) {
    return Row(children: [
      Expanded(flex: 1, child: Icon(myIconCollection[catMap[txn.category]])),
      Expanded(flex: 4, child: Text(txn.name, style: TextStyle(fontSize: 16))),
      Expanded(
          flex: 2,
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
