import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:icon_picker/icon_picker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:pi_007/page/category_page.dart';
import 'package:pi_007/databases/db_categories.dart';

import '../databases/db_categories.dart';

class EditCategory extends StatefulWidget {
  final Category category;
  EditCategory(this.category);

  @override
  State<EditCategory> createState() => _editCategoryPage();
}

class _editCategoryPage extends State<EditCategory> {
  Category category = null;

  final DbCats_Manager dbCats_manager = new DbCats_Manager();

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
    'grid': Icons.grid_view_sharp,
  };

  final _formKey = GlobalKey<FormState>();
  var _categoryNameController = TextEditingController();
  var _categoryIconController = TextEditingController();
  String _categoryTypeController;

  static const List<String> list_type = <String>['Spending', 'Earning'];

  Icon _icon;

  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context, customIconPack: myIconCollection, iconPackModes: const <IconPack>[IconPack.custom]);

    _icon = Icon(icon);
    setState((){
      var key = myIconCollection.keys.firstWhere((k) => myIconCollection[k] == icon, orElse: () => null);
      _categoryIconController = TextEditingController(text: key.toString());
    });

    debugPrint('Picked Icon:  $icon');
  }

  @override
  void initState() {
    super.initState();
    category = widget.category; //here var is call and set to
    _categoryIconController = TextEditingController(text: category.icon.toString());
    _categoryNameController = TextEditingController(text: category.name);
    print("edit cat:");
    print(category.isSpending);
    _categoryTypeController = category.isSpending == 1 ? list_type[0] : list_type[1];
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Column(
                    children: [
                       Row(
                         children: [
                           SizedBox(
                             width: 30,
                             child: AnimatedSwitcher(
                                 duration: Duration(milliseconds: 300),
                                 child: _icon != null ? _icon : Icon(Icons.category)
                             ),
                           ),
                           SizedBox(width: 15),
                           SizedBox(
                             width: 260,
                             child: TextFormField(
                               decoration: new InputDecoration(labelText: 'Category Icon'),
                               controller: _categoryIconController,
                               onTap: _pickIcon,
                             ),
                           ),
                         ],
                       )
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: new InputDecoration(labelText: 'Category Name'),
                      controller: _categoryNameController,
                      validator: (val) =>
                      val.isNotEmpty ? null : 'Name should not be empty',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: SizedBox(
                    width: 300,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0
                  ),
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
                                      _submitEdittedCategory(context);
                                      Navigator.pop(context);
                                    }
                                ),
                              ]
                          ));
                    },
                    child: Text("Save"),
                    style: TextButton.styleFrom(
                      backgroundColor: confirm_button,
                      primary: Colors.black,
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                )
              ],
            ),
          )
      )
  );

  void _submitEdittedCategory(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      print(_categoryIconController.text);
      print(_categoryNameController.text);

      int isSpending = _categoryTypeController == 'Spending' ? 1 : 0;
      widget.category.name = _categoryNameController.text;
      widget.category.isSpending = isSpending;
      widget.category.icon = _categoryIconController.text;
      await dbCats_manager.updateCategory(widget.category).then((id) =>
      {
        setState(() {
          print("Category index ${category.id} updated");
        }),
        Navigator.pop(context),
        Navigator.pop(context),
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CategoryPage()))
      });
    }
  }

}