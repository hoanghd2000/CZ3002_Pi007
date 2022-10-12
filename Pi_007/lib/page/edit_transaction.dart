
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:intl/intl.dart';

class editTransaction extends StatelessWidget {
  // const editTransaction({Key key}) : super(key: key);
  Transaction txn;
  editTransaction(this.txn);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: editTransactionPage(),
    );
  }

}

class editTransactionPage extends StatefulWidget {
  Transaction txn2;
  @override
  State<editTransactionPage> createState() => _editTransactionPage(this.txn2);
}

class _editTransactionPage extends State<editTransactionPage>{
  Transaction txn2;
  _editTransactionPage(this.txn2);

  final DbTrans_Manager dbTrans_manager = new DbTrans_Manager();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _timeController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  List<Transaction> translist;
  int updateIndex;
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const list_color =  Color(0xFFECECEC);  //grey
  static const action_button =  Color(0xFFF8C8DC);  //pink

  static const List<String> list_type = <String>['Spending', 'Earning'];
  static const List<String> list_spend = <String>['Food', 'Transport','Shopping'];
  static const List<String> list_earn = <String>['Allowance', 'Stock','Work'];
  String type_list = list_type.first;
  String spend_list = list_spend.first;
  String earn_list = list_earn.first;
  
  String _model;
  String _type = list_type.first;
  String type2;
  List<String> _selectType(String typeName){
    return typeName == list_type[0]
        ? list_spend
        : list_earn;
  }
  String _currentType(int typeName){
    String _type2;
    if(typeName==1){
      _type2=list_type.first;
    }
    else{
      _type2 = list_type[1];
    }
    return _type2;
  }


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Edit Record'),
        backgroundColor: navigation_bar,
        foregroundColor: Colors.black,
      ),
      body: ListView(children: <Widget>[
        Form(key:_formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0,0,80,0),
              child: Column(
                children: <Widget>[
                  DropdownButton<String>(
                    value: _currentType(txn2.spendings),
                    dropdownColor: list_color,
                    icon: const Icon(Icons.expand_more),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String value) {
                      // This is called when the user selects an item.
                      setState(() {
                        _type = value;
                        _model=_selectType(_type).first;
                        print(value);
                        print(_model);
                      });
                    },
                    items: list_type.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                        // icon: Icon(Icons.calendar_today_rounded),
                        labelText: 'Date'),
                    initialValue: txn2.timestamp,
                    controller: _timeController,
                    // validator: (val) => val.isNotEmpty? null:'Date should not be empty',
                    // onTap: ()async {
                    //   DateTime pickeddate = await showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(2021),
                    //       lastDate: DateTime(2023),
                    //   );
                    //   if(pickeddate!=null){
                    //     setState(() {
                    //       _timeController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                    //     });
                    //   }
                    // },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Name'),
                    initialValue: txn2.name,
                    controller: _nameController,
                    // validator: (val) => val.isNotEmpty? null:'Name should not be empty',
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Amount'),
                    initialValue: txn2.amount as String,
                    controller: _amountController,
                    // validator: (val) => val.isNotEmpty? null:'Amount should not be empty',
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text('Category',style: TextStyle(fontSize: 15,color: Colors.grey[700]),),
                        padding: EdgeInsets.only(right:15.0)),

                      DropdownButton<String>(
                        value:txn2.category,
                        // value: _model =_selectType(_type).first,
                        dropdownColor: list_color,
                        icon: const Icon(Icons.expand_more),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _model = value;
                            print(value);
                          });
                        },
                        items: _selectType(_type).map<DropdownMenuItem<String>>((String value) {
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
                    initialValue: txn2.note,
                    controller: _noteController,
                  ),

                  ElevatedButton(
                      onPressed: (){
                        // how to get index of clicked transaction?
                        _editTransaction(context);
                      },
                      child: Text('Save Changes'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        primary: confirm_button,  //background
                        onPrimary: Colors.black, //foreground
                      )
                  ),
                  ElevatedButton(
                      onPressed: (){
                        dbTrans_manager.deleteTransaction(txn2.id);
                        setState(() {
                          translist.removeAt(txn2.id);
                        });
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        primary: action_button,  //background
                        onPrimary: Colors.black, //foreground
                      )
                  ),
                ],
              ),
            )
        ),
      ],
      )
  );

  void _editTransaction(BuildContext context){
    txn2.name = _nameController.text;
    txn2.amount = _amountController.text as double;
    txn2.category=_model;
    txn2.note=_noteController.text;
    txn2.timestamp = _timeController.text;
    int spendings;
    if(_type=="Spending"){
      spendings=1;
    }
    else{
      spendings=0;
    }
    txn2.spendings = spendings;

    dbTrans_manager.updateTransaction(txn2).then((id) =>{
      setState((){
        translist[updateIndex].name = _nameController.text;
        translist[updateIndex].amount = _amountController.text as double;
        translist[updateIndex].category=_model;
        translist[updateIndex].note=_noteController.text;
        translist[updateIndex].timestamp = _timeController.text;
        int spendings;
        if(_type=="Spending"){
          spendings=1;
        }
        else{
          spendings=0;
        }
        translist[updateIndex].spendings = spendings;
      }),
      _nameController.clear(),
      _amountController.clear(),
      _noteController.clear(),
      _timeController.clear(),
      txn2=null
    });
  }
}

