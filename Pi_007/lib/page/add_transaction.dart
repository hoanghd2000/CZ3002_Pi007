
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
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Spendings'),
                    controller: _spendingsController,
                    validator: (val) => val.isNotEmpty? null:'Spendings should not be empty',
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
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Category'),
                    controller: _categoryController,
                    validator: (val) => val.isNotEmpty? null:'Name should not be empty',
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
        if(_spendingsController.text=="true"){
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
          category:_categoryController.text,
          note:_noteController.text,
        );
        //after transaction is added, clear the textfields
        dbTrans_manager.insertTransaction(tr).then((id)=>{
          _spendingsController.clear(),
          _timeController.clear(),
          _nameController.clear(),
          _amountController.clear(),
          _categoryController.clear(),
          _noteController.clear(),
          print('Transaction added to Trans_database ${id}')
        });
      }
    }
  }
}

