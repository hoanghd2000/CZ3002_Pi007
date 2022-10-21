import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pi_007/page/budget_page.dart';
import 'package:pi_007/databases/db_budget.dart';
import '../main.dart';

class EditBudget extends StatefulWidget {
  final Budget budget;
  EditBudget(this.budget);

  @override
  State<EditBudget> createState() => _editBudgetPage();
}

class _editBudgetPage extends State<EditBudget> {
  Budget budget = null;

  // colors
  static const navigation_bar = Color(0xFFFFEAD1); //beige
  static const main_section = Color(0xFFC9C5F9); //purple
  static const action_button = Color(0xFFF8C8DC); //pink
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const secondary_section = Color(0xFFC5E0F9); //blue
  static const list_color = Color(0xFFECECEC); //grey
  static const cancel_button = Color(0xFFFA7979);

  final _formKey = GlobalKey<FormState>();
  var _timeController = TextEditingController();
  var _budgetController = TextEditingController();
  var _nameController = TextEditingController();

  final dbBudget_manager budgetDBM = dbBudget_manager();

  DateTime _startDate = null;
  DateTime _endDate = null;

  @override
  void initState() {
    super.initState();
    budget = widget.budget; //here var is call and set to
    _timeController = TextEditingController(
        text: widget.budget.startTime + " to " + widget.budget.endTime);
    _budgetController =
        TextEditingController(text: widget.budget.amount.toString());
    _nameController = TextEditingController(text: widget.budget.name);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Budget'),
          backgroundColor: navigation_bar,
          foregroundColor: Colors.black,
        ),
        body: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Date"),
                  // initialValue: DateFormat('yyyy-MM-dd')
                  //         .format(DateTime.parse(budget.startTime)) +
                  //     " to " +
                  //     DateFormat('yyyy-MM-dd')
                  //         .format(DateTime.parse(budget.endTime)),
                  controller: _timeController,
                  validator: (val) =>
                      val.isNotEmpty ? null : 'Date should not be empty',
                  // onTap: ()async {
                  //   DateTimeRange pickeddate = await showDateRangePicker(
                  //     context: context,
                  //     firstDate: DateTime(2022, 1, 1),
                  //     lastDate: DateTime(2030, 12, 31),
                  //     currentDate: DateTime.now(),
                  //     saveText: 'Done',
                  //   );
                  //   if(pickeddate!=null){
                  //     (context as Element).markNeedsBuild();
                  //     setState(() {
                  //       _timeController.text = DateFormat('yyyy-MM-dd').format(pickeddate.start) + " to " + DateFormat('yyyy-MM-dd').format(pickeddate.end);
                  //     });
                  //   }
                  // },
                  onTap: () async {
                    DateTimeRange pickeddate = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2022, 1, 1),
                      lastDate: DateTime(2030, 12, 31),
                      currentDate: DateTime.now(),
                      saveText: 'Save',
                    );
                    if (pickeddate != null) {
                      (context as Element).markNeedsBuild();
                      setState(() {
                        _timeController.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate.start) +
                                " to " +
                                DateFormat('yyyy-MM-dd').format(pickeddate.end);
                        _startDate = pickeddate.start;
                        _endDate = pickeddate.end;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  // initialValue: budget.name,
                  controller: _nameController,
                  validator: (val) =>
                      val.isNotEmpty ? null : 'Name should not be empty',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Amount"),
                  // initialValue: budget.amount.toString(),
                  controller: _budgetController,
                  validator: (val) =>
                      val.isNotEmpty ? null : 'Amount should not be empty',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: TextButton(
                      onPressed: () {
                        _showAlertDialog(context, budget.id);
                      },
                      child: Text("Delete"),
                      style: TextButton.styleFrom(
                        backgroundColor: cancel_button,
                        primary: Colors.black,
                        padding: EdgeInsets.only(left: 30, right: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _editBudget(context),
                    child: Text("Save"),
                    style: TextButton.styleFrom(
                      backgroundColor: confirm_button,
                      primary: Colors.black,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                ],
              ),
            ])),
      );

  void _editBudget(BuildContext context) {
    if (_formKey.currentState.validate()) {
      widget.budget.name = _nameController.text;
      widget.budget.amount = double.parse(_budgetController.text);
      widget.budget.startTime = _timeController.text.substring(0, 10);
      widget.budget.endTime = _timeController.text.substring(14);

      // print('before updating transaction with id ${updateIndex}');

      budgetDBM.updateBudget(widget.budget).then((id) => {
            setState(() {
              print("index ${budget.id} updated");
            }),
            _nameController.clear(),
            _budgetController.clear(),
            _timeController.clear(),
            Navigator.pop(context)
          });
    }

    // if (_startDate == null) {
    //   _startDate = DateTime.parse(widget.budget.startTime);
    // }
    // if (_endDate == null) {
    //   _endDate = DateTime.parse(widget.budget.endTime);
    // }

    // Budget edittedBudget = Budget(name: _nameController.text, amount: double.parse(_budgetController.text), startTime: _timeController.text.substring(0, 10), endTime: _timeController.text.substring(14));
    // budgetDBM.updateBudget(edittedBudget).then((id) => {
    //   setState(() {
    //     print("index ${id} updated");
    //   }),
    //     _nameController.clear(),
    //     _budgetController.clear(),
    //     _timeController.clear(),
    // });
    // print("edit budget page");
    // print(edittedBudget.id);
    // print(edittedBudget.name);
    // print(edittedBudget.startTime);
    // print(edittedBudget.endTime);
    // print(edittedBudget.amount);

    // // // Navigator.pop(context,
    // //     [_startDate, _endDate, _budgetController.text, _nameController.text]);
    // Navigator.pop(context);
    // // Navigator.of(context)
    // //   .push(MaterialPageRoute(builder: (context) => MyApp()));
  }

  void _showAlertDialog(BuildContext context, int budgetId) {
    final dbBudget_manager budgetDBM = dbBudget_manager();
    // Create button
    Widget okButton = TextButton(
        child: Text("Ok"),
        onPressed: () {
          budgetDBM.deleteBudget(budgetId);
          print("Budget ${budgetId} deleted");
          // setState(() {});
          // Navigator.of(context)..pop()..pop();
          Navigator.of(context).pop(context);
          Navigator.pop(context);
            // Navigator.of(context)
            //   ..push(MaterialPageRoute(builder: (context) => MyApp()))..push(MaterialPageRoute(builder: (context) => BudgetPage()));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Budget Deleted")));
        });
    // );

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 5.0, bottom: 5.0),
            child: Icon(Icons.delete),
          ),
          Text("Delete Budget"),
        ],
      ),
      content: Text("Are you sure you want to delete this Budget?"),
      actions: [cancelButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
