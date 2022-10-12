import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_007/databases/db_transactions.dart';
import 'package:intl/intl.dart';

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

  static List<IconData> icons = [
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
    Icons.umbrella_sharp,
    Icons.favorite,
    Icons.headphones,
    Icons.home,
    Icons.car_repair,
    Icons.settings,
    Icons.flight,
    Icons.run_circle,
    Icons.book,
    Icons.sports_rugby_rounded,
    Icons.alarm,
    Icons.call,
    Icons.snowing,
    Icons.hearing,
    Icons.music_note,
    Icons.note,
    Icons.edit,
    Icons.sunny,
    Icons.radar,
    Icons.wallet
    // all the icons you want to include
  ];
  Icon _categoryController = null;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        Text("Add Category"),
        IconButton(
            icon: (_categoryController != null) ? _categoryController : Icon(Icons.bubble_chart, color: Colors.black),
            onPressed: (){
              // _categoryController = IconPicker();
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Pick an icon',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: IconPicker(),
                    );
                  }
              );
            },
        ),
      ],
    )
  );

  IconPicker(){
    for (var icon in icons)
      IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: (){
          setState((){
            _categoryController = Icon(icon);
          });
          Navigator.pop(context, _categoryController);
          print(_categoryController);
          return _categoryController;
        },
      );
  }
}