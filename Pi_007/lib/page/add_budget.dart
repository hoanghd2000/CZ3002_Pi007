import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_budget.dart';
import 'package:intl/intl.dart';

class AddBudget extends StatelessWidget {
  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  const AddBudget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Add Budget'),
          backgroundColor: navigation_bar,
          foregroundColor: Colors.black,
        ),
        body: addBudgetPage(),
      );
}

class addBudgetPage extends StatefulWidget {
  @override
  State<addBudgetPage> createState() => _addBudgetPage();
}

class _addBudgetPage extends State<addBudgetPage> {
  // colors
  static const confirm_button = Color(0xFFB4ECB4); //green

  final _formKey = GlobalKey<FormState>();

  final _timeController = TextEditingController();
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();

  final dbBudget_manager budgetDBM = dbBudget_manager();

  DateTime _startTime = null;
  DateTime _endTime = null;

  Budget budget;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: new InputDecoration(labelText: 'Date'),
                      controller: _timeController,
                      validator: (val) =>
                          val.isNotEmpty ? null : 'Date should not be empty',
                      onTap: () async {
                        DateTimeRange pickeddate = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2022, 1, 1),
                          lastDate: DateTime(2030, 12, 31),
                          currentDate: DateTime.now(),
                          saveText: 'Save',
                        );
                        if (pickeddate != null) {
                          setState(() {
                            _timeController.text = DateFormat('yyyy-MM-dd')
                                    .format(pickeddate.start) +
                                " to " +
                                DateFormat('yyyy-MM-dd').format(pickeddate.end);
                            _startTime = pickeddate.start;
                            _endTime = pickeddate.end;
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      controller: _nameController,
                      validator: (val) =>
                          val.isNotEmpty ? null : 'Name should not be empty',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Amount"),
                      controller: _amountController,
                                          validator: (val) =>
                          val.isNotEmpty ? null : 'Amount should not be empty',),
                  ),
                  // TextButton(onPressed: (){Navigator.pop(context, [_startTime, _endTime, _amountController.text, _nameController.text]);}, child: Text("Done"), style: TextButton.styleFrom(
                  TextButton(
                    onPressed: () => _submitBudget(context),
                    child: Text("Save"),
                    style: TextButton.styleFrom(
                      backgroundColor: confirm_button,
                      primary: Colors.black,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                ]))),
      );

  void _submitBudget(BuildContext context) {
    if (_formKey.currentState.validate()) {
      if (budget == null) {
        Budget b = Budget(
            name: _nameController.text,
            amount: double.parse(_amountController.text),
            startTime: _timeController.text.substring(0, 10),
            endTime: _timeController.text.substring(14));

        //after transaction is added, clear the textfields
        budgetDBM.insertBudget(b).then(
              (id) => {
                _timeController.clear(),
                _amountController.clear(),
                _nameController.clear(),
                print('Budget added to budget database ${id}'),
                Navigator.pop(context)
              },
            );
      }
    }
  }
}
