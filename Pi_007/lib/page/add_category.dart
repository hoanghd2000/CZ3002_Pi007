import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_picker/icon_picker.dart';

class AddCategory extends StatelessWidget {
  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  const AddCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Add Category'),
      backgroundColor: navigation_bar,
      foregroundColor: Colors.black,
    ),
    body: addCategoryPage(),
  );

}

class addCategoryPage extends StatefulWidget {
  @override
  State<addCategoryPage> createState() => _addCategoryPage();
}


class _addCategoryPage extends State<addCategoryPage>{

  // colors
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
  };

  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  final _categoryIconController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              IconPicker(
                // initialValue: 'favorite',
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
                  top: 15.0
                ),
                child: TextButton(
                  onPressed: () => _submitCategory(context),
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

  void _submitCategory(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Navigator.pop(context);
      print(_categoryIconController.text);
      print(_categoryNameController.text);
    }
  }

}