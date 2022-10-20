import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:pi_007/page/category_page.dart';

class EditCategory extends StatefulWidget {
  final Categories category;
  EditCategory(this.category);

  @override
  State<EditCategory> createState() => _editCategoryPage();
}

class _editCategoryPage extends State<EditCategory> {
  Categories category = null;

  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const confirm_button = Color(0xFFB4ECB4); //green

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

  final _formKey = GlobalKey<FormState>();
  var _categoryNameController = TextEditingController();
  var _categoryIconController = TextEditingController();
  String _categoryTypeController;

  static const List<String> list_type = <String>['Spending', 'Earning'];

  @override
  void initState() {
    super.initState();
    category = widget.category; //here var is call and set to
    _categoryIconController = TextEditingController(text: category.icon.toString());
    _categoryNameController = TextEditingController(text: category.title);
    _categoryTypeController = category.isSpending == 1 ? "Spending" : "Earning";
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
        backgroundColor: navigation_bar,
        foregroundColor: Colors.black,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                IconPicker(
                  // initialValue: category.icon.toString(),
                  icon: Icon(Icons.apps),
                  labelText: "Select an icon",
                  title: "Select an icon",
                  cancelBtn: "CANCEL",
                  enableSearch: true,
                  searchHint: 'Search icon',
                  iconCollection: myIconCollection,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                  controller: _categoryIconController
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                  ),
                  child: TextFormField(
                    decoration: new InputDecoration(labelText: 'Category Name'),
                    controller: _categoryNameController,
                    validator: (val) =>
                    val.isNotEmpty ? null : 'Name should not be empty',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                  ),
                  child: DropdownButtonFormField(
                    decoration: new InputDecoration(labelText: 'Category Type'),
                    value: _categoryTypeController,
                    onChanged: (val) {
                      setState(() {
                        _categoryTypeController = val;
                      });
                    },
                    validator: (val) {
                      if (val?.isEmpty ?? true) {
                        return 'Type should not be empty';
                      }
                    },
                    items: list_type.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0
                  ),
                  child: TextButton(
                    onPressed: () => _submitEdittedCategory(context),
                    child: Text("Done"),
                    style: TextButton.styleFrom(
                      backgroundColor: confirm_button,
                      primary: Colors.black,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                )
              ],
            ),
          )
      )
  );

  void _submitEdittedCategory(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Navigator.pop(context);
      print(_categoryIconController.text);
      print(_categoryNameController.text);
    }
  }

}