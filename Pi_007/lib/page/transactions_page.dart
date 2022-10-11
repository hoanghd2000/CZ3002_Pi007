
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/page/add_transaction.dart';

import '../databases/db_transactions.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: TransactionsPage(),
    );
  }

}
class TransactionsPage extends StatefulWidget {
  @override
  State<TransactionsPage> createState() => _TransactionPage();
}
class _TransactionPage extends State<TransactionsPage>{
  final DbTrans_Manager dbTrans_manager = new DbTrans_Manager();
  static const action_button =  Color(0xFFF8C8DC);  //pink

  Transaction transaction;
  List<Transaction> translist;
  int updateIndex;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Text("Transaction List here",style:TextStyle(fontSize: 40)),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: action_button,
        foregroundColor: Colors.black,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("New Receipt",textAlign: TextAlign.center),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  Column(
                    children:<Widget> [
                      ElevatedButton(
                        onPressed: (){
                          _navigateToNextScreen(context);
                        },
                        child: Text('Add Manually'),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.black,),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          primary: action_button,  //background
                          onPrimary: Colors.black, //foreground
                        ),
                      ),
                      ElevatedButton(
                      onPressed: (){
                      //add page for image recognition here
                      },
                      child: Text('Add image of receipt'),
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.black,),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                        ),
                      primary: action_button,  //background
                      onPrimary: Colors.black, //foreground
                      ),
                    )
                  ],
              )],
            )
          );
        }
    ),

  );

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => addTransaction()));

  }
}

