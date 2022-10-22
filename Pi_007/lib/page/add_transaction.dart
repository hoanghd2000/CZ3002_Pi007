import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:pi_007/main.dart';
import 'package:pi_007/page/transactions_page.dart';
import 'package:intl/intl.dart';

import '../databases/db_categories.dart';

class addTransaction extends StatelessWidget {
  const addTransaction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: addTransactionPage(),
    );
  }
}

class addTransactionPage extends StatefulWidget {
  @override
  State<addTransactionPage> createState() => _addTransactionPage();
}

class _addTransactionPage extends State<addTransactionPage> {
  final DbTrans_Manager dbTrans_manager = new DbTrans_Manager();
  static final DbCats_Manager dbCats_manager = new DbCats_Manager();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _timeController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  final _formKey = new GlobalKey<FormState>();

  Transaction transaction;
  // List<Transaction> translist;
  // int updateIndex;

  static const confirm_button = Color(0xFFB4ECB4); //green
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const list_color = Color(0xFFECECEC); //grey

  static const List<String> list_type = <String>['Spending', 'Earning'];
  List<Category> list_spend;
  List<Category> list_earn;
  String type_list = list_type.first;
  Category spend_list;
  Category earn_list;

  String _model;
  String _type = list_type.first;
  // List<String> _selectType(String typeName) {
  //   return typeName == list_type[0] ? list_spend : list_earn;
  // }
  //
  // String _currentType(String type) {
  //   _model = _selectType(type).first;
  //   return _model;
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Add Manually'),
        backgroundColor: navigation_bar,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
              future: dbCats_manager.getAllCategory(),
              builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                if (snapshot.hasData) {
                  list_earn = snapshot.data.where((element) => element.isSpending == 0).toList();
                  earn_list = list_earn.first;
                  list_spend = snapshot.data.where((element) => element.isSpending == 1).toList();
                  spend_list = list_spend.first;
                  List<Category> _selectType(String typeName) {
                    return typeName == list_type[0] ? list_spend : list_earn;
                  }
                  String _currentType(String type) {
                    _model = _selectType(type).first.name;
                    return _model;
                  }

                  return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50,50,50,0),
                        child: Column(
                          children: <Widget>[
                            DropdownButton<String>(
                              value: _type,
                              dropdownColor: list_color,
                              icon: const Icon(Icons.expand_more),
                              elevation: 16,
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String value) {
                                // This is called when the user selects an item.
                                print("Test");
                                setState(() {
                                  print("Test");
                                  _type = value;
                                  print("Test");
                                  _model = _selectType(_type).first.name;
                                  print(value); // error
                                  print(_model);
                                });
                              },
                              items: list_type
                                  .map<DropdownMenuItem<String>>((String value) {
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
                              controller: _timeController,
                              validator: (val) =>
                              val.isNotEmpty ? null : 'Date should not be empty',
                              onTap: () async {
                                DateTime pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2031),
                                );
                                if (pickeddate != null) {
                                  setState(() {
                                    _timeController.text =
                                        DateFormat('yyyy-MM-dd').format(pickeddate);
                                  });
                                }
                              },
                            ),
                            TextFormField(
                              decoration: new InputDecoration(labelText: 'Name'),
                              controller: _nameController,
                              validator: (val) =>
                              val.isNotEmpty ? null : 'Name should not be empty',
                            ),
                            TextFormField(
                              decoration: new InputDecoration(labelText: 'Amount'),
                              controller: _amountController,
                              validator: (val) =>
                              val.isNotEmpty ? null : 'Amount should not be empty',
                            ),
                            // PROBLEM IS HERE
                            Row(
                              children: [
                                Container(
                                    child: Text(
                                      'Category',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey[700]),
                                    ),
                                    padding: EdgeInsets.only(right: 15.0)),
                                DropdownButton<String>(
                                  value: _model,
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
                                  items: _selectType(_type)
                                      .map<DropdownMenuItem<String>>((Category value) {
                                    return DropdownMenuItem<String>(
                                      value: value.name,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            TextFormField(
                              decoration: new InputDecoration(labelText: 'Note'),
                              controller: _noteController,
                            ),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(120, 20, 120, 0),
                                    child: ElevatedButton(
                                        onPressed: () => _submitTransaction(context),
                                        child: Text('Save'),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          primary: confirm_button, //background
                                          onPrimary: Colors.black, //foreground
                                        )
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ));}}
          ),
        ],
      ));

  void _submitTransaction(BuildContext context) {
    if (_formKey.currentState.validate()) {
      if (transaction == null) {
        int spendings;
        if (_type == "Spending") {
          spendings = 1;
        } else {
          spendings = 0;
        }
        Transaction tr = new Transaction(
          spendings: spendings,
          timestamp: _timeController.text,
          name: _nameController.text,
          amount: double.parse(_amountController.text),
          category: _model,
          note: _noteController.text,
        );
        //after transaction is added, clear the textfields
        dbTrans_manager.insertTransaction(tr).then(
              (id) => {
            _timeController.clear(),
            _nameController.clear(),
            _amountController.clear(),
            _noteController.clear(),
            print('Transaction added to Trans_database ${id}'),
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp()))
          },
        );
      }
    }
  }
}
