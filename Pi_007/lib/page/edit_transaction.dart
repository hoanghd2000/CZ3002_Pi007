
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:intl/intl.dart';

import '../databases/db_categories.dart';
import '../main.dart';

// class editTransaction extends StatelessWidget {
//   // const editTransaction({Key key}) : super(key: key);
//   Transaction txn;
//   editTransaction(this.txn);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.blue,
//       ),
//       home: editTransactionPage(),
//     );
//   }
//
// }

class editTransactionPage extends StatefulWidget {
  final Transaction txn2;
  editTransactionPage(this.txn2);
  @override
  State<editTransactionPage> createState() => _editTransactionPage();
}

class _editTransactionPage extends State<editTransactionPage>{
  Transaction txn2 = null;

  final DbTrans_Manager dbTrans_manager = new DbTrans_Manager();
  static final DbCats_Manager dbCats_manager = new DbCats_Manager();


  var _nameController = TextEditingController();
  var _amountController = TextEditingController();
  var _noteController = TextEditingController();
  var _timeController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  List<Transaction> translist;
  int updateIndex;
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const list_color =  Color(0xFFECECEC);  //grey
  static const action_button =  Color(0xFFF8C8DC);  //pink

  // Icon List
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

  static const List<String> list_type = <String>['Spending', 'Earning'];
  List<Category> list_spend;
  List<Category> list_earn;
  List<Category> list_all;
  String type_list = list_type.first;

  
  var _model;
  var _type;
  String type2;
  List<Category> _selectType(String typeName){
    return typeName == list_type[0] ? list_spend : list_earn;
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
  void initState() {
    super.initState();
    updateIndex=widget.txn2.id;
    print("update index is ${updateIndex}");
    txn2 = widget.txn2;  //here var is call and set to
     _nameController = TextEditingController(text:widget.txn2.name);
     _amountController = TextEditingController(text:widget.txn2.amount.toString());
     _noteController = TextEditingController(text:widget.txn2.note);
     _timeController = TextEditingController(text:widget.txn2.timestamp);
     _type = _currentType(widget.txn2.spendings);
     _model = widget.txn2.category;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Edit Record'),
        backgroundColor: navigation_bar,
        foregroundColor: Colors.black,
      ),
      body: ListView(children: <Widget>[
        FutureBuilder(
          future:Future.wait([dbCats_manager.getAllCategory(), dbCats_manager.getAllEarningCategories(), dbCats_manager.getAllSpendingCategories()]),
          builder: (BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasData) {
            list_all = snapshot.data[0];
            list_earn = snapshot.data[1];
            list_spend = snapshot.data[2];
            return Form(
                key:_formKey,
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
                          setState(() {
                            _type = value;
                            print(value);
                            _model = _selectType(_type).first.name;
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
                        // initialValue: txn2.timestamp,
                        controller: _timeController,
                        validator: (val) => val.isNotEmpty? null:'Date should not be empty',
                        onTap: ()async {
                          DateTime pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2023),
                          );
                          if(pickeddate!=null){
                            setState(() {
                              _timeController.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                            });
                          }
                        },
                      ),
                      TextFormField(
                        decoration: new InputDecoration(labelText: 'Name'),
                        // initialValue: txn2.name,
                        controller: _nameController,
                        validator: (val) => val.isNotEmpty? null:'Name should not be empty',
                      ),
                      TextFormField(
                        decoration: new InputDecoration(labelText: 'Amount'),
                        // initialValue: txn2.amount as String,
                        controller: _amountController,
                        validator: (val) => val.isNotEmpty? null:'Amount should not be empty',
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text('Category',style: TextStyle(fontSize: 15,color: Colors.grey[700]),),
                            padding: EdgeInsets.only(right:15.0)),

                          DropdownButton<String>(
                            value:_model,
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
                            items: _selectType(_type).map<DropdownMenuItem<String>>((Category value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Row(
                                  children: [
                                    Icon(myIconCollection[value.icon]),
                                    SizedBox(width: 20),
                                    Text(value.name),
                                  ],
                                )
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: new InputDecoration(labelText: 'Note'),
                        // initialValue: txn2.note,
                        controller: _noteController,
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
                            child: ElevatedButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          title: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10.0, top: 5.0, bottom: 5.0),
                                                child: Icon(Icons.delete),
                                              ),
                                              Text("Delete Transaction"),
                                            ],
                                          ),
                                          content: Text("Are you sure you want to delete this Transaction?"),
                                          actions: [
                                            TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  dbTrans_manager.deleteTransaction(widget.txn2.id);
                                                  print("deleted index is ${widget.txn2.id}");
                                                  Navigator.pop(context);
                                                  _navigateBack(context);
                                                }
                                            ),
                                          TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                          Navigator.pop(context);
                                          _navigateBack(context);
                                          },),
                                          ]
                                      ));
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
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100, 20, 0, 0),
                            child: ElevatedButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Saved successfully.'),
                                        actions: [
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              _editTransaction(context);
                                              Navigator.pop(context);
                                            }
                                              ),
                                              ]
                                      ));
                                },
                                child: Text('Save'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  primary: confirm_button,  //background
                                  onPrimary: Colors.black, //foreground
                                )
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                )
            );
          }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      ],
      )
  );

  void _editTransaction(BuildContext context) {
    if (_formKey.currentState.validate()) {
      widget.txn2.name = _nameController.text;
      widget.txn2.amount = double.parse(_amountController.text);
      widget.txn2.category = _model;
      widget.txn2.note = _noteController.text;
      widget.txn2.timestamp = _timeController.text;
      int spendings;
      if (_type == "Spending") {
        spendings = 1;
      }
      else {
        spendings = 0;
      }
      widget.txn2.spendings = spendings;
      // print('before updating transaction with id ${updateIndex}');

      dbTrans_manager.updateTransaction(widget.txn2).then((id) =>
      {
          setState(() {
          print("index ${txn2.id} updated");
        }),
        _nameController.clear(),
        _amountController.clear(),
        _noteController.clear(),
        _timeController.clear(),
        _navigateBack(context)
      });
    }

  }
}

void _navigateBack(BuildContext context) {
  // Navigator.pop(context);
  // Navigator.pop(context);
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => MyApp()));
  // Navigator.pushNamed(
  //   context,
  //   'Transactions',
  //   // arguments: noteId,
  // );
  // // _refreshData();
}
