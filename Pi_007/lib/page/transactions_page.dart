import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/page/add_transaction.dart';
import 'package:pi_007/databases/db_transactions.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final DbTrans_Manager dbmanager = new DbTrans_Manager();

  Transaction txn;
  List<Transaction> txnList;
  int updateIndex;

  static const action_button = Color(0xFFF8C8DC); //pink

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Text("Transactions list here", style: TextStyle(fontSize: 40)),

          /************* START debug code ************/ 
          TextButton(
            onPressed: () => dbmanager.deleteAllTransaction('transactions'),
            child: Text("delete all txn"),
          ), 
          TextButton(
            onPressed: () => _addTransaction(true),
            child: Text("add dummy spending"),
          ),
          TextButton(
            onPressed: () => _addTransaction(false),
            child: Text("add dummy earning"),
          ),
          /************* END debug code ************/ 

          FutureBuilder(
            future: dbmanager.getTransactionList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Transaction>> snapshot) {
              if (snapshot.hasData) {
                txnList = snapshot.data;
                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: txnList.length,
                  itemBuilder: (context, index) {
                    return _displayCard(txnList[index]);
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
        .push(MaterialPageRoute(builder: (context) => AddTransactionPage()));
  }

  void _addTransaction(bool spendings) {
    Transaction t1 = new Transaction(
        spendings: 1,
        category: "Food",
        name: "Mala",
        amount: 55.0,
        timestamp: "08-11-2000");
    Transaction t2 = new Transaction(
        spendings: 0,
        category: "Allowance",
        name: "Weekly",
        amount: 30.0,
        timestamp: "31-12-2022");
    dbmanager.insertTransaction(spendings ? t1 : t2);
  }

  Widget _displayCard(Transaction txn) {
    //TODO use .map to wrap each txn data into a row widget, then display according to their dates
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child:
                          Text(txn.timestamp, style: TextStyle(fontSize: 16))),
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
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:
                          Text(txn.category, style: TextStyle(fontSize: 16))),
                  Expanded(
                      flex: 1,
                      child: Text(txn.name, style: TextStyle(fontSize: 16))),
                  Expanded(
                      flex: 1,
                      child: (txn.spendings == 1)
                          ? Text("\$ ${txn.amount}",
                              style: TextStyle(fontSize: 16, color: Colors.red))
                          : SizedBox.shrink()),
                  Expanded(
                      flex: 1,
                      child: (txn.spendings == 0)
                          ? Text("\$ ${txn.amount}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue))
                          : SizedBox.shrink()),
                ],
              ),
            ],
          )),
    );
  }

  Widget _displayAmount(Transaction txn) {
    return Row(
      children: (txn.spendings == 1)
          ? [
              Expanded(
                  flex: 1,
                  child: Text("\$ ${txn.amount}",
                      style: TextStyle(fontSize: 16, color: Colors.red))),
              Expanded(flex: 1)
            ]
          : [
              Expanded(flex: 1),
              Expanded(
                  flex: 1,
                  child: Text("\$ ${txn.amount}",
                      style: TextStyle(fontSize: 16, color: Colors.blue)))
            ],
    );
  }
}
