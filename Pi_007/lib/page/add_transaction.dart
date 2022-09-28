
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';


class addTransaction extends StatelessWidget{
  final DbTrans_Manager dbTrans_manager = new DbTrans_Manager();

  final _spendingsController = TextEditingController();
  final _categoryController = TextEditingController();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _timeController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  Transaction transaction;
  List<Transaction> translist;
  int updateIndex;

  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const list_color =  Color(0xFFECECEC);  //grey

  static const List<String> list1 = <String>['Spendings', 'Earnings'];
  static const List<String> list2 = <String>['Food', 'Transport','Shopping'];
  String spendingslist = list1.first;
  String categorylist = list2.first;


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Add Manually'),
        backgroundColor: navigation_bar,
        foregroundColor: Colors.black,
      ),
      body: ListView(children: <Widget>[
        Form(key:_formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  DropdownButton<String>(
                    value: spendingslist,
                    dropdownColor: list_color,
                    icon: const Icon(Icons.expand_more),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String value) {
                      spendingslist = value;
                    },
                    items: list1.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Date'),
                    controller: _timeController,
                    validator: (val) => val.isNotEmpty? null:'Date should not be empty',
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Name'),
                    controller: _nameController,
                    validator: (val) => val.isNotEmpty? null:'Name should not be empty',
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    validator: (val) => val.isNotEmpty? null:'Amount should not be empty',
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text('Category',style: TextStyle(fontSize: 15,color: Colors.grey[700]),),
                        padding: EdgeInsets.only(right:15.0)),
                      DropdownButton<String>(
                        value: categorylist,
                        dropdownColor: list_color,
                        icon: const Icon(Icons.expand_more),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String value) {
                          categorylist = value;
                        },
                        items: list2.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Note'),
                    controller: _noteController,
                  ),

                  ElevatedButton(
                      onPressed: (){
                        _submitTransaction(context);
                      },
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        primary: confirm_button,  //background
                        onPrimary: Colors.black, //foreground
                      )

                  )
                ],
              ),
            )
        ),
      ],
      )
  );

  void _submitTransaction(BuildContext context){
    if(_formKey.currentState.validate()){
      if(transaction==null){
        bool spendings;
        if(spendingslist=="spendings"){
          spendings=true;
        }
        else{
          spendings=false;
        }
        Transaction tr = new Transaction(
          spendings: spendings,
          timestamp:_timeController.text,
          name: _nameController.text,
          amount: double.parse(_amountController.text),
          category:categorylist,
          note:_noteController.text,
        );
        //after transaction is added, clear the textfields
        dbTrans_manager.insertTransaction(tr).then((id)=>{
          _timeController.clear(),
          _nameController.clear(),
          _amountController.clear(),
          _noteController.clear(),
          print('Transaction added to Trans_database ${id}')
        });
      }
    }
  }
}

