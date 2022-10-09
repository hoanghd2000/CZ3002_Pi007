import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {

  static const IconData category = IconData(0xe148, fontFamily: 'MaterialIcons');
  static const IconData grid_view_sharp = IconData(0xe9e5, fontFamily: 'MaterialIcons');
  static const IconData fastfood = IconData(0xe25a, fontFamily: 'MaterialIcons');
  static const IconData car = IconData(0xe1d7, fontFamily: 'MaterialIcons');
  static const IconData shopping_bag = IconData(0xe59a, fontFamily: 'MaterialIcons');


  // colors
  static const navigation_bar =  Color(0xFFFFEAD1);  //beige
  static const main_section =  Color(0xFFC9C5F9);   //purple
  static const action_button =  Color(0xFFF8C8DC);  //pink
  static const confirm_button =  Color(0xFFB4ECB4); //green
  static const secondary_section =  Color(0xFFC5E0F9); //blue
  static const list_color =  Color(0xFFECECEC);  //grey
  static const cancel_button = Color(0xFFFA7979);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        backgroundColor: navigation_bar,
        foregroundColor: Colors.black,
      ),
      body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(category, size: 40),
                Text("Category", style: TextStyle(fontSize: 30)),
                TextButton(
                    onPressed: (){

                    },
                    child: Text("+ Add Category", style: TextStyle(fontSize: 20)),
                  style: TextButton.styleFrom(
                    backgroundColor: action_button,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                )
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 0,
            shape: Border(top: BorderSide(color: Colors.black)),
            child:
            Row(
                children: [
                    Column(children: [
                      IconButton(
                        icon: const Icon(fastfood, color: Colors.black),
                      ),
                    ]),
                    Column(children: [
                      Text("Food",style: TextStyle(fontSize: 20)),
                    ]),
                ]),
            color: Colors.grey[50],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 0,
            shape: Border(top: BorderSide(color: Colors.black)),
            child:
            Row(
                children: [
                  Column(children: [
                    IconButton(
                      icon: const Icon(car, color: Colors.black),
                    ),
                  ]),
                  Column(children: [
                    Text("Transport",style: TextStyle(fontSize: 20)),
                  ]),
                ]),
            color: Colors.grey[50],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 0,
            shape: Border(bottom: BorderSide(color: Colors.black), top: BorderSide(color: Colors.black)),
            child:
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0
              ),
              child: Row(
                  children: [
                    Column(children: [
                      IconButton(
                        icon: const Icon(shopping_bag, color: Colors.black),
                      ),
                    ]),
                    Column(children: [
                      Text("Shopping",style: TextStyle(fontSize: 20)),
                    ]),
                  ]),
            ),
            color: Colors.grey[50],
          ),
        )
      ])
    );
  }
}

class Categories {
  final String title;
  final Icon icon;

  const Categories(this.title, this.icon);
}