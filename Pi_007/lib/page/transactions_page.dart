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
    // Transaction t = new Transaction(
    //     spendings: true,
    //     category: "food",
    //     name: "morning",
    //     amount: 123,
    //     timestamp: "08-11-2000");
    // dbmanager.insertTransaction(t);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: Text("Transactions list here",style: TextStyle(fontSize: 40)),
      body: ListView(
        children: <Widget>[
          Text("Transactions list here", style: TextStyle(fontSize: 40)),
          TextButton(
            onPressed: () => _addTransaction(),
            child: Text("TEXT BUTTON"),
          ),
          FutureBuilder(
            future: dbmanager.getTransactionList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                txnList = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: txnList == null ? 0 : txnList.length,
                  itemBuilder: (BuildContext context, int index) {
                    txn = txnList[index];
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(0.0),
                            width: width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Name: ${txn.name}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Course: ${txn.amount}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),

                          //  IconButton(onPressed: (){
                          //    _nameController.text=st.name;
                          //    _courseController.text=st.course;
                          //    student=st;
                          //    updateIndex = index;
                          //  }, icon: Icon(Icons.edit, color: Colors.blueAccent,),),
                          // IconButton(onPressed: (){
                          //   dbmanager.deleteStudent(st.id);
                          //   setState(() {
                          //    txnList.removeAt(index);
                          //   });
                          // }, icon: Icon(Icons.delete, color: Colors.red,),)
                        ],
                      ),
                    );
                  },
                );
              }
              return new CircularProgressIndicator();
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
    .push(MaterialPageRoute(builder: (context) => addTransaction()));
  }

  void _addTransaction() {
    Transaction t = new Transaction(
        spendings: 1,
        category: "food",
        name: "hi",
        amount: 123,
        timestamp: "08-11-2000");
    dbmanager.insertTransaction(t);
  }
}
