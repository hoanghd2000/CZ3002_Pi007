import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/iconPicker.dart';
// import 'package:icon_picker/icon_picker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:pi_007/databases/db_categories.dart';
import 'package:pi_007/page/category_page.dart';

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
  // DB
  final DbCats_Manager dbCats_manager = new DbCats_Manager();

  // colors
  static const confirm_button = Color(0xFFB4ECB4); //green
  static const list_color = Color(0xFFECECEC); //grey

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
  final _categoryNameController = TextEditingController();
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
  Widget build(BuildContext context) => Scaffold(
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
                            width: 300,
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
                  left: 35.0,
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
                  left: 35.0,
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
                child: TextButton(
                  onPressed: () => _submitCategory(context),
                  child: Text("Save"),
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

  void _submitCategory(BuildContext context) async {
    if (_formKey.currentState.validate()) {

      print(_categoryIconController.text);
      print(_categoryNameController.text);
      print(_categoryTypeController);

      int isSpending = _categoryTypeController == 'Spending' ? 1 : 0;

      Category cat = new Category(
        name: _categoryNameController.text,
        isSpending: isSpending,
        icon: _categoryIconController.text
      );

      //after transaction is added, clear the textfields
      await dbCats_manager.insertCategory(cat).then(
            (id) => {
              //_categoryTypeController = '',
              // _categoryIconController.clear(),
              // _categoryNameController.clear(),
              print('Category added to Cats_database ${id}'),
              Navigator.pop(context),
              Navigator.pop(context),
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CategoryPage()))
        },
      );
    }
  }

}